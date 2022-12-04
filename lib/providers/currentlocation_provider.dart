import 'package:flutter/material.dart';
import 'package:flutter_clima/classes/locationdetail_class.dart';
import 'package:geolocator/geolocator.dart';

class ProviderCurrentLocation extends ChangeNotifier {
  late String locationUnavailableMessage;
  bool gettingLocation = true;
  bool isLocationAvailable = true;
  Position? location;
  LocationDetail? detalle;

  void isGettingLocation(bool isgetting) {
    gettingLocation = isgetting;
    notifyListeners();
  }

  void saveCurrentLocationData(Map<String, dynamic> result) {
    detalle = LocationDetail.fromJson(result);
    notifyListeners();
  }

  String getWeatherDescription() {
    return detalle?.weather?.first?.description ?? "";
  }

  String getWeatherActualTemp() {
    String tempActual = "0º";
    try {
      tempActual = detalle!.main!.temp!.round().toString();
      tempActual += "º";
    } catch (e) {}
    return tempActual;
  }

  String getCityName() {
    return detalle?.name ?? "";
  }

  String getHumidity() {
    return detalle?.main?.humidity.toString() ?? "";
  }

  String getActualWeatherIcon() {
    return "http://openweathermap.org/img/wn/${detalle?.weather?.first?.icon}@2x.png";
  }
}
