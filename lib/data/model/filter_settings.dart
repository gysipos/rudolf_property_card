import 'dart:developer';

class FilterSettings {
  FilterSettings(
      this.name, this.assignmentType, this.estateTypes, this.locations,
      {this.minFloorArea, this.maxFloorArea, this.minPrice, this.maxPrice});

  factory FilterSettings.fromJson(Map<String, dynamic> json) {
    try {
      List<EstateType> types = [];
      List<String> loc = [];

      for (var element in (json['estateTypes'] as List<dynamic>)) {
        types.add(EstateType.fromString(element)!);
      }

      for (var aLoc in (json['locations'] as List<dynamic>)) {
        String locationName = aLoc['adminLevels']['8'];
        loc.add(locationName);
      }

      return FilterSettings(json['name'],
          AssignmentType.fromString(json['assignmentType'])!, types, loc,
          minPrice: json['minPrice'],
          maxPrice: json['maxPrice'],
          minFloorArea: json['minFloorArea'],
          maxFloorArea: json['maxFloorArea']);
    } catch (exception) {
      log(exception.toString());
      throw ('JSON parsing failed.');
    }
  }

  String name;
  AssignmentType assignmentType;
  List<EstateType> estateTypes;
  List<String> locations;
  int? minFloorArea;
  int? maxFloorArea;
  int? minPrice;
  int? maxPrice;

  String get searchType {
    String info = assignmentType.toString();

    for (var element in estateTypes) {
      info += ' $element';
    }

    return info;
  }

  String get locationNames => locations.join(', ');

  String get priceRange {
    var min = (minPrice ?? 0) * 1.0 / 1000000;
    var max = (maxPrice ?? 0) * 1.0 / 1000000;

    var strMin = '${min.toInt().toString()} ';
    var strMax = max > 0 ? '- ${max.toInt().toString()} ' : '';
    var postfix = 'millió forint';

    return '$strMin$strMax$postfix';
  }

  String get areaInfo {
    var strMin = minFloorArea != null ? '$minFloorArea ' : '';
    var strMax = maxFloorArea != null ? '- $maxFloorArea ' : '+';
    var unit = 'm2';
    return '$strMin$strMax$unit';
  }

  @override
  String toString() {
    return '$name, $assignmentType, $estateTypes, $locations, $minPrice, $maxPrice, $minFloorArea, $maxFloorArea';
  }
}

enum AssignmentType {
  forSale,
  forRent;

  static AssignmentType? fromString(String s) {
    if (s == 'FOR_SALE') {
      return forSale;
    } else if (s == 'FOR_RENT') {
      return forRent;
    } else {
      return null;
    }
  }

  @override
  String toString() {
    switch (this) {
      case forSale:
        return "eladó";
      case forRent:
        return "kiadó";
    }
  }
}

enum EstateType {
  house,
  apartment,
  site;

  static EstateType? fromString(String s) {
    if (s == 'HOUSE') {
      return house;
    } else if (s == 'APARTMENT') {
      return apartment;
    } else if (s == 'SITE') {
      return site;
    } else {
      return null;
    }
  }

  @override
  String toString() {
    switch (this) {
      case house:
        {
          return "Ház";
        }

      case apartment:
        {
          return "Lakás";
        }

      case site:
        {
          return "Telek";
        }
    }
  }
}
