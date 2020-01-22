import 'package:flutter/material.dart';
import './screens/main/order-list.dart';
import './screens/main/orders-history.dart';
import './screens/auth/login.dart';
import './screens/main/settings.dart';
import './styles/styles.dart';
// import 'package:flutter_stetho/flutter_stetho.dart';
import 'services/common.dart';
import 'services/constant.dart';
import './screens/main/products.dart';
import './screens/main/add-products.dart';

void main() {
  // Stetho.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  Common.getToken().then((loggedIn) {
    if (loggedIn != null)
      runApp(MyApp(route: OrderList()));
    else
      runApp(MyApp(route: Login()));
  });
}

class MyApp extends StatelessWidget {
  final route;
  final routes = <String, WidgetBuilder>{
    Login.tag: (context) => Login(),
    OrderList.tag: (context) => OrderList(),
    OrderHistory.tag: (context) => OrderHistory(),
    Settings.tag: (context) => Settings(),
    Products.tag: (context) => Products(),
    AddProducts.tag: (context) => AddProducts(),
  };

  MyApp({this.route});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: APP_NAME,
      theme: ThemeData(
        primaryColor: PRIMARY,
        brightness: Brightness.light,
      ),
      home: route,
      routes: routes,
    );
  }
}
