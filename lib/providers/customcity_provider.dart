import 'package:flutter/material.dart';
import 'package:flutter_clima/providers/currentlocation_provider.dart';

class ProviderCustomCity extends ProviderCurrentLocation {
  void cleanAll() {
    detalle = null;
    gettingLocation = false;
    notifyListeners();
  }
}
