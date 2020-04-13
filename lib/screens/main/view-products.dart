import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import '../../styles/styles.dart';
import '../../localizations.dart' show MyLocalizations, MyLocalizationsDelegate;

class ViewProducts extends StatefulWidget {
  static String tag = "ViewProducts";
  final Map<String, Map<String, String>> localizedValues;
  final String locale;
  ViewProducts({Key key, this.locale, this.localizedValues}) : super(key: key);

  @override
  _ViewProductsState createState() => _ViewProductsState();
}

class _ViewProductsState extends State<ViewProducts> {
  String message = 'Available';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BG_COLOR,
        appBar: AppBar(
          title: Text(MyLocalizations.of(context).viewProducts,
              style: headerDefaultColor()),
          elevation: 0.0,
          iconTheme: new IconThemeData(color: WHITE),
        ),
        body: SingleChildScrollView(
          child: Container(
              child: Column(
            children: <Widget>[
              Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                          flex: 8,
                          fit: FlexFit.tight,
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 10.0),
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      flex: 4,
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
                                        'Green Salad',
                                        style: greytext(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 10.0),
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      flex: 4,
                                      fit: FlexFit.tight,
                                      child: Text(
                                        MyLocalizations.of(context).brand,
                                        style: blacktext(),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 6,
                                      fit: FlexFit.tight,
                                      child: Text(
                                        '',
                                        style: greytext(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 10.0),
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      flex: 4,
                                      fit: FlexFit.tight,
                                      child: Text(
                                        MyLocalizations.of(context).category,
                                        style: blacktext(),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 6,
                                      fit: FlexFit.tight,
                                      child: Text(
                                        '',
                                        style: greytext(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 10.0),
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      flex: 4,
                                      fit: FlexFit.tight,
                                      child: Text(
                                        MyLocalizations.of(context).description,
                                        style: blacktext(),
                                      ),
                                    ),
                                    Flexible(
                                        flex: 6,
                                        fit: FlexFit.tight,
                                        child: Text(
                                          '',
                                          style: greytext(),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          )),
                      Flexible(
                          flex: 3,
                          fit: FlexFit.tight,
                          child: Image.asset('lib/assets/images/sass.png'))
                    ],
                  )),
              Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        MyLocalizations.of(context).variant,
                        style: boldtext(),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 10.0)),
                      Table(
                        children: <TableRow>[
                          TableRow(children: <Widget>[
                            Text(
                              MyLocalizations.of(context).serial,
                              style: blacktext(),
                            ),
                            Text(
                              'MRP',
                              style: blacktext(),
                            ),
                            Text(
                              MyLocalizations.of(context).discount,
                              style: blacktext(),
                            ),
                            Text(
                              MyLocalizations.of(context).price,
                              style: blacktext(),
                            ),
                          ]),
                          TableRow(children: <Widget>[
                            TableCell(
                                child: Text(
                              '1',
                              style: greytext(),
                            )),
                            TableCell(child: Text('150', style: greytext())),
                            TableCell(child: Text('0', style: greytext())),
                            TableCell(child: Text('150', style: greytext()))
                          ]),
                          TableRow(children: <Widget>[
                            TableCell(
                                child: Text(
                              '1',
                              style: greytext(),
                            )),
                            TableCell(child: Text('150', style: greytext())),
                            TableCell(child: Text('0', style: greytext())),
                            TableCell(child: Text('150', style: greytext()))
                          ]),
                          TableRow(children: <Widget>[
                            TableCell(
                                child: Text(
                              '1',
                              style: greytext(),
                            )),
                            TableCell(child: Text('150', style: greytext())),
                            TableCell(child: Text('0', style: greytext())),
                            TableCell(child: Text('150', style: greytext()))
                          ])
                        ],
                      )
                    ],
                  )),
              Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        MyLocalizations.of(context).extraVariant,
                        style: boldtext(),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 10.0)),
                      Table(
                        children: <TableRow>[
                          TableRow(children: <Widget>[
                            Text(
                              MyLocalizations.of(context).serial,
                              style: blacktext(),
                            ),
                            Text(
                              MyLocalizations.of(context).name,
                              style: blacktext(),
                            ),
                            Text(
                              MyLocalizations.of(context).price,
                              style: blacktext(),
                            ),
                          ]),
                          TableRow(children: <Widget>[
                            TableCell(
                                child: Text(
                              '1',
                              style: greytext(),
                            )),
                            TableCell(child: Text('', style: greytext())),
                            TableCell(child: Text('', style: greytext()))
                          ]),
                          TableRow(children: <Widget>[
                            TableCell(
                                child: Text(
                              '2',
                              style: greytext(),
                            )),
                            TableCell(child: Text('', style: greytext())),
                            TableCell(child: Text('', style: greytext())),
                          ]),
                          TableRow(children: <Widget>[
                            TableCell(
                                child: Text(
                              '3',
                              style: greytext(),
                            )),
                            TableCell(child: Text('', style: greytext())),
                            TableCell(child: Text('', style: greytext()))
                          ])
                        ],
                      )
                    ],
                  )),
            ],
          )),
        ));
  }
}
