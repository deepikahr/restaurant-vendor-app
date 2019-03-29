import 'package:flutter/material.dart';
import './screens/main/order-list.dart';
import './screens/main/orders-history.dart';
import './screens/auth/login.dart';
import './screens/main/settings.dart';
import './styles/styles.dart';
import 'package:flutter_stetho/flutter_stetho.dart';

void main() {
  Stetho.initialize();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  final routes = <String, WidgetBuilder>{
    Login.tag: (context) => Login(),
    OrderList.tag: (context) => OrderList(),
    OrderHistory.tag: (context) => OrderHistory(),
    Settings.tag: (context) => Settings(),
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: PRIMARY,
        brightness: Brightness.light,
      ),
      home: Login(),
      routes: routes,
    );
  }
}



