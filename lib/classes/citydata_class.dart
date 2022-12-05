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
    lat = json['lat'];
    lon = json['lon'];
    country = json['country'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['local_names'] = localnames!.toJson();
    data['lat'] = lat;
    data['lon'] = lon;
    data['country'] = country;
    data['state'] = state;
    return data;
  }
}
