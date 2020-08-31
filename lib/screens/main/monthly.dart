import 'package:Kitchenapp/services/localizations.dart' show MyLocalizations;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/no-data.dart';
import '../../styles/styles.dart';
import 'package:async_loader/async_loader.dart';
import '../../services/orders.dart';

class Monthly extends StatefulWidget {
  static String tag = "Monthly";
  final Map localizedValues;
  final String locale;

  Monthly({Key key, this.locale, this.localizedValues}) : super(key: key);

  @override
  _MonthlyState createState() => _MonthlyState();
}

class _MonthlyState extends State<Monthly> {
  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      GlobalKey<AsyncLoaderState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List monthlyReport;
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
          monthlyReport = onValue['response_data']['data']['Monthly'];
        });
      }
    });
  }

  Widget build(BuildContext context) {
    Widget reportCard() {
      return ListView.builder(
          itemCount: monthlyReport.length,
          itemBuilder: (BuildContext context, dynamic index) {
            return monthlyReport.length == 0
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
                                          monthlyReport[index]['_id'] == null
                                              ? Text('')
                                              : Text(
                                                  '${monthlyReport[index]['_id']['date']}/${monthlyReport[index]['_id']['month']}/${monthlyReport[index]['_id']['year']}',
//                                                  DateFormat(
//                                                          'dd-MMM-yy hh:mm a')
//                                                      .format(new DateTime
//                                                              .fromMillisecondsSinceEpoch(
//                                                          monthlyReport[index]
//                                                              ['_id'])),
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
                                            monthlyReport[index]
                                                        ['TotalOrder'] ==
                                                    null
                                                ? Text('')
                                                : monthlyReport[index]
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
                                            monthlyReport[index]
                                                        ['TotalAmount'] ==
                                                    null
                                                ? Text('')
                                                : '$currency${monthlyReport[index]['TotalAmount']}',
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
            renderSuccess: ({data}) => monthlyReport.length == 0
                ? NoData(
                    message: MyLocalizations.of(context)
                        .getLocalizations("NO_ORDER_HISTORY"))
                : reportCard()));
  }
}
