import 'package:flutter/material.dart';
import '../../styles/styles.dart';
import 'add-products.dart';
import 'view-products.dart';
import '../../localizations.dart' show MyLocalizations, MyLocalizationsDelegate;

// CouponCard

class Products extends StatefulWidget {
  static String tag = "Products";
  final Map<String, Map<String, String>> localizedValues;
  final String locale;
  Products({Key key, this.locale, this.localizedValues}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  bool _value = true;
  String message = 'Available';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(MyLocalizations.of(context).products,
              style: headerDefaultColor()),
          elevation: 0.0,
          iconTheme: new IconThemeData(color: WHITE),
        ),
        body: SingleChildScrollView(
          child: Container(
              child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Flexible(
                      flex: 8,
                      fit: FlexFit.tight,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: PRIMARY),
                            borderRadius:
                                BorderRadius.all(Radius.circular(9.0))),
                        child: new Row(
                          children: <Widget>[
                            Flexible(
                              flex: 4,
                              fit: FlexFit.tight,
                              child: new TextFormField(
                                decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    hintText: MyLocalizations.of(context)
                                        .searchProduct,
                                    hintStyle: primaryText(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10.0)),
                                keyboardType: TextInputType.text,
                                style: primaryText(),
                              ),
                            ),
                            Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: new Icon(Icons.search, color: PRIMARY)),
                          ],
                        ),
                      )),
                  Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      child: Container(
                        height: 35.0,
                        margin: EdgeInsets.only(right: 10.0, top: 0.0),
                        color: PRIMARY,
                        padding: EdgeInsets.only(right: 10.0, left: 10.0),
                        child: RawMaterialButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddProducts(
                                        locale: widget.locale,
                                        localizedValues:
                                            widget.localizedValues)),
                              );
                            },
                            child: Text(
                              MyLocalizations.of(context).addProducts,
                              style: whitetext(),
                            )),
                      ))
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0, top: 20.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      flex: 7,
                      fit: FlexFit.tight,
                      child: Text(
                        MyLocalizations.of(context).productName,
                        style: blacktext(),
                      ),
                    ),
                    Flexible(
                      flex: 6,
                      fit: FlexFit.tight,
                      child: Text(
                        MyLocalizations.of(context).enableDisable,
                        style: blacktext(),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: Text(
                        MyLocalizations.of(context).view,
                        style: blacktext(),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: Text(
                        MyLocalizations.of(context).edit,
                        style: blacktext(),
                      ),
                    ),
                  ],
                ),
              ),
              productsDetails(),
              productsDetails(),
              productsDetails(),
              productsDetails(),
            ],
          )),
        ));
  }

  Widget productsDetails() {
    return Container(
      margin: EdgeInsets.only(left: 20.0, top: 20.0),
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 7,
            fit: FlexFit.tight,
            child: Text(
              "Green Salad",
              style: greytext(),
            ),
          ),
          Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Container(
                alignment: Alignment.center,
                width: 30.0,
                child: new Switch(
                  value: _value,
                  activeColor: Colors.white,
                  activeTrackColor: PRIMARY,
                  onChanged: _changeValue,
                ),
              )),
          Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Container(
                  child: IconButton(
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: GRAY,
                        size: 20.0,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewProducts()),
                        );
                      }))),
          Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Container(
                child: Icon(
                  Icons.edit,
                  color: PRIMARY,
                  size: 20.0,
                ),
              )),
        ],
      ),
    );
  }

  void _changeValue(bool value) {
    setState(() {
      if (value) {
        message = 'Available';
        _value = true;
        _value = true;
      } else {
        message = 'Not available';
        _value = false;
      }
    });
  }
}
