import 'package:http/http.dart' show Client;
import 'dart:convert';
import './constant.dart';
import './common.dart';


class OrderServices {
  
  static final Client client =Client();
  


   static Future<dynamic> getOrderHistory() async {
    String token,locationId;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    await Common.getLocationId().then((onValue){ 
        locationId = onValue;
    });
      print("Restraurent IDddd== = " + locationId);
    final response = await client.post(BASE_URL + 'api/orders/search/order/bylocation/${locationId}',
        headers: {'Content-Type': 'application/json', 'Authorization': token});    
        return json.decode(response.body);
  }

static Future<Map<String, dynamic>> getOrderDetail(String orderId) async {
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    final response = await client.get('https://restaurantsass.herokuapp.com/api/orders/' +orderId,
        headers: {'Content-Type': 'application/json', 'Authorization': token});
        print("Order details =>" + response.body);
        return json.decode(response.body);
  }
}