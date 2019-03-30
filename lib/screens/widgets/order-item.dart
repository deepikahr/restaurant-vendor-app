import 'package:flutter/material.dart';
import '../../styles/styles.dart';
import './avatar.dart';

class OrderItem extends StatelessWidget {
  final String imgurl;
  final String orderId;
  final String price;
  final String paymentMethod;
  final String dateTime;
  final String details;
  final String status;
  final String statusLabel;

  OrderItem(
      {Key key,
      this.imgurl,
      this.orderId,
      this.price,
      this.paymentMethod,
      this.dateTime,
      this.details,
      this.status,
      this.statusLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.0,
      child: new Row(
        children: <Widget>[
          _leftSection(),
          _rightSection(context),
        ],
      ),
    );
  }

  Widget _leftSection() {
    return Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: const BoxDecoration(
            border: Border(
          right: BorderSide(width: 1.0, color: Color(0xFFf29000000)),
        )),
        child: Avatar(imgurl: imgurl));
  }

  Widget _rightSection(context) {
    return Expanded(
      child: Container(
          child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: const BoxDecoration(
                border: Border(
              bottom: BorderSide(width: 1.0, color: Color(0xFFf29000000)),
            )),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Order ID: #" + orderId ?? '',
                  style: labelLarge(),
                ),
                new Row(
                  children: <Widget>[
                    new Text(dateTime ?? '', style: labelLight()),
                  ],
                ),
              ],
            ),
          ),
          new Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: const BoxDecoration(
                border: Border(
              bottom: BorderSide(width: 1.0, color: Color(0xFFf29000000)),
            )),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 4.0),
                  child: Icon(Icons.map, color: Colors.grey),
                ),
                Text(
                  details ?? '',
                  style: textGray(),
                )
              ],
            ),
          ),
          new Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Text(
                      statusLabel ?? '',
                      style: label(),
                    ),
                    new Text(
                      status ?? '',
                      style: labelLight(),
                    ),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Text(
                      price ?? '',
                      style: label(),
                    ),
                    new Text(paymentMethod ?? '', style: textSuccess()),
                  ],
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
