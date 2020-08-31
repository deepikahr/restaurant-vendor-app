import 'package:Kitchenapp/services/localizations.dart' show MyLocalizations;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/no-data.dart';
import '../../styles/styles.dart';
import 'package:async_loader/async_loader.dart';
import '../../services/orders.dart';

class Daily extends StatefulWidget {
  static String tag = "Daily";
  final Map localizedValues;
  final String locale;

  Daily({Key key, this.locale, this.localizedValues}) : super(key: key);

  @override
  _DailyState createState() => _DailyState();
}

class _DailyState extends State<Daily> {
  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      GlobalKey<AsyncLoaderState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List dailyReport;
  String currency;

  @override
  void initState() {
    getCurrency();
    super.initState();
  }

  getCurrency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currency = prefs.getString('currency');
  }

  getReport() async {
    await OrderServices.getReportDetails().then((onValue) {
      if (mounted) {
        setState(() {
          dailyReport = onValue['response_data']['data']['Daily'];
        });
      }
    });
  }

  Widget build(BuildContext context) {
    Widget reportCard() {
      return ListView.builder(
          itemCount: dailyReport.length,
          itemBuilder: (BuildContext context, dynamic index) {
            return dailyReport.length == 0
                ? CircularProgressIndicator()
                : GestureDetector(
                    onTap: () {},
                    child: SingleChildScrollView(
                      child: Container(
                        width: screenWidth(context),
                        child: Column(
                          children: <Widget>[
                            Card(
                                elevation: 1.0,
                                margin: EdgeInsets.only(top: 12.0, bottom: 6),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            'Date : ',
                                            style: orderDetailsRejectbtn(),
                                          ),
                                          dailyReport[index]['_id'] == null
                                              ? Text('')
                                              : Text(
                                                  '${dailyReport[index]['_id']['date']}/${dailyReport[index]['_id']['month']}/${dailyReport[index]['_id']['year']}',
//                                      DateFormat(
//                                          'dd-MMM-yy hh:mm a')
//                                          .format(new DateTime
//                                          .fromMillisecondsSinceEpoch(
//                                          dailyReport[index]
//                                          ['_id'])),
                                                  style: blacktext(),
                                                ),
                                        ],
                                      ),
                                      SizedBox(height: 10),

                                      Row(
                                        children: <Widget>[
                                          Text(
                                            'No. of sales : ',
                                            style: orderDetailsRejectbtn(),
                                          ),
                                          Text(
                                            dailyReport[index]['TotalOrder'] ==
                                                    null
                                                ? Text('')
                                                : dailyReport[index]
                                                        ['TotalOrder']
                                                    .toString(),
                                            style: blacktext(),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Total : ',
                                            style: orderDetailsRejectbtn(),
                                          ),
                                          Text(
                                            dailyReport[index]['TotalAmount'] ==
                                                    null
                                                ? Text('')
                                                : '$currency${dailyReport[index]['TotalAmount']}',
                                            style: orderDetailsBoldPrice(),
                                          ),
                                        ],
                                      ),
                                      // _bottomSection()
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  );
          });
    }

    return Scaffold(
        backgroundColor: WHITE,
        body: AsyncLoader(
            key: _asyncLoaderState,
            initState: () async => await getReport(),
            renderLoad: () => Center(child: new CircularProgressIndicator()),
            renderError: ([error]) => NoData(
                message: MyLocalizations.of(context)
                    .getLocalizations("ERROR_MESSAGE")),
            renderSuccess: ({data}) => dailyReport.length == 0
                ? NoData(
                    message: MyLocalizations.of(context)
                        .getLocalizations("NO_ORDER_HISTORY"))
                : reportCard()));
  }
}
