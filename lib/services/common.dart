import 'package:shared_preferences/shared_preferences.dart';

class Common {

   // save token on storage
  static Future<bool> setToken(String token) async{
      SharedPreferences prefs  =await SharedPreferences.getInstance();
      return prefs.setString('token', token);
  }

  // save token on storage
  static Future<String> getToken() async {
      SharedPreferences prefs  =await SharedPreferences.getInstance();
      return Future( () => prefs.getString('token'));
  }

  // remove token from storage
  static Future<bool> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('token');
  }

  // save restaurant_id on storage
  static Future<bool> setRestaurantId(String restaurantId) async{
      SharedPreferences prefs  =await SharedPreferences.getInstance();
      return prefs.setString('restaurantId', restaurantId);
  }
   // save token on storage
  static Future<String> getRestaurantId() async {
      SharedPreferences prefs  =await SharedPreferences.getInstance();
      return Future( () => prefs.getString('restaurantId'));
  }

}