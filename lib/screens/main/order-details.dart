import 'package:Kitchenapp/services/localizations.dart' show MyLocalizations;
import 'package:async_loader/async_loader.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/orders.dart';
import '../../styles/styles.dart';
import '../widgets/avatar.dart';
import '../widgets/no-data.dart';

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
  String taxPayerName;
  String taxpayerId;
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

  String currency;

  List flavours;

  @override
  void initState() {
    orderDetail();
    getCurrency();
    super.initState();
  }

  getCurrency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currency = prefs.getString('currency');
  }

  Future<Map<String, dynamic>> orderDetail() async {
    await OrderServices.getOrderDetail(widget.orderData['_id']).then((onValue) {
      customerName = onValue['userInfo']['name'];
      customerContact = onValue['userInfo']['contactNumber'].toString();
      customerEmail = onValue['userInfo']['email'];
//      taxpayerId = onValue['taxPayer']['ID'];
//      taxPayerName = onValue['taxPayer']['Name'];
      paymentMethod = onValue['paymentOption'];
      shippingAddress = onValue['shippingAddress'] != null
          ? onValue['shippingAddress']['address']
          : '';
      orderId = '#' + onValue['orderID'].toString();
      deliveryCharge = onValue['deliveryCharge'].toString();
      subTotal = onValue['subTotal'].toString();
      grandTotal =
          double.parse(onValue['grandTotal'].toString()).toStringAsFixed(2);
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
            elevation: 1.0,
            color: WHITE,
            margin: EdgeInsets.only(
                bottom: 12.0, top: 12.0, left: 12.0, right: 12.0),
            child: Container(
              padding: EdgeInsets.only(top: 12, bottom: 12),
              child: Column(
                children: <Widget>[
                  _customerSection(
                      Icons.card_membership,
                      MyLocalizations.of(context).orderID,
                      orderId != null ? orderId : ''),
                  _customerSection(
                      Icons.account_circle,
                      MyLocalizations.of(context).name,
                      customerName != null ? customerName : ''),
                  shippingAddress.length > 0
                      ? _customerSection(
                          Icons.location_on,
                          MyLocalizations.of(context).location,
                          shippingAddress != null ? shippingAddress : '')
                      : Container(),
                  _customerSection(
                      Icons.contact_phone,
                      MyLocalizations.of(context).contactNo,
                      customerContact != null ? customerContact : ''),
                  _customerSection(Icons.computer,
                      MyLocalizations.of(context).orderType, data["orderType"]),
                  data["orderType"] == "Pickup"
                      ? Column(
                          children: <Widget>[
                            _customerSection(
                                Icons.date_range,
                                MyLocalizations.of(context).pickUpDate,
                                data["pickupDate"].toString() ?? ''),
                            _customerSection(
                                Icons.timer,
                                MyLocalizations.of(context).pickUpTime,
                                data["pickupTime"].toString() ?? ''),
                          ],
                        )
                      : Container(),
                  _customerSection(
                      Icons.payment,
                      MyLocalizations.of(context).paymentMethod,
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

  Widget _customerSection1(IconData icon, String label, bool value) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
            size: 16,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Text(
              label,
              style: labelLarge(),
            ),
          ),
          value
              ? Icon(
                  Icons.check,
                  color: PRIMARY,
                  size: 20,
                )
              : Icon(
                  Icons.cancel,
                  color: DARK_TEXT,
                  size: 20,
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
          elevation: 1.0,
          color: WHITE,
          margin:
              EdgeInsets.only(bottom: 12.0, top: 12.0, left: 12.0, right: 12.0),
          child: Container(
            margin: EdgeInsets.only(top: 12, bottom: 12),
            child: Column(
              children: <Widget>[
                _detailTopSection(),
                // detailMiddle(),
//                _detailBottom(
//                    MyLocalizations.of(context).invoiceName, taxPayerName),
//                _detailBottom(MyLocalizations.of(context).nit, taxpayerId),
                _detailBottom(MyLocalizations.of(context).subTotal,
                    '$currency' + subTotal ?? ''),
                _detailBottom(
                    MyLocalizations.of(context).deliveryCharges,
                    (deliveryCharge == MyLocalizations.of(context).free
                                ? ''
                                : '$currency') +
                            deliveryCharge ??
                        ''),
                _detailBottom(MyLocalizations.of(context).grandTotal,
                    '$currency' + grandTotal ?? ''),
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
                              "$currency${products[i]['price'] * products[i]['Quantity']}",
                              style:
                                  TextStyle(fontSize: 10, color: Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        products[i]['note'] != null
                            ? SizedBox(
                                width: 230,
                                child: Text(
                                  '${MyLocalizations.of(context).note} : ${products[i]['note'].toString()}',
                                  style: labelLight(),
                                ),
                              )
                            : Container(),
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
                                      '$currency${products[i]['extraIngredients'][j]['price'].toString()}' ??
                                          '',
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.black),
                                    )
                                  ]);
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(),
                            Text('$currency${products[i]['totalPrice']}',
                                style: textPrimary()),
                          ],
                        ),
                        ((products[i]['flavour']?.length ?? 0) > 0)
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    MyLocalizations.of(context).flavour,
                                    style: labelLarge(),
                                  ),
                                  ListView.builder(
                                      physics: ScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount:
                                          products[i]['flavour']?.length ?? 0,
                                      itemBuilder: (context, f) {
                                        return Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Text(
                                            "${products[i]['flavour'][f]['flavourName']}  X  ${products[i]['flavour'][f]['quantity']}",
                                            style: labelLight(),
                                          ),
                                        );
                                      }),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
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
