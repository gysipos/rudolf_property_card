import 'package:flutter/material.dart';
import 'data/model/filter_settings.dart';
import 'data/remote/api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Hind',
        textTheme: const TextTheme(
          titleMedium: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
          bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Figyelések'),
        ),
        body: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Api api = Api();

  FilterSettings? _settings;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    api.fetchSettingsFromFirebase().then((value) {
      setState(() {
        _settings = value;
      });
    }).catchError((error) {
      setState(() {
        _errorMessage = error.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_errorMessage != null) {
      return infoOnError(context);
    } else {
      if (_settings == null) {
        return loadingIndicator(context);
      } else {
        return realEstateSearchSummaryItem();
      }
    }
  }

  Widget realEstateSearchSummaryItem() {
    return Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        height: 360,
        width: double.maxFinite,
        child: Card(
          elevation: 5,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      _settings?.name ?? '',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      _settings?.searchType ?? '',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 215, 219, 224),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Text(
                        _settings?.locationNames ?? '',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const Divider(
                      thickness: 1.0,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Ár',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            _settings?.priceRange ?? '',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1.0,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Alapterület',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            _settings?.areaInfo ?? '',
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Icon(
                      Icons.delete,
                      color: Color.fromARGB(255, 4, 15, 32),
                      size: 24.0,
                    ),
                    Icon(
                      Icons.notifications,
                      color: Color.fromARGB(255, 4, 15, 32),
                      size: 30.0,
                    ),
                    Icon(
                      Icons.edit,
                      color: Color.fromARGB(255, 4, 15, 32),
                      size: 36.0,
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget loadingIndicator(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 100.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CircularProgressIndicator(
              value: null,
              strokeWidth: 7.0,
            ),
            Text(
              'Adatok letöltése folyamatban...',
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
      ),
    );
  }

  Widget infoOnError(BuildContext context) {
    return Center(
        child: SizedBox(
            height: 100.0,
            width: 300.0,
            child: Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
            )));
  }
}
