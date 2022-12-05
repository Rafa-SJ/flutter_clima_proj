import 'package:flutter/material.dart';

class ProviderSearchCity extends ChangeNotifier {
  String citysearched = "";
  Map<String, dynamic>? citiesAvailables;

  void setCitySearch(String input) {
    citysearched = input;
  }
}
