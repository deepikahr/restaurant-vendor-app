import 'package:flutter/material.dart';
import '../widgets/order-item.dart';
import '../widgets/no-data.dart';
import '../../styles/styles.dart';
import 'package:async_loader/async_loader.dart';
import '../../services/orders.dart';
import '../../screens/main/order-details.dart';
import 'package:intl/intl.dart';
// CouponCard

class NewOrders extends StatefulWidget {
  static String tag = "newOrder";
  @override
  _NewOrdersState createState() => _NewOrdersState();
}

class _NewOrdersState extends State<NewOrders> {
  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      GlobalKey<AsyncLoaderState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List orders;
  bool isAcceptLoading = false;
  bool isCancleLoading = false;
  int currentIndexAccept;
  int currentIndexCancle;

  @override
  void initState() {
    super.initState();
  }

  void showSnackbar(message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 3000),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Future<List<dynamic>> getOrder() async {
    await OrderServices.getOrderList().then((onValue) {
      List filterOrder = List();
      for (int i = 0; i < onValue.length; i++) {
        if (onValue[i]['status'] == "Pending") {
          filterOrder.add(onValue[i]);
        }
      }
      if (mounted) {
        setState(() {
          orders = filterOrder;
        });
      }
    });
    return orders;
  }

  Future<List<dynamic>> accceptOrder(String orderId, int index) async {
    if (mounted) {
      setState(() {
        isAcceptLoading = true;
      });
    }
    Map<String, dynamic> body = {'status': "Accepted"};
    await OrderServices.updateOrder(orderId, body).then((onValue) {
      if (onValue['message'] != null) {
        if (mounted) {
          setState(() {
            isAcceptLoading = false;
            orders.removeAt(index);
            showSnackbar('Order Accepted');
          });
        }
      }
    });
    return Future(null);

  }

  Future<List<dynamic>> cancelOrder(String orderId, int index) async {
    if (mounted) {
      setState(() {
        isCancleLoading = true;
      });
    }
    Map<String, dynamic> body = {'status': "Cancelled"};
    await OrderServices.updateOrder(orderId, body).then((onValue) {
      if (onValue['message'] != null && mounted) {
        setState(() {
          isCancleLoading = false;
          orders.removeAt(index);
          showSnackbar('Order Cancelled');
        });
      }
    });
    return Future(null);
  }

  Widget build(BuildContext context) {
    var asyncLoader = AsyncLoader(
      key: _asyncLoaderState,
      initState: () async => await getOrder(),
      renderLoad: () => Center(child: new CircularProgressIndicator()),
      renderError: ([error]) => NoData(message: 'Something went wrong..'),
      renderSuccess: ({data}) => orders.length == 0
          ? NoData(message: 'No Order History')
          : Container(
              child: ListView.builder(
                  itemCount: orders == null ? 0 : orders.length,
                  itemBuilder: (BuildContext context, dynamic index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new OrderDetails(
                                orderData: orders[index],
                                option: 'accept',
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
                                      imgurl: orders[index]['productDetails'][0]
                                              ['imageUrl'] ??
                                          'https://images.unsplash.com/photo-1490717064594-3bd2c4081693?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60R',
                                      orderId: '${orders[index]['orderID']}',
                                      dateTime: orders[index]
                                                  ['createdAtTime'] !=
                                              null
                                          ? DateFormat('dd-MMM-yy hh:mm a')
                                              .format(new DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                  orders[index]
                                                      ['createdAtTime']))
                                          : DateFormat('dd-MMM-yy hh:mm a')
                                              .format(DateTime.parse(
                                                  orders[index]['createdAt'])),
                                      details: orders[index]
                                                      ['shippingAddress'] !=
                                                  null &&
                                              orders[index]['shippingAddress']
                                                      ['locationName'] !=
                                                  null
                                          ? '${orders[index]['shippingAddress']['locationName']}'
                                          : '',
                                      price:
                                          ' \$${orders[index]['payableAmount'].toStringAsFixed(2)}',
                                      paymentMethod:
                                          ' - ${orders[index]['paymentOption']}',
                                      statusLabel: 'Status: ',
                                      status: '${orders[index]['status']}',
                                    ),
                                    _bottomSection(orders[index]['_id'], index),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
    );

    return Scaffold(
      body: asyncLoader,
      key: _scaffoldKey,
    );
  }

  Widget _bottomSection(String id, int index) {
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
              onPressed: () {
                if (!isAcceptLoading) {
                  currentIndexAccept = index;
                  accceptOrder(id, index);
                }
              },
              child: (isAcceptLoading && currentIndexAccept == index)
                  ? Text('Wait...')
                  : Text('Accept'),
              textColor: PRIMARY,
              padding: EdgeInsets.all(0),
            ),
          ),
          Container(
            width: screenWidth(context) * 0.50,
            child: FlatButton(
              onPressed: () {
                if (!isCancleLoading) {
                  currentIndexCancle = index;
                  cancelOrder(id, index);
                }
              },
              child: (isCancleLoading && currentIndexCancle == index)
                  ? Text('Wait...')
                  : Text('Reject'),
              textColor: DARK_TEXT_A,
              padding: EdgeInsets.all(0),
            ),
          ),
        ],
      ),
    );
  }
}
