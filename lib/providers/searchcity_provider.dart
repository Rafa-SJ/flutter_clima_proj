import 'package:flutter/material.dart';
import 'package:flutter_clima/classes/citydata_class.dart';
import 'package:flutter_clima/classes/coord_class.dart';

class ProviderSearchCity extends ChangeNotifier {
  bool searching = false;
  String citysearched = "";
  List<CityData>? citiesAvailables;

  void setCitySearch(String input) {
    citysearched = input;
  }

  void saveCitiesAvailables(List<dynamic> result) {
    List<CityData> tempList = [];
    for (var i = 0; i < result.length; i++) {
      tempList.add(CityData.fromJson(result[i]));
    }
    citiesAvailables = tempList;
    notifyListeners();
  }

  void changeStateSearching(bool state) {
    searching = state;
    notifyListeners();
  }

  String getCityNameByIndex(int index) {
    return "${citiesAvailables?[index].name}, ${citiesAvailables?[index].country}";
  }

  Coord getCoodByIndex(int index) {
    return Coord(
        lat: citiesAvailables![index].lat, lon: citiesAvailables![index].lon);
  }

  void cleanAll() {
    citysearched = "";
    citiesAvailables = [];
  }
}
