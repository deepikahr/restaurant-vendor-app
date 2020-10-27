import 'dart:convert';

import 'package:http/http.dart' show Client;

import './common.dart';
import './constant.dart';

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
      final response = await client.get(API_ENDPOINT + 'orders/location/$id',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token
          });
      return json.decode(response.body);
    }
    if (role == 'Owner') {
      final response = await client.get(API_ENDPOINT + 'orders/restaurant/$id',
          headers: {
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
    final response = await client.get(API_ENDPOINT + 'orders/loc-info/$id',
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> getOrderDetail(String orderId) async {
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    final response = await client.get(API_ENDPOINT + 'orders/$orderId',
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> updateOrder(String orderID,
      Map<String, dynamic> body) async {
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    final response = await client.put(API_ENDPOINT + 'orders/$orderID',
        headers: {'Content-Type': 'application/json', 'Authorization': token},
        body: json.encode(body));
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> assignOrder(String orderID,
      Map<String, dynamic> body) async {
    print('body $body');
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    final response = await client.put(API_ENDPOINT + 'orders/assign/$orderID',
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
        API_ENDPOINT + 'users/all/active/staff/$locationId',
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    return json.decode(response.body);
  }
}
