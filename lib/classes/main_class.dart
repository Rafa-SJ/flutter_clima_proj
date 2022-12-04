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
    temp = json['temp'];
    feelslike = json['feels_like'];
    tempmin = json['temp_min'];
    tempmax = json['temp_max'];
    pressure = json['pressure'];
    humidity = json['humidity'];
  }
}
