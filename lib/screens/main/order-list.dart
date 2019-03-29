import 'package:flutter/material.dart';
import './new-orders.dart';
import './orders-in-progress.dart';
import '../../styles/styles.dart';
import './drawer.dart';

class OrderList extends StatelessWidget {
  
  static String tag = "orderList";
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
                  indicatorColor: Colors.transparent,
                   indicatorSize: TabBarIndicatorSize.tab,
                    // controller: controller,
                  //  activeBackgroundColor: Colors.white,
                  //  inactiveBackgroundColor: tabColor,
                    labelColor: WHITE,
                    unselectedLabelColor: Colors.white70  ,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13.0,
                      color: PRIMARY,
                    ),
              tabs: [
                Tab( text: "New Orders",),
                Tab( text: "In Progress"),
              ],
            ),
            title: Text('Order List', style: headerDefaultColor()),
            iconTheme: new IconThemeData(color: WHITE),
          ),
          drawer: Menu(),
          // body: Center(
          //   child: Text("hashfkjhsakjdfhksadjhfk"),
          // ),
          body: TabBarView(
            children: [
              NewOrders(),
              OrdersInProgress(),
            ],
          ),
        ),
      );
  }
}