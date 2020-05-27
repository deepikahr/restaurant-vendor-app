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

// CouponCard

class OrdersInProgress extends StatefulWidget {
  static String tag = "orderProgress";
  final Map<String, Map<String, String>> localizedValues;
  final String locale;
  OrdersInProgress({Key key, this.locale, this.localizedValues})
      : super(key: key);

  @override
  _OrdersInProgressState createState() => _OrdersInProgressState();
}

class _OrdersInProgressState extends State<OrdersInProgress> {
  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      GlobalKey<AsyncLoaderState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List orders;
  bool isAcceptLoading = false;
  int selectedIndex;
  String currency;

  getCurrency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currency = prefs.getString('currency');
  }

  @override
  void initState() {
    getOrder();
    getCurrency();
    super.initState();
  }

  Future<List<dynamic>> getOrder() async {
    await OrderServices.getOrderList().then((onValue) {
      List filterOrder = List();
      for (int i = 0; i < onValue.length; i++) {
        if (onValue[i]['status'] == "Accepted") {
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
      if (onValue['message'] != null && mounted) {
        setState(() {
          isAcceptLoading = false;
          orders.removeAt(index);
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
      renderError: ([error]) => NoData(
          message: MyLocalizations.of(context)
              .somethingwentwrongpleaserestarttheapp),
      renderSuccess: ({data}) => data.length == 0
          ? NoData(message: MyLocalizations.of(context).noOrderHistory)
          : Container(
              child: ListView.builder(
                  itemCount: orders == null ? 0 : orders.length,
                  itemBuilder: (BuildContext context, dynamic index) {
                    return SingleChildScrollView(
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
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                new OrderDetails(
                                              orderData: orders[index],
                                              option: 'assign',
                                            ),
                                          ),
                                        );
                                      },
                                      child: OrderItem(
                                        imgurl: orders[index]['productDetails']
                                                [0]['imageUrl'] ??
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
                                                    orders[index]
                                                        ['createdAt'])),
                                        details: orders[index]
                                                        ['shippingAddress'] !=
                                                    null &&
                                                orders[index]['shippingAddress']
                                                        ['address'] !=
                                                    null
                                            ? orders[index]['shippingAddress']
                                                ['address']
                                            : '',
                                        price:
                                            ' $currency${orders[index]['payableAmount'].toStringAsFixed(2)}',
                                        paymentMethod:
                                            ' - ${orders[index]['paymentOption']}',
                                        statusLabel:
                                            MyLocalizations.of(context).status +
                                                ': ',
                                        status: '${orders[index]['status']}',
                                      ),
                                    ),
                                    _bottomSection(
                                        index,
                                        orders[index]['assigned'],
                                        orders[index]['deliveryByName'] ?? '')
                                  ],
                                )),
                          ],
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

  Widget _bottomSection(int index, bool assigned, String deliveryBoyName) {
    if (!assigned) {
      return InkWell(
        onTap: () {
          selectedIndex = index;
          _showAssignAlert();
        },
        child: Container(
          height: 44,
          decoration: const BoxDecoration(
              border: Border(
            top: BorderSide(width: 1.0, color: Color(0xFFf29000000)),
          )),
          child: Center(
            child: Text(
              MyLocalizations.of(context).assignForDeliver,
              style: TextStyle(color: SUCCESS),
            ),
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          showSnackbar(MyLocalizations.of(context).alreadyAssigned);
        },
        child: Container(
          height: 44,
          decoration: const BoxDecoration(
              border: Border(
            top: BorderSide(width: 1.0, color: Color(0xFFf29000000)),
          )),
          child: Center(
            child: Text(
              MyLocalizations.of(context).assignedTo + deliveryBoyName,
              style: TextStyle(color: Colors.yellow[600]),
            ),
          ),
        ),
      );
    }
  }

  final GlobalKey<AsyncLoaderState> _asyncLoaderStateStaff =
      GlobalKey<AsyncLoaderState>();

  Future<void> _showAssignAlert() {
    AsyncLoader _asyncLoaderStaff = AsyncLoader(
        key: _asyncLoaderStateStaff,
        initState: () async => await _getStaffList(),
        renderLoad: () => Center(child: CircularProgressIndicator()),
        renderError: ([error]) => NoData(
            message: MyLocalizations.of(context).pleaseTryAgain,
            icon: Icons.block),
        renderSuccess: ({data}) {
          if (data is List)
            return _shoeDeliveryAgentsList(data);
          else
            return Text(MyLocalizations.of(context).noStaffAvailable);
        });
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(MyLocalizations.of(context).selectDeliveryAgent),
          content: _asyncLoaderStaff,
        );
      },
    );
  }

  _getStaffList() async {
    return await OrderServices.getStaffList();
  }

  Widget _shoeDeliveryAgentsList(List<dynamic> list) {
    return Container(
      child: SingleChildScrollView(
        child: ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.only(right: 0.0),
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            if (list[index]['isSelected'] == null)
              list[index]['isSelected'] = false;
            list[0]['isSelected'] = true;
            return InkWell(
              onTap: () {
                _showAssignConfirmAlert(list[index]);
              },
              child: Container(
                color: Colors.white,
                child: ListTile(
                  title: Column(
                    children: [
                      Text(list[index]["name"]),
                      Divider(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  bool isLoading = false;
  Future<void> _showAssignConfirmAlert(Map staff) {

    print('staf $staff');
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(MyLocalizations.of(context).confirm),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(MyLocalizations.of(context)
                        .areYouSureYouWantToAssignOrderTo +
                    staff['name'] +
                    '?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: isLoading
                  ? Text(MyLocalizations.of(context).pleaseWait)
                  : Text(MyLocalizations.of(context).ok),
              onPressed: () {
                if (!isLoading) {
                  if (mounted) {
                    setState(() {
                      isLoading = true;
                    });
                  }
//                  orders[selectedIndex]['assigned'] = true;
//                  orders[selectedIndex]['assignedDate'] =
//                      DateTime.now().millisecondsSinceEpoch;
//                  orders[selectedIndex]['deliveryBy'] = staff['_id'];
//                  orders[selectedIndex]['deliveryByName'] = staff['name'];
//                  orders[selectedIndex]['status'] = "On the Way";
//                  OrderServices.updateOrder(
//                          orders[selectedIndex]['_id'], orders[selectedIndex])
//                      .then((onValue) {
////                    Navigator.of(context).pop();
////                    Navigator.of(context).pop();
//                    orders.removeAt(selectedIndex);
////                    showSnackbar(MyLocalizations.of(context).assignedSuccessfully);
//                    if (mounted) {
//                      setState(() {
//                        isLoading = false;
//                      });
//                    }
//                  });

                  Map<String, dynamic> assignBody = {
                    'assignedDate': DateTime.now().millisecondsSinceEpoch,
                    'assigned': true,
                    'deliveryBy': staff['_id'],
                    'deliveryByName': staff['name']
                  };
print('ordr id ${orders[selectedIndex]['_id']}');
                  OrderServices.assignOrder(
                      orders[selectedIndex]['_id'], assignBody)
                      .then((onValue) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    showSnackbar(MyLocalizations.of(context).assignedSuccessfully);
                    if (mounted) {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  });

                }
              },
            ),
            FlatButton(
              child: Text(MyLocalizations.of(context).goBack),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showSnackbar(message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 3000),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
