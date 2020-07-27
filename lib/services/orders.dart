import 'package:http/http.dart' show Client;
import 'dart:convert';
import './constant.dart';
import './common.dart';

class OrderServices {
  static final Client client = Client();

  static Future<dynamic> getOrderList() async {
    String token, id, role;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });

    await Common.getRole().then((onValue) {
      role = onValue;
    });
    await Common.getId().then((onValue) {
      id = onValue;
    });
    if (role == 'Manager') {
      final response = await client
          .get(Constants.apiEndPoint + 'orders/location/$id', headers: {
        'Content-Type': 'application/json',
        'Authorization': token
      });
      print('ord ${response.statusCode}');
      return json.decode(response.body);
    }
    if (role == 'Owner') {
      final response = await client
          .get(Constants.apiEndPoint + 'orders/restaurant/$id', headers: {
        'Content-Type': 'application/json',
        'Authorization': token
      });
      return json.decode(response.body);
    }
  }

  static Future<Map<String, dynamic>> getReportDetails() async {
    String token, id;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    await Common.getId().then((onValue) {
      id = onValue;
    });
    print('toke $token');
    print('id $id');
//    5ea2aed3b1fa0016602b9635
    final response = await client.get(
        Constants.apiEndPoint + 'orders/loc-info/$id',
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    print('rep ${response.statusCode}');
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> getOrderDetail(String orderId) async {
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    final response = await client.get(Constants.apiEndPoint + 'orders/$orderId',
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> updateOrder(
      String orderID, Map<String, dynamic> body) async {
    print('body $body $orderID');
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    final response = await client.put(Constants.apiEndPoint + 'orders/$orderID',
        headers: {'Content-Type': 'application/json', 'Authorization': token},
        body: json.encode(body));
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> assignOrder(
      String orderID, Map<String, dynamic> body) async {
    print('body $body');
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    final response = await client.put(
        Constants.apiEndPoint + 'orders/assign/$orderID',
        headers: {'Content-Type': 'application/json', 'Authorization': token},
        body: json.encode(body));
    return json.decode(response.body);
  }

  static Future<dynamic> getStaffList() async {
    String token, locationId;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    await Common.getId().then((onValue) {
      locationId = onValue;
    });
    final response = await client.get(
        Constants.apiEndPoint + 'users/all/active/staff/$locationId',
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    return json.decode(response.body);
  }
}
