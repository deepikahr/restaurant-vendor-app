import 'package:flutter/material.dart';
import '../widgets/no-data.dart';
import '../widgets/avatar.dart';
import '../../styles/styles.dart';
import 'package:async_loader/async_loader.dart';
import '../../services/orders.dart';
import '../../localizations.dart' show MyLocalizations, MyLocalizationsDelegate;

class OrderDetails extends StatefulWidget {
  static String tag = "orderDetails";
  final orderData;
  final String option;
  final Map<String, Map<String, String>> localizedValues;
  final String locale;
  OrderDetails(
      {Key key,
      @required this.orderData,
      @required this.option,
      this.locale,
      this.localizedValues})
      : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      GlobalKey<AsyncLoaderState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic data;
  dynamic productList;

  String customerName;
  String customerEmail;
  String orderId;
  String customerContact;
  String paymentMethod;
  String shippingAddress;
  String deliveryCharge;
  String subTotal;
  String grandTotal;
  String charges;
  String payableAmount;
  List products;
  Map taxInfo;
  bool isAcceptLoading = false;
  bool isCancleLoading = false;

  @override
  void initState() {
    orderDetail();
    super.initState();
  }

  Future<Map<String, dynamic>> orderDetail() async {
    await OrderServices.getOrderDetail(widget.orderData['_id']).then((onValue) {
      customerName = onValue['userInfo']['name'];
      customerContact = onValue['userInfo']['contactNumber'].toString();
      customerEmail = onValue['userInfo']['email'];
      paymentMethod = onValue['paymentOption'];
      shippingAddress = onValue['shippingAddress'] != null
          ? onValue['shippingAddress']['address']
          : '';
      orderId = '#' + onValue['orderID'].toString();
      deliveryCharge = onValue['deliveryCharge'].toString();
      subTotal = onValue['subTotal'].toString();
      grandTotal = onValue['grandTotal'].toString();
      charges = onValue['charges'].toString();
      payableAmount = onValue['payableAmount'].toString();
      taxInfo = onValue['taxInfo'] ?? {"taxRate": 0, "taxName": "nil"};
      products = List();
      for (int i = 0; i < onValue['productDetails'].length; i++) {
        products.add(onValue['productDetails'][i]);
      }
      if (mounted) {
        setState(() {
          var resultData = onValue;
          data = resultData;
          productList = products;
        });
      }
    });
    return data;
  }

  Future<List<dynamic>> accceptOrder() async {
    if (mounted) {
      setState(() {
        isAcceptLoading = true;
      });
    }
    Map body = {'status': "On the Way"};
    await OrderServices.updateOrder(widget.orderData['_id'], body)
        .then((onValue) {
      if (onValue['message'] != null && mounted) {
        setState(() {
          isAcceptLoading = false;
        });
      } else {}
    });
    return Future(null);
  }

  Future<List<dynamic>> cancelOrder() async {
    if (mounted) {
      setState(() {
        isCancleLoading = true;
      });
    }
    return Future(null);
  }

