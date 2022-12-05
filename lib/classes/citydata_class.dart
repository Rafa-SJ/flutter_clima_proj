import 'localnames_class.dart';

class CityData {
  String? name;
  LocalNames? localnames;
  double? lat;
  double? lon;
  String? country;
  String? state;

  CityData(
      {this.name,
      this.localnames,
      this.lat,
      this.lon,
      this.country,
      this.state});

  CityData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    localnames = json['local_names'] != null
        ? LocalNames?.fromJson(json['local_names'])
        : null;
    lat = double.parse(json['lat'].toString());
    lon = double.parse(json['lon'].toString());
    country = json['country'];
    state = json['state'];
  }
}
