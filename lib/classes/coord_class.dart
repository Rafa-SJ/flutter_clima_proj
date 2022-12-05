class Coord {
  double? lon;
  double? lat;

  Coord({this.lon, this.lat});

  Coord.fromJson(Map<String, dynamic> json) {
    lon = double.parse(json['lon'].toString());
    lat = double.parse(json['lat'].toString());
  }
}