  Widget build(BuildContext context) {
    var asyncLoader = AsyncLoader(
      key: _asyncLoaderState,
      initState: () async => await orderDetail(),
      renderLoad: () => Center(child: new CircularProgressIndicator()),
      renderError: ([error]) =>
          NoData(message: MyLocalizations.of(context).errorMessage),
      renderSuccess: ({data}) => Container(
        width: screenWidth(context),
        height: screenHeight(context),
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        decoration: BoxDecoration(
          color: BG_COLOR,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _customerDetails(),
              _orderDetails(),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
        backgroundColor: WHITE,
        appBar: AppBar(
          title: Text(MyLocalizations.of(context).orderDetails,
              style: headerDefaultColor()),
          iconTheme: new IconThemeData(color: WHITE),
        ),
        body: asyncLoader);
  }

  Widget _customerDetails() {
    return Container(
      padding: EdgeInsets.only(top: 12, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            MyLocalizations.of(context).customerAndPaymentInfo,
            style: titleStyle(),
          ),
          Card(
            elevation: 5.0,
            color: WHITE,
            margin: EdgeInsets.only(
              bottom: 12.0,
              top: 12.0,
            ),
            child: Container(
              padding: EdgeInsets.only(top: 12, bottom: 12),
              child: Column(
                children: <Widget>[
                  _customerSection(Icons.card_membership, 'Order ID',
                      orderId != null ? orderId : ''),
                  _customerSection(Icons.account_circle, 'Name',
                      customerName != null ? customerName : ''),
                  _customerSection(Icons.location_on, 'Locaiton',
                      shippingAddress != null ? shippingAddress : ''),
                  _customerSection(Icons.contact_phone, 'Contact',
                      customerContact != null ? customerContact : ''),
                  _customerSection(Icons.email, 'Email',
                      customerEmail != null ? customerEmail : ''),
                  _customerSection(Icons.payment, 'Payment Method',
                      paymentMethod != null ? paymentMethod : ''),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _customerSection(IconData icon, String label, String details) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            icon,
            color: DARK_TEXT,
            size: 16,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Text(
              label,
              style: labelLarge(),
            ),
          ),
          Expanded(
            child: Text(
              details,
              style: labelLight(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _orderDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          MyLocalizations.of(context).orderDetails,
          style: titleStyle(),
        ),
        Card(
          elevation: 5.0,
          color: WHITE,
          margin: EdgeInsets.only(
            bottom: 12.0,
            top: 12.0,
          ),
          child: Container(
            margin: EdgeInsets.only(top: 12, bottom: 12),
            child: Column(
              children: <Widget>[
                _detailTopSection(),
                // detailMiddle(),
                _detailBottom('Sub Total', '\$' + subTotal ?? ''),
                _detailBottom(
                    'Tax', taxInfo['taxRate'].toStringAsFixed(2) + '%' ?? ''),
                _detailBottom(
                    'Delivery Charges',
                    (deliveryCharge == 'Free' ? '' : '\$') + deliveryCharge ??
                        ''),
                _detailBottom('Grand Total', '\$' + grandTotal ?? ''),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _detailTopSection() {
    return ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: products.length,
        itemBuilder: (BuildContext context, int i) {
          return Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: products[i]['imageUrl'] == null
                      ? Avatar(
                          imgurl:
                              "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg",
                        )
                      : Avatar(
                          imgurl: products[i]['imageUrl'],
                        ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                ),
                Flexible(
                  flex: 8,
                  child: Container(
                    padding: EdgeInsets.only(right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(products[i]['title'], style: labelLarge()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                                (products[i]['size'] ?? '') +
                                    ' x' +
                                    products[i]['Quantity'].toString(),
                                style: labelLight()),
                            Text(
                              "\$${products[i]['price'] * products[i]['Quantity']}",
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                        ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: products[i]['extraIngredients'] != null
                                ? products[i]['extraIngredients'].length
                                : 0,
                            itemBuilder: (BuildContext context, int j) {
                              return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(),
                                    Text(
                                        products[i]['extraIngredients'][j]
                                                ['name'] ??
                                            '',
                                        style: labelLight()),
                                    Text(
                                      '\$${products[i]['extraIngredients'][j]['price'].toString()}' ??
                                          '',
                                      style: TextStyle(fontSize: 10),
                                    )
                                  ]);
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(),
                            Text('\$${products[i]['totalPrice']}',
                                style: textPrimary()),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget detailMiddle() {
    if (widget.option == 'accept') {
      return Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        margin: EdgeInsets.only(bottom: 5, top: 5),
        decoration: const BoxDecoration(
            border: Border(
          bottom: BorderSide(width: 1.0, color: Color(0xFFf29000000)),
          top: BorderSide(width: 1.0, color: Color(0xFFf29000000)),
        )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: screenWidth(context) * 0.2,
              child: FlatButton(
                onPressed: accceptOrder,
                child: isAcceptLoading
                    ? Text(MyLocalizations.of(context).pleaseWait)
                    : Text(MyLocalizations.of(context).accept),
                textColor: PRIMARY,
                padding: EdgeInsets.all(0),
              ),
            ),
            new Container(
              width: screenWidth(context) * 0.2,
              child: FlatButton(
                onPressed: cancelOrder,
                child: isCancleLoading
                    ? Text(MyLocalizations.of(context).pleaseWait)
                    : Text(MyLocalizations.of(context).reject),
                textColor: PRIMARY,
                padding: EdgeInsets.all(0),
              ),
            ),
          ],
        ),
      );
    } else if (widget.option == 'assign') {
      return Text('assign here');
    } else if (widget.option == 'history') {
      return Text('history order status');
    } else {
      return Text('unwanted entry');
    }
  }

  Widget _detailBottom(String label, String price) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                label,
                style: labelLarge(),
              ),
            ],
          ),
          new Container(
            child: Text(
              price,
              style: labelLarge(),
            ),
          ),
        ],
      ),
    );
  }
}
