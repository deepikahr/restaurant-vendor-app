import 'package:shared_preferences/shared_preferences.dart';

class Common {
  // save token on storage
  static Future<bool> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', token);
  }

  // save token on storage
  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Future(() => prefs.getString('token'));
  }

  // remove token from storage
  static Future<bool> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('token');
  }

  // save Id on storage
  static Future<bool> setId(String locationId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('id', locationId);
  }

  // get Id from storage
  static Future<String> getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Future(() => prefs.getString('id'));
  }

  // save role on storage
  static Future<bool> setRole(String locationId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('role', locationId);
  }

  // get role from storage
  static Future<String> getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Future(() => prefs.getString('role'));
  }
}
