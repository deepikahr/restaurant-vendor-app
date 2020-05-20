import 'package:Kitchenapp/services/localizations.dart' show MyLocalizations;
import 'package:flutter/material.dart';
import '../widgets/order-item.dart';
import '../widgets/no-data.dart';
import '../../styles/styles.dart';
import 'package:async_loader/async_loader.dart';
import '../../services/orders.dart';
import '../../screens/main/order-details.dart';
import 'package:intl/intl.dart';

class Monthly extends StatefulWidget {
  static String tag = "Monthly";
  final Map<String, Map<String, String>> localizedValues;
  final String locale;

  Monthly({Key key, this.locale, this.localizedValues}) : super(key: key);

  @override
  _MonthlyState createState() => _MonthlyState();
}

class _MonthlyState extends State<Monthly> {
  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      GlobalKey<AsyncLoaderState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic data;

  @override
  void initState() {
    getOrder();
    super.initState();
  }

  Future<List<dynamic>> getOrder() async {
    await OrderServices.getOrderList().then((onValue) {
      List filterOrder = List();

      for (int i = 0; i < onValue.length; i++) {
        if (onValue[i]['status'] == "Delivered" ||
            onValue[i]['status'] == "Cancelled") {
          filterOrder.add(onValue[i]);
        }
      }
      if (mounted) {
        setState(() {
          data = filterOrder;
        });
      }
    });
    return data;
  }

  Widget build(BuildContext context) {
    var asyncLoader = AsyncLoader(
      key: _asyncLoaderState,
      initState: () async => await getOrder(),
      renderLoad: () => Center(child: new CircularProgressIndicator()),
      renderError: ([error]) =>
          NoData(message: MyLocalizations.of(context).errorMessage),
      renderSuccess: ({data}) => data.length == 0
          ? NoData(message: MyLocalizations.of(context).noOrderHistory)
          : Container(
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (BuildContext context, dynamic index) {
                    return GestureDetector(
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
                                            Text(
                                              '20/2/2020',
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
                                              '2020',
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
                                              'Rs.122020',
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
                  }),
            ),
    );

    return Scaffold(backgroundColor: WHITE, body: asyncLoader);
  }
}
