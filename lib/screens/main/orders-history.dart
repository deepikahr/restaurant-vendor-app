import 'package:Kitchenapp/services/localizations.dart' show MyLocalizations;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/order-item.dart';
import '../widgets/no-data.dart';
import '../../styles/styles.dart';
import 'package:async_loader/async_loader.dart';
import '../../services/orders.dart';
import '../../screens/main/order-details.dart';
import 'package:intl/intl.dart';

class OrderHistory extends StatefulWidget {
  static String tag = "orderHistory";
  final Map localizedValues;
  final String locale;

  OrderHistory({Key key, this.locale, this.localizedValues}) : super(key: key);

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      GlobalKey<AsyncLoaderState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic data;
  String currency;

  @override
  void initState() {
    getOrder();
    super.initState();
    getCurrency();
  }

  getCurrency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currency = prefs.getString('currency');
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
      renderError: ([error]) => NoData(
          message:
              MyLocalizations.of(context).getLocalizations("ERROR_MESSAGE")),
      renderSuccess: ({data}) => data.length == 0
          ? NoData(
              message: MyLocalizations.of(context)
                  .getLocalizations("NO_ORDER_HISTORY"))
          : Container(
              child: ListView.builder(
                  itemCount: data == null ? 0 : data.length,
                  itemBuilder: (BuildContext context, dynamic index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new OrderDetails(
                                orderData: data[index],
                                option: 'history',
                              ),
                            ));
                      },
                      child: SingleChildScrollView(
                        child: Container(
                          width: screenWidth(context),
                          child: Column(
                            children: <Widget>[
                              Card(
                                  elevation: 5.0,
                                  margin: EdgeInsets.only(top: 12.0, bottom: 6),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0)),
                                  child: Column(
                                    children: <Widget>[
                                      OrderItem(
                                        imgurl: data[index]['productDetails'][0]
                                                ['imageUrl'] ??
                                            'https://images.unsplash.com/photo-1490717064594-3bd2c4081693?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60R',
                                        orderId: '${data[index]['orderID']}',
                                        dateTime: data[index]
                                                    ['createdAtTime'] !=
                                                null
                                            ? DateFormat('dd-MMM-yy hh:mm a')
                                                .format(new DateTime
                                                        .fromMillisecondsSinceEpoch(
                                                    data[index]
                                                        ['createdAtTime']))
                                            : DateFormat('dd-MMM-yy hh:mm a')
                                                .format(DateTime.parse(
                                                    data[index]['createdAt'])),
                                        details: data[index]
                                                        ['shippingAddress'] !=
                                                    null &&
                                                data[index]['shippingAddress']
                                                        ['address'] !=
                                                    null
                                            ? data[index]['shippingAddress']
                                                ['address']
                                            : '',
                                        price:
                                            ' $currency${data[index]['payableAmount'].toStringAsFixed(2)}',
                                        paymentMethod:
                                            ' - ${data[index]['paymentOption']}',
                                        statusLabel: MyLocalizations.of(context)
                                                .getLocalizations("STATUS") +
                                            ': ',
                                        status: '${data[index]['status']}',
                                      ),
                                      // _bottomSection()
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
    );

    return Scaffold(
        backgroundColor: WHITE,
        appBar: AppBar(
          title: Text(
            MyLocalizations.of(context).getLocalizations("ORDER_HISTORY"),
            style: headerDefaultColor(),
          ),
          iconTheme: new IconThemeData(color: WHITE),
        ),
        body: asyncLoader);
  }
}
