import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ProviderCurrentLocation extends ChangeNotifier {
  late String locationUnavailableMessage;
  bool gettingLocation = true;
  bool isLocationAvailable = true;
  Position? location;

  void isGettingLocation(bool isgetting) {
    gettingLocation = isgetting;
    notifyListeners();
  }
}
