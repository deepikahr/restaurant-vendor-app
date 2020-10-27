import 'package:Kitchenapp/services/localizations.dart' show MyLocalizations;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './drawer.dart';
import './new-orders.dart';
import './orders-in-progress.dart';
import '../../styles/styles.dart';

class OrderList extends StatefulWidget {
  static String tag = "orderList";

  final Map<String, Map<String, String>> localizedValues;
  final String locale;

  OrderList({Key key, this.locale, this.localizedValues}) : super(key: key);

  @override
  OrderListState createState() => OrderListState();
}

class OrderListState extends State<OrderList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  bool isLoggedIn = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: WHITE,
            unselectedLabelColor: Colors.white70,
            labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13.0,
              color: PRIMARY,
            ),
            tabs: [
              Tab(text: MyLocalizations.of(context).newOrders),
              Tab(text: MyLocalizations.of(context).inProgress),
            ],
          ),
          title: Text(MyLocalizations.of(context).orders,
              style: headerDefaultColor()),
          iconTheme: new IconThemeData(color: WHITE),
        ),
        drawer: Menu(
          locale: widget.locale,
          localizedValues: widget.localizedValues,
          scaffoldKey: _scaffoldKey,
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            NewOrders(
              locale: widget.locale,
              localizedValues: widget.localizedValues,
            ),
            OrdersInProgress(
              locale: widget.locale,
              localizedValues: widget.localizedValues,
            ),
          ],
        ),
      ),
    );
  }
}
