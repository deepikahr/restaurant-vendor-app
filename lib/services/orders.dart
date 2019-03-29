import 'package:http/http.dart' show Client;
import 'dart:convert';
import './constant.dart';
import './common.dart';


class OrderServices {
  
  static final Client client =Client();
  

  // get order history
   static Future<dynamic> getOrderHistory() async {
    String token,restaurantId;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    await Common.getRestaurantId().then((onValue){ 
        restaurantId = onValue;
    });
      print("Restraurent IDddd== = " + restaurantId);
    final response = await client.post(BASE_URL + 'api/orders/search/order/bylocation/5a6ec0b328d7b9001499a144',
        headers: {'Content-Type': 'application/json', 'Authorization': token});
        // print("Order History =>" + response.body);
        return json.decode(response.body);
  }
//  https://restaurantsass.herokuapp.com/api/orders/5c91d6afb9612c0014abaaf5

 // get order history
   static Future<dynamic> getOrderDetail() async {
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    // await Common.getRestaurantId().then((onValue){ 
    //     restaurantId = onValue;
    // });
    //   print("Token = " + restaurantId);
    final response = await client.post(BASE_URL + 'api/orders/5c91d6afb9612c0014abaaf5',
        headers: {'Content-Type': 'application/json', 'Authorization': token});
        // print("Order History =>" + response.body);
        return json.decode(response.body);
  }
  // https://restaurantsass.herokuapp.com/api/orders/5c63c108a1964100145c1f9d

   // update order status  
   static Future<dynamic> updateOrderStatus() async {
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    // await Common.getRestaurantId().then((onValue){ 
    //     restaurantId = onValue;
    // });
    //   print("Token = " + restaurantId);
    final response = await client.put(BASE_URL + 'api/orders/5c63c108a1964100145c1f9d',
        headers: {'Content-Type': 'application/json', 'Authorization': token});
        // print("Order History =>" + response.body);
        return json.decode(response.body);
  }

}
 
