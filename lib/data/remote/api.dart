import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:property_card/data/model/filter_settings.dart';

class Api {
  Api._();

  final String _firebaseDbUrl =
      "https://realmon-1aaec-default-rtdb.europe-west1.firebasedatabase.app/monitors.json";

  // It is only for local testing
  final String _data = """{
    "isNotificationEnabled": true,
    "privateAdvertisersOnly": false,
    "filterOutSuspiciousItems": true,
    "onlyPolisWithPictures": true,
    "nameSpace": "hu",
    "locations": [
      {
        "accessTokens": [
          "v1-NGjMb89DhXVjdFH2qe2Y9s9nivaCNaDNCDmkvsdRhok"
        ],
        "adminLevels": {
          "6": "Nógrád megye",
          "8": "Zabar"
        },
        "nameSpace": "hu",
        "ids": [
          "ChIJG2dAGsJwQEcRAHgeDCnEAAQ"
        ]
      },
      {
        "accessTokens": [
          "v1-lv3CMtHjZyVTRCqNyCEmHsakmSAMa0bpsxi3Wr1QjqE"
        ],
        "adminLevels": {
          "6": "Veszprém",
          "8": "Csesznek"
        },
        "nameSpace": "hu",
        "ids": [
          "ChIJTZZvGMgqakcRQGAeDCnEAAQ"
        ]
      }
    ],
    "name": "Sus",
    "assignmentType": "FOR_SALE",
    "estateTypes": [
      "HOUSE"
    ],
    "createTime": 1658740743732,
    "usesUmbrella": true,
    "id": null,
    "minPrice": 69000000,
    "maxPrice": 420000000,
    "minFloorArea": 80,
    "maxFloorArea": null,
    "minUnitPrice": null,
    "maxUnitPrice": null
  }""";

  static final _instance = Api._();

  factory Api() => _instance;

  Future<FilterSettings> getSettings() async {
    log('USING LOCALLY STORED TEST DATA...');
    return Future.delayed(const Duration(seconds: 3),
        () => FilterSettings.fromJson(json.decode(_data)));
  }

  Future<FilterSettings> fetchSettingsFromFirebase() async {
    log('FETCHING FROM FIREBASE...');
    final response = await http.get(Uri.parse(_firebaseDbUrl));
    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      return FilterSettings.fromJson(jsonResponse[0]);
    } else {
      throw ('Fetching data failed');
    }
  }
}
