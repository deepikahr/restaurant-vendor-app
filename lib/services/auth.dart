import 'package:http/http.dart' show Client;
import './constant.dart';
import './common.dart';
import 'dart:convert';

class AuthService {
  static final Client client = Client();
  static Future<Map<String, dynamic>> login(Map<String, dynamic> body) async {
    final response = await client.post(BASE_URL + 'auth/local', body: body);
    return json.decode(response.body);
  }

  static Future<dynamic> getUserInfo() async {
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    final response = await client.get(API_ENDPOINT + 'users/me',
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    return json.decode(response.body);
  }

  static Future verifyTokenOTP(String token) async {
    final response = await client.get(API_ENDPOINT + 'users/verify/token',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + token
        });

    return json.decode(response.body);
  }

  static Future<dynamic> getAdminSettings() async {
    final response = await client.get(API_ENDPOINT + 'adminsettings');
    return json.decode(response.body);
  }
}
