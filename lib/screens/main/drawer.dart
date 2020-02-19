import 'package:flutter/material.dart';
import '../../styles/styles.dart';
import './order-list.dart';
import './orders-history.dart';
import '../auth/login.dart';
import '../../services/common.dart';

class Menu extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  Menu({Key key, this.scaffoldKey}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int cartCounter;
  String profilePic;
  String fullname;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 100.0,
                      height: 100.0,
                      padding: EdgeInsets.fromLTRB(0, 0, 14, 0),
                      child: Image.asset('lib/assets/logos/logo.png')),
                ],
              ),
              decoration: BoxDecoration(
                color: PRIMARY,
              ),
            ),
            _tile('Home', Icons.arrow_forward_ios, OrderList.tag),
            _tile('Order History', Icons.arrow_forward_ios, OrderHistory.tag),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Color(0xFFf29000000)),
                ),
              ),
              child: ListTile(
                title: Text("Logout",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    )),
                onTap: logout,
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: PRIMARY,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tile(String title, IconData icon, String routeName) => Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: Color(0xFFf29000000)),
          ),
        ),
        child: ListTile(
          title: Text(title,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              )),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).pushNamed(routeName);
          },
          trailing: Icon(
            icon,
            color: PRIMARY,
            size: 16,
          ),
        ),
      );

  void logout() {
    Common.removeToken();
    Navigator.of(context).pushNamed(Login.tag);
  }
}
