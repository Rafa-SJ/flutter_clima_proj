class Wind {
  double? speed;
  int? deg;

  Wind({this.speed, this.deg});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = double.parse(json['speed'].toString());
    deg = json['deg'];
  }
}
