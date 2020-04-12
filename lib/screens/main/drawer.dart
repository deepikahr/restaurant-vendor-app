import 'package:flutter/material.dart';
import '../../styles/styles.dart';
import './order-list.dart';
import './orders-history.dart';
import '../auth/login.dart';
import '../../services/common.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import '../../main.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../constant.dart' show languages;
import '../../localizations.dart' show MyLocalizations, MyLocalizationsDelegate;

class Menu extends StatefulWidget {
  final Map<String, Map<String, String>> localizedValues;
  final String locale;
  final GlobalKey<ScaffoldState> scaffoldKey;
  Menu({Key key, this.scaffoldKey, this.locale, this.localizedValues})
      : super(key: key);

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
    getData();
  }

  String selectedLanguages, selectedLang;

  List<String> languages = ['English', 'French', 'Arbic'];

  var selectedLanguage, selectedLocale;

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        selectedLanguage = prefs.getString('selectedLanguage');
      });
      if (selectedLanguage == 'en') {
        selectedLocale = 'English';
      } else if (selectedLanguage == 'fr') {
        selectedLocale = 'French';
      } else if (selectedLanguage == 'ar') {
        selectedLocale = 'Arbic';
      }
    }
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
            _tile(MyLocalizations.of(context).home, Icons.arrow_forward_ios,
                OrderList.tag),
            _tile(MyLocalizations.of(context).orderHistory,
                Icons.arrow_forward_ios, OrderHistory.tag),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Color(0xFFf29000000)),
                ),
              ),
              child: ListTile(
                title: Text(MyLocalizations.of(context).logout,
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
            Container(
              // margin: EdgeInsets.only(top: 10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
              ),
              child: ListTile(
                title: Text(MyLocalizations.of(context).selectLanguages),
                trailing: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    hint: Text(
                        selectedLocale == null ? 'English' : selectedLocale),
                    value: selectedLanguages,
                    onChanged: (newValue) async {
                      if (newValue == 'English') {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('selectedLanguage', 'en');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                MyApp(widget.locale, widget.localizedValues),
                          ),
                        );
                      } else if (newValue == 'Arbic') {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('selectedLanguage', 'ar');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                MyApp(widget.locale, widget.localizedValues),
                          ),
                        );
                      } else {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('selectedLanguage', 'fr');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                MyApp(widget.locale, widget.localizedValues),
                          ),
                        );
                      }
                    },
                    items: languages.map((lang) {
                      return DropdownMenuItem(
                        child: new Text(lang),
                        value: lang,
                      );
                    }).toList(),
                  ),
                ),
              ),
            )
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
