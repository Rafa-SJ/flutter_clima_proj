import 'package:flutter_clima/services/wsmanager.dart';

import '../apis/weathergettersapi.dart';

class ServicesSearchLocation {
  static Future<String> getLocationsByName(Map<String, dynamic> data) async {
    return await WsManager.get(ApiWeatherGetters.listOfLocationsName(), data);
  }
}
