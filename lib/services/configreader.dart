import 'dart:convert';
import 'package:flutter/services.dart';

abstract class ConfigReader {
  static late Map<String, dynamic> _config;

  static Future<void> initialize() async {
    final configString = await rootBundle.loadString('config/app_config.json');
    _config = json.decode(configString) as Map<String, dynamic>;
  }

  static String getServerUrl() {
    return _config['SERVERURL'] as String;
  }

  static String getApiKey() {
    return _config['APIKEY'] as String;
  }
}
