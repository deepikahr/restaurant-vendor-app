import 'package:Kitchenapp/screens/main/reports.dart';
import 'package:Kitchenapp/services/localizations.dart' show MyLocalizations;
import 'package:flutter/material.dart';
import '../../styles/styles.dart';
import '../auth/login.dart';
import './order-list.dart';
import './orders-history.dart';
import '../../services/common.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import '../../main.dart';

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

  List<String> languages = ['English', 'French', 'Arbic', 'Chinese'];

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
      } else if (selectedLanguage == 'zh') {
        selectedLocale = 'Chinese';
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
            _tile(
                MyLocalizations.of(context).home,
                Icons.arrow_forward_ios,
                OrderList(
                  locale: widget.locale,
                  localizedValues: widget.localizedValues,
                )),
            _tile(
                MyLocalizations.of(context).orderHistory,
                Icons.arrow_forward_ios,
                OrderHistory(
                  locale: widget.locale,
                  localizedValues: widget.localizedValues,
                )),
            _tile(
                MyLocalizations.of(context).reports,
                Icons.arrow_forward_ios,
                Reports(
                  locale: widget.locale,
                  localizedValues: widget.localizedValues,
                )),
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
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  MyApp("en", widget.localizedValues),
                            ),
                            (Route<dynamic> route) => false);
                      } else if (newValue == 'Arbic') {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('selectedLanguage', 'ar');
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => MyApp(
                                "ar",
                                widget.localizedValues,
                              ),
                            ),
                            (Route<dynamic> route) => false);
                      } else if (newValue == 'Chinese') {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('selectedLanguage', 'zh');
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  MyApp('zh', widget.localizedValues),
                            ),
                            (Route<dynamic> route) => false);
                      } else {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('selectedLanguage', 'fr');
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MyApp('fr', widget.localizedValues)),
                            (Route<dynamic> route) => false);
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

  Widget _tile(String title, IconData icon, Widget routeName) => Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: Color(0xFFf29000000)),
          ),
        ),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => routeName,
              ),
            );
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
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => Login(
                  locale: widget.locale,
                  localizedValues: widget.localizedValues,
                )),
        (Route<dynamic> route) => false);
  }
}
