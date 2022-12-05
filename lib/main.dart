import 'package:flutter/material.dart';
import 'package:flutter_clima/pages/first_page.dart';
import 'package:flutter_clima/pages/second_page.dart';
import 'package:flutter_clima/providers/customcity_provider.dart';
import 'package:flutter_clima/providers/searchcity_provider.dart';
import 'package:provider/provider.dart';

import 'providers/currentlocation_provider.dart';
import 'services/configreader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigReader.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider(create: (context) => ProviderCurrentLocation()),
        ListenableProvider(create: (context) => ProviderCustomCity()),
        ListenableProvider(create: (context) => ProviderSearchCity()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        themeMode: ThemeMode.light,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const FirstPage(),
          '/second': (context) => const SecondPage(),
        },
      ),
    );
  }
}
