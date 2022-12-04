import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ProviderCurrentLocation extends ChangeNotifier {
  late String locationUnavailableMessage;
  Position? location;
}
