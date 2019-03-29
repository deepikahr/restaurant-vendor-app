
import 'package:http/http.dart' show Client;
import './constant.dart';
import './common.dart';
import 'dart:convert';

// /aut/user

class AuthService {
    
    static final Client client =Client();

    static Future<Map<String, dynamic>> login(Map<String, dynamic> body) async{
      
      final response  = await client.post(BASE_URL+'auth/local', body: body);
      return json.decode(response.body);   

    }



 static Future<dynamic> getUserInfo() async {
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    final response = await client.get(BASE_URL + 'api/users/me',
        headers: {'Content-Type': 'application/json', 'Authorization': token});

        // print(response.body);

    return json.decode(response.body);
  }


}

