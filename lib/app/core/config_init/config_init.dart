import 'package:shared_preferences/shared_preferences.dart';

class ConfigInit {
  static late final SharedPreferences prefs;
  ConfigInit() {
    _init();
  }

  _init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
