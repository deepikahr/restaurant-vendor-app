import 'package:flutter/material.dart';
import '../../styles/styles.dart';
// CouponCard

class AddProducts extends StatefulWidget {
  static String tag = "AddProducts";

  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  String message = 'Available';
  var _currencies = ['Chinese', 'North', 'South'];
  var currentitem = 'Chinese';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Products", style: headerDefaultColor()),
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
                      flex: 9,
                      fit: FlexFit.tight,
                      child: Container(
                        height: 35.0,
                        margin:
                            EdgeInsets.only(right: 10.0, top: 0.0, left: 20.0),
                        color: PRIMARY,
                        padding: EdgeInsets.only(right: 10.0, left: 10.0),
                        child: RawMaterialButton(
                            onPressed: null,
                            fillColor: PRIMARY,
                            child: Text(
                              'Select Image',
                              style: whitetext(),
                            )),
                      )),
                  Flexible(
                      flex: 8,
                      fit: FlexFit.tight,
                      child: Container(
                        width: 80.0,
                        height: 80.0,
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                          color: GRAY,
                          shape: BoxShape.circle,
                        ),
                      )),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      flex: 5,
                      fit: FlexFit.tight,
                      child: Text(
                        'Location Name',
                        style: blacktext(),
                      ),
                    ),
                    Flexible(
                        flex: 8,
                        fit: FlexFit.tight,
                        child: Container(
                          decoration:
                              BoxDecoration(border: Border.all(color: GRAY)),
                          child: new TextFormField(
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Trivandrum',
                                hintStyle: greytext(),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0)),
                            keyboardType: TextInputType.text,
                            style: greytext(),
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      flex: 5,
                      fit: FlexFit.tight,
                      child: Text(
                        'Select Category',
                        style: blacktext(),
                      ),
                    ),
                    Flexible(
                        flex: 8,
                        fit: FlexFit.tight,
                        child: Container(
                            height: 39.0,
                            padding: EdgeInsets.only(left: 10.0),
                            decoration:
                                BoxDecoration(border: Border.all(color: GRAY)),
                            child: new DropdownButtonHideUnderline(
                              child: new DropdownButton<String>(
                                  items: _currencies
                                      .map((String dropDownStringItem) {
                                    return DropdownMenuItem<String>(
                                      value: dropDownStringItem,
                                      child: Text(dropDownStringItem),
                                    );
                                  }).toList(),
                                  onChanged: (String newvalue) {
                                    setState(() {
                                      this.currentitem = newvalue;
                                    });
                                  },
                                  value: currentitem,
                                  isDense: true,
                                  style: greytext()),
                            ))),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      flex: 5,
                      fit: FlexFit.tight,
                      child: Text(
                        'Product Name',
                        style: blacktext(),
                      ),
                    ),
                    Flexible(
                        flex: 8,
                        fit: FlexFit.tight,
                        child: Container(
                          decoration:
                              BoxDecoration(border: Border.all(color: GRAY)),
                          child: new TextFormField(
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintText: '',
                                hintStyle: greytext(),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0)),
                            keyboardType: TextInputType.text,
                            style: greytext(),
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      flex: 5,
                      fit: FlexFit.tight,
                      child: Text(
                        'Enter Brand Name',
                        style: blacktext(),
                      ),
                    ),
                    Flexible(
                        flex: 8,
                        fit: FlexFit.tight,
                        child: Container(
                          decoration:
                              BoxDecoration(border: Border.all(color: GRAY)),
                          child: new TextFormField(
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintText: '',
                                hintStyle: greytext(),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0)),
                            keyboardType: TextInputType.text,
                            style: greytext(),
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      flex: 5,
                      fit: FlexFit.tight,
                      child: Text(
                        'About Our Product',
                        style: blacktext(),
                      ),
                    ),
                    Flexible(
                        flex: 8,
                        fit: FlexFit.tight,
                        child: Container(
                          decoration:
                              BoxDecoration(border: Border.all(color: GRAY)),
                          child: new TextFormField(
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintText: '',
                                hintStyle: greytext(),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0)),
                            keyboardType: TextInputType.text,
                            style: greytext(),
                            maxLines: 7,
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
                alignment: Alignment.topLeft,
                child: Text(
                  'Variant Info*',
                  style: boldtext(),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Text(
                        'Size',
                        style: blacktext(),
                      ),
                    ),
                    Flexible(
                        flex: 3,
                        fit: FlexFit.tight,
                        child: Container(
                          margin: EdgeInsets.only(right: 8.0),
                          decoration:
                              BoxDecoration(border: Border.all(color: GRAY)),
                          child: new TextFormField(
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintText: 'half/full',
                                hintStyle: greytext(),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0)),
                            keyboardType: TextInputType.text,
                            style: greytext(),
                          ),
                        )),
                    Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Text(
                          'MRP',
                          style: blacktext(),
                        )),
                    Flexible(
                        flex: 4,
                        fit: FlexFit.tight,
                        child: Container(
                          margin: EdgeInsets.only(right: 40.0),
                          decoration:
                              BoxDecoration(border: Border.all(color: GRAY)),
                          child: new TextFormField(
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintText: '',
                                hintStyle: greytext(),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0)),
                            keyboardType: TextInputType.text,
                            style: greytext(),
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Text(
                        'Discount',
                        style: blacktext(),
                      ),
                    ),
                    Flexible(
                        flex: 3,
                        fit: FlexFit.tight,
                        child: Container(
                          margin: EdgeInsets.only(right: 10.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: GRAY),
                          ),
                          child: new TextFormField(
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintText: '',
                                hintStyle: greytext(),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0)),
                            keyboardType: TextInputType.text,
                            style: greytext(),
                          ),
                        )),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Text(
                        'Price',
                        style: blacktext(),
                      ),
                    ),
                    Flexible(
                        flex: 3,
                        fit: FlexFit.tight,
                        child: Container(
                          margin: EdgeInsets.only(right: 10.0),
                          decoration:
                              BoxDecoration(border: Border.all(color: GRAY)),
                          child: new TextFormField(
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintText: 'like(0)',
                                hintStyle: greytext(),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0)),
                            keyboardType: TextInputType.text,
                            style: greytext(),
                          ),
                        )),
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Container(
                          height: 36.0,
                          color: SUCCESS,
                          child: RawMaterialButton(
                            onPressed: null,
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
                alignment: Alignment.topLeft,
                child: Text(
                  'Extra Variant Info',
                  style: boldtext(),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: 20.0, top: 20.0, right: 20.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Text(
                        'Name',
                        style: blacktext(),
                      ),
                    ),
                    Flexible(
                        flex: 3,
                        fit: FlexFit.tight,
                        child: Container(
                          margin: EdgeInsets.only(right: 10.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: GRAY),
                          ),
                          child: new TextFormField(
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintText: '',
                                hintStyle: greytext(),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0)),
                            keyboardType: TextInputType.text,
                            style: greytext(),
                          ),
                        )),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Text(
                        'Price',
                        style: blacktext(),
                      ),
                    ),
                    Flexible(
                        flex: 3,
                        fit: FlexFit.tight,
                        child: Container(
                          margin: EdgeInsets.only(right: 10.0),
                          decoration:
                              BoxDecoration(border: Border.all(color: GRAY)),
                          child: new TextFormField(
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintText: '',
                                hintStyle: greytext(),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0)),
                            keyboardType: TextInputType.text,
                            style: greytext(),
                          ),
                        )),
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Container(
                          height: 36.0,
                          color: SUCCESS,
                          child: RawMaterialButton(
                            onPressed: null,
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        )),
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Container(
                          margin: EdgeInsets.only(left: 2.0),
                          height: 36.0,
                          color: PRIMARY,
                          child: RawMaterialButton(
                            onPressed: null,
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      height: 45.0,
                      color: SUCCESS,
                      child: RawMaterialButton(
                        onPressed: null,
                        child: Text(
                          'Create',
                          style: boldwhite(),
                        ),
                      ),
                    )),
                    Padding(padding: EdgeInsets.all(5.0)),
                    Expanded(
                        child: Container(
                      height: 45.0,
                      color: PRIMARY,
                      child: RawMaterialButton(
                        onPressed: null,
                        child: Text(
                          'Cancel',
                          style: boldwhite(),
                        ),
                      ),
                    ))
                  ],
                ),
              )
            ],
          )),
        ));
  }
}
