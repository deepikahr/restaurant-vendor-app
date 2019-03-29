import 'package:flutter/material.dart';
import '../widgets/order-item.dart';
import '../widgets/no-data.dart';
import '../widgets/avatar.dart';
import '../../styles/styles.dart';
import 'package:async_loader/async_loader.dart';
import '../../services/orders.dart';
// import '../../screens/main/order-details.dart';
// CouponCard

class OrderDetails extends StatefulWidget {
  static String tag = "orderDetails";
  var orderData;
  OrderDetails({Key key, this.orderData}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {

    final GlobalKey<AsyncLoaderState> _asyncLoaderState = GlobalKey<AsyncLoaderState>();
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();  
    dynamic data;

  String customerName;
  String customerEmail;
  String customerContact;
  String paymentMethod;
  String shippingAddress;
  String taxInfo;
  String deliveryCharge;
  String subTotal;
  String grandTotal;
  String charges;
  String payableAmount;



  @override
  void initState(){
    super.initState();
    getOrderDetail();
  }

  Future<List<dynamic>> getOrderDetail() async {
    await OrderServices.getOrderHistory().then((onValue){
      print("Order detail---");
      print(onValue[0]['paymentOption']);

      customerName =onValue[0]['userInfo']['name'];
      customerContact =onValue[0]['userInfo']['contactNumber'].toString();
      customerEmail =onValue[0]['userInfo']['email'];
      paymentMethod =onValue[0]['paymentOption'];
      shippingAddress =onValue[0]['shippingAddress']['address'];
      taxInfo =onValue[0]['taxInfo']['taxName'];
      deliveryCharge =onValue[0]['deliveryCharge'].toString();
      subTotal =onValue[0]['subTotal'].toString();
      grandTotal =onValue[0]['grandTotal'].toString();
      charges =onValue[0]['charges'].toString();
      payableAmount =onValue[0]['payableAmount'].toString();


     setState(() {
       var resultData = onValue;
       data =resultData;
     });
    });
    return data;
  }


 


 Widget build(BuildContext context) {
    var asyncLoader = AsyncLoader(
      key: _asyncLoaderState,
      initState:  () async => await getOrderDetail(),
      renderLoad: () => Center(child: new CircularProgressIndicator()),
      renderError: ([error]) => NoData(message: 'Something went wrong..'),
      renderSuccess: ({data}) => data.length == 0
            ? NoData(message: 'No Order History')
            : Container(
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


             
            // child: ListView.builder(
            //     itemCount: data[0] == null ? 0 : data.length,
            //     itemBuilder: (BuildContext context, dynamic index) {

            //       return SingleChildScrollView( 
            //         child: Container(
            //           width: screenWidth(context),
            //           child: Column(
            //             children: <Widget>[
            //               Card(
            //                   elevation: 5.0,
            //                   margin: EdgeInsets.only(top: 12.0, bottom: 6),
            //                   shape: RoundedRectangleBorder(
            //                       borderRadius: BorderRadius.circular(0)),
            //                   child: Column(
            //                     children: <Widget>[
            //                       OrderItem(
            //                         imgurl:
            //                             'https://images.unsplash.com/photo-1490717064594-3bd2c4081693?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60R',
            //                         orderId: '${data[0]['orderID']}',
            //                         dateTime: '09.08/19',
            //                         details:'ghjgjh',
            //                         price: ' \$ 56',
            //                             paymentMethod:
            //                                 ' - cod',
            //                         statusLabel: 'Status ',
            //                         status: 'succes',
            //                       ),
            //                       // _bottomSection()
            //                     ],
            //                   )),
            //             ],
            //           ),
            //         ),
            //       );
            //     }),
    );

    return Scaffold(
        backgroundColor: WHITE,
        appBar: AppBar(
          title: Text("Order Details", style: headerDefaultColor()),
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
            "Customer and Payment Info",
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
                  _customerSection(Icons.account_circle, 'Name', customerName!=null ? customerName : ''),
                  _customerSection(
                      Icons.location_on, 'Locaiton', shippingAddress!=null ? shippingAddress : ''),
                  _customerSection(
                      Icons.contact_phone, 'Contact', customerContact!=null ? customerContact : ''),
                  _customerSection(
                      Icons.email, 'Email', customerEmail!=null ? customerEmail : ''),
                  _customerSection(
                      Icons.payment, 'Payment Method', paymentMethod!=null ? paymentMethod : ''),
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
      child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
               Icon(
                  icon,
                  color: DARK_TEXT,
                  size: 16,
                ),
                
                 Padding(
                    padding: EdgeInsets.only(left: 10.0,right: 10.0),
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
          "Order Details",
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
                _detailTopSection(),
                _detailMiddle(),
                _detailBottom('Taxes', taxInfo!=null ? taxInfo : ''),
                _detailBottom('Delivery Charges', deliveryCharge!=null ? deliveryCharge : ''),
                _detailBottom('Sub Total', subTotal!=null ? subTotal : ''),
                _detailBottom('Grand Total', grandTotal!=null ? grandTotal : ''),
                _detailBottom('Chrages', charges!=null ? charges : ''),
                _detailBottom('Payable Amount', payableAmount!=null ? payableAmount : ''),

              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _detailTopSection() {
    return Container(
        child: new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 2,
                child: Avatar(
                  imgurl:
                      "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg",
                ),
              ),
              Flexible(
                flex: 8,
                child: Container(
                  padding: EdgeInsets.only(right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text("Perri perri pizza", style:labelLarge()),
                        Padding(padding: EdgeInsets.only(right: 8.0, bottom: 5.0),),
                        Text("XL", style:labelLight()),
                      ],
                    ),
                    Text("\$ 34", style: textPrimary(),),
                  ],
                ),),    
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 2,
                child: Avatar(
                  imgurl:
                      "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg",
                ),
              ),
              Flexible(
                flex: 8,
                child: Container(
                  padding: EdgeInsets.only(right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text("Perri perri pizza", style:labelLarge()),
                        Padding(padding: EdgeInsets.only(right: 8.0, bottom: 5.0),),
                        Text("XL", style:labelLight()),
                      ],
                    ),
                    Text("\$ 34", style: textPrimary(),),
                  ],
                ),),    
              ),
            ],
          ),
        ),
      ],
    ));
  }

  Widget _detailMiddle() {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Container(
                width: screenWidth(context) * 0.7,
                child: Text(
                  'Send Request to Stevenson about not availability of product',
                  style: labelLight(),
                ),
              ),
            ],
          ),
          new Container(
            width: screenWidth(context) * 0.2,
            child: FlatButton(
              onPressed: () {},
              child: const Text('SEND'),
              textColor: PRIMARY,
              padding: EdgeInsets.all(0),
            ),
          ),
        ],
      ),
    );
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
