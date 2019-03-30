import 'package:http/http.dart' show Client;
import 'dart:convert';
import './constant.dart';
import './common.dart';

class OrderServices {
  static final Client client = Client();

  static Future<dynamic> getOrderHistory() async {
    String token, locationId;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    await Common.getLocationId().then((onValue) {
      locationId = onValue;
    });
    final response = await client.post(
        API_ENDPOINT + 'orders/search/order/bylocation/$locationId',
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

  static Future<Map<String, dynamic>> updateOrder(
      String orderID, Map<String, dynamic> body) async {
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    final response = await client.put(API_ENDPOINT + 'orders/$orderID',
        headers: {'Content-Type': 'application/json', 'Authorization': token},
        body: json.encode(body));
    return json.decode(response.body);
  }

  //api/users/all/active/staff/5a6ec0b328d7b9001499a144

  static Future<dynamic> getStaffList() async {
    String token, locationId;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    await Common.getLocationId().then((onValue) {
      locationId = onValue;
    });
    final response = await client.get(
        API_ENDPOINT + 'users/all/active/staff/$locationId',
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    return json.decode(response.body);
  }
}
