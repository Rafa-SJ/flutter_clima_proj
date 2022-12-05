class Main {
  double? temp;
  double? feelslike;
  double? tempmin;
  double? tempmax;
  int? pressure;
  int? humidity;

  Main(
      {this.temp,
      this.feelslike,
      this.tempmin,
      this.tempmax,
      this.pressure,
      this.humidity});

  Main.fromJson(Map<String, dynamic> json) {
    temp = double.parse(json['temp'].toString());
    feelslike = double.parse(json['feels_like'].toString());
    tempmin = double.parse(json['temp_min'].toString());
    tempmax = double.parse(json['temp_max'].toString());
    pressure = json['pressure'];
    humidity = json['humidity'];
  }
}
