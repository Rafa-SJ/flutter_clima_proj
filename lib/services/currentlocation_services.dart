import 'package:flutter/material.dart';
import 'package:flutter_clima/apis/weathergettersapi.dart';
import 'package:flutter_clima/services/wsmanager.dart';
import 'package:geolocator/geolocator.dart';

class ServicesCurrentLocation {
  static Future<Position> getDeviceLocation() async {
    bool isServiceEnabled;
    LocationPermission permission;
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      return Future.error(Exception('El gps se encuentra desactivado'));
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission == await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          return Future.error(
            Exception(
                'Los permisos de acceso a la ubicación han sido denegados'),
          );
        }
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        Exception(
            'Los permisos de acceso a la ubicación han sido bloqueados para siempre'),
      );
    }
    return await Geolocator.getCurrentPosition();
  }

  static Future<String> getGeoPositionWeatherData(
      Map<String, dynamic> data) async {
    return await WsManager.get(ApiWeatherGetters.geoLocationData(), data);
  }

  static Future<String> getForecastWeather(Map<String, dynamic> data) async {
    return await WsManager.get(ApiWeatherGetters.getForecast(), data);
  }
}
