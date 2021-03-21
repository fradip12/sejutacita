import 'package:shared_preferences/shared_preferences.dart';

class App {
  static SharedPreferences data;
  static Future init()async {
    data = await SharedPreferences.getInstance();
  }
}