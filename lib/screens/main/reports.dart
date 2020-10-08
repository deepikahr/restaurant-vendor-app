import 'package:Kitchenapp/screens/main/daily.dart';
import 'package:Kitchenapp/screens/main/monthly.dart';
import 'package:Kitchenapp/services/localizations.dart' show MyLocalizations;
import 'package:flutter/material.dart';

import '../../styles/styles.dart';

class Reports extends StatefulWidget {
  static String tag = "Reports";

  final Map<String, Map<String, String>> localizedValues;
  final String locale;

  Reports({Key key, this.locale, this.localizedValues}) : super(key: key);

  @override
  ReportsState createState() => ReportsState();
}

class ReportsState extends State<Reports> {
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
              Tab(text: MyLocalizations.of(context).daily),
              Tab(text: MyLocalizations.of(context).monthly),
            ],
          ),
          title: Text(MyLocalizations.of(context).reports,
              style: headerDefaultColor()),
          iconTheme: new IconThemeData(color: WHITE),
        ),
        body: TabBarView(
          children: [
            Daily(
              locale: widget.locale,
              localizedValues: widget.localizedValues,
            ),
            Monthly(
              locale: widget.locale,
              localizedValues: widget.localizedValues,
            ),
          ],
        ),
      ),
    );
  }
}
