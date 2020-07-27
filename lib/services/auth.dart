import 'package:http/http.dart' show Client;
import './constant.dart';
import './common.dart';
import 'dart:convert';

class AuthService {
  static final Client client = Client();

  static Future<Map<String, dynamic>> login(Map<String, dynamic> body) async {
    final response =
        await client.post(Constants.apiUrl + 'auth/local', body: body);
    return json.decode(response.body);
  }

  static Future<dynamic> getUserInfo() async {
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    final response = await client.get(Constants.apiEndPoint + 'users/me',
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    return json.decode(response.body);
  }

  static Future verifyTokenOTP(String token) async {
    final response = await client
        .get(Constants.apiEndPoint + 'users/verify/token', headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + token
    });

    return json.decode(response.body);
  }

  static Future<dynamic> getAdminSettings() async {
    print("Constants.apiEndPoint");
    print(Constants.apiEndPoint);
    final response = await client.get(Constants.apiEndPoint + 'adminSettings/');
    return json.decode(response.body);
  }
}
