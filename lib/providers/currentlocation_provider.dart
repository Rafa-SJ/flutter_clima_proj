import 'package:flutter/material.dart';
import 'package:flutter_clima/classes/locationdetail_class.dart';
import 'package:geolocator/geolocator.dart';

class ProviderCurrentLocation extends ChangeNotifier {
  late String locationUnavailableMessage;
  bool gettingLocation = true;
  bool isLocationAvailable = true;
  Position? location;
  LocationDetail? detalle;
  List<LocationDetail>? forecastDaily;

  void isGettingLocation(bool isgetting) {
    gettingLocation = isgetting;
    notifyListeners();
  }

  void saveCurrentLocationData(Map<String, dynamic> result) {
    detalle = LocationDetail.fromJson(result);
    notifyListeners();
  }

  void saveForecastLocationData(Map<String, dynamic> result) {
    // forecastDaily = result["list"].foreach((el) => LocationDetail.fromJson(el));
    List<LocationDetail> tempList = [];
    for (var i = 0; i < result["list"].length; i++) {
      tempList.add(LocationDetail.fromJson(result["list"][i]));
    }
    forecastDaily = tempList;
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

  String getMinTemp() {
    String tempMin = "0º";
    try {
      tempMin = detalle!.main!.tempmin!.round().toString();
      tempMin += "º";
    } catch (e) {}
    return tempMin;
  }

  String getMaxTemp() {
    String tempMin = "0º";
    try {
      tempMin = detalle!.main!.tempmax!.round().toString();
      tempMin += "º";
    } catch (e) {}
    return tempMin;
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

  String getForecastWeatherIcon(int index) {
    return "http://openweathermap.org/img/wn/${forecastDaily?[index]?.weather?.first?.icon}@2x.png";
  }

  String getForecastMinTemp(int index) {
    String tempMin = "0º";
    try {
      tempMin = forecastDaily![index].main!.tempmin!.round().toString();
      tempMin += "º";
    } catch (e) {}
    return tempMin;
  }

  String getForecastMaxTemp(int index) {
    String tempMin = "0º";
    try {
      tempMin = forecastDaily![index].main!.tempmax!.round().toString();
      tempMin += "º";
    } catch (e) {}
    return tempMin;
  }
}
