import 'package:flutter/material.dart';
import '../widgets/order-item.dart';
import '../widgets/no-data.dart';
import '../../styles/styles.dart';
import 'package:async_loader/async_loader.dart';
import '../../services/orders.dart';
import '../../screens/main/order-details.dart';
// CouponCard

class NewOrders extends StatefulWidget {
  static String tag = "newOrder";
  @override
  _NewOrdersState createState() => _NewOrdersState();
}

class _NewOrdersState extends State<NewOrders> {
  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      GlobalKey<AsyncLoaderState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic data;

  @override
  void initState() {
    super.initState();
    getOrder();
  }

  Future<List<dynamic>> getOrder() async {
    await OrderServices.getOrderHistory().then((onValue) {
      // print("Order response---");
      // print(onValue[0]['status']);
      List filterOrder = List();

      for (int i = 0; i < onValue.length; i++) {
        if (onValue[i]['status'] == "Pending") {
          filterOrder.add(onValue[i]);
        }
      }
      setState(() {
        data = filterOrder;
      });
    });
    return data;
  }

  Widget build(BuildContext context) {
    var asyncLoader = AsyncLoader(
      key: _asyncLoaderState,
      initState: () async => await getOrder(),
      renderLoad: () => Center(child: new CircularProgressIndicator()),
      renderError: ([error]) => NoData(message: 'Something went wrong..'),
      renderSuccess: ({data}) => data.length == 0
          ? NoData(message: 'No Order History')
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
                                  new OrderDetails(orderData: data[index]),
                            ));
                        // Navigator.of(context).pushNamed(CancelOrder.tag);
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
                                        imgurl:
                                            'https://images.unsplash.com/photo-1490717064594-3bd2c4081693?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60R',
                                        orderId: '${data[index]['orderID']}',
                                        dateTime: data[index]['createdAt']
                                            .toString()
                                            .substring(0, 10),
                                        details: data[index]['shippingAddress'] !=
                                                    null &&
                                                data[index]['shippingAddress']
                                                        ['locationName'] !=
                                                    null
                                            ? '${data[index]['shippingAddress']['locationName']}'
                                            : '',
                                        // data[index]['shippingAddress']['locationName'] ? '${data[index]['shippingAddress']['locationName']}' : ' ',
                                        price:
                                            ' \$ ${data[index]['payableAmount']
                                            .toStringAsFixed(2)}',
                                        paymentMethod:
                                            ' - ${data[index]['paymentOption']}',
                                        statusLabel: 'Status ',
                                        status: '${data[index]['status']}',
                                      ),
                                      _bottomSection(),
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
        body: asyncLoader);
  }

  Widget _bottomSection() {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
        top: BorderSide(width: 1.0, color: Color(0xFFf29000000)),
      )),
      child: new Row(
        children: <Widget>[
          Container(
            width: screenWidth(context) * 0.50,
            decoration: const BoxDecoration(
                border: Border(
              right: BorderSide(width: 1.0, color: Color(0xFFf29000000)),
            )),
            child: FlatButton(
              onPressed: () {},
              child: const Text('Accept'),
              textColor: PRIMARY,
              padding: EdgeInsets.all(0),
            ),
          ),
          Container(
            width: screenWidth(context) * 0.50,
            child: FlatButton(
              onPressed: () {},
              child: const Text('Reject'),
              textColor: DARK_TEXT_A,
              padding: EdgeInsets.all(0),
            ),
          ),
        ],
      ),
    );
  }
}
