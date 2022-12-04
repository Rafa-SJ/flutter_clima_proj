import 'package:http/http.dart' as http;

class WsManager {
  static const String _urlServer = "api.openweathermap.org";

  static Future<String> get(String route, Map<String, dynamic> object) async {
    var url = Uri.https(_urlServer, route, object);

    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    }
    return "Ha ocurrido un error ${response.statusCode}";
  }

  // static Future<String> post() async {}
}
