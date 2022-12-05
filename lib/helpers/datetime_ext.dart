extension DateTimeExtension on DateTime {
  String? weekdayName() {
    const Map<int, String> weekdayName = {
      1: "Lun",
      2: "Mar",
      3: "Mie",
      4: "Jue",
      5: "Vie",
      6: "Sab",
      7: "Dom"
    };
    return weekdayName[weekday];
  }
}
