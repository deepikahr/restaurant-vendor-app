// import 'package:flutter/material.dart';
// import './screens/main/order-list.dart';
// import './screens/main/orders-history.dart';
// import './screens/auth/login.dart';
// import './screens/main/settings.dart';
// import './styles/styles.dart';
// // import 'package:flutter_stetho/flutter_stetho.dart';
// import 'services/common.dart';
// import 'services/constant.dart';
// import './screens/main/products.dart';
// import './screens/main/add-products.dart';
// import 'initialize_i18n.dart' show initializeI18n;
// import 'constant.dart' show languages;
// import 'localizations.dart' show MyLocalizationsDelegate;

// main() async {
//   // Stetho.initialize();
//   WidgetsFlutterBinding.ensureInitialized();
//   Map<String, Map<String, String>> localizedValues = await initializeI18n();
//   String _locale = 'en';

//   Common.getToken().then((loggedIn) {
//     if (loggedIn != null)
//       runApp(MyApp(route: OrderList()));
//     else
//       runApp(MyApp(route: Login()));
//   });
// }

// class MyApp extends StatelessWidget {
//   final route;
//   final routes = <String, WidgetBuilder>{
//     Login.tag: (context) => Login(),
//     OrderList.tag: (context) => OrderList(),
//     OrderHistory.tag: (context) => OrderHistory(),
//     Settings.tag: (context) => Settings(),
//     Products.tag: (context) => Products(),
//     AddProducts.tag: (context) => AddProducts(),
//   };

//   MyApp({this.route});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: APP_NAME,
//       theme: ThemeData(
//         primaryColor: PRIMARY,
//         brightness: Brightness.light,
//       ),
//       home: route,
//       routes: routes,
//     );
//   }
// }

import 'package:flutter/material.dart';
import './screens/main/order-list.dart';
import './screens/main/orders-history.dart';
import './screens/auth/login.dart';
import './screens/main/settings.dart';
import 'services/common.dart';
import 'services/constant.dart';
import './screens/main/products.dart';
import './screens/main/add-products.dart';
import './services/auth.dart';
import './services/common.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
// import './onesignal_flutter.dart';

import 'initialize_i18n.dart' show initializeI18n;
import 'constant.dart' show languages;
import 'localizations.dart' show MyLocalizationsDelegate;

import './styles/styles.dart';
import './services/constant.dart';

// import 'package:provider/provider.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Map<String, Map<String, String>> localizedValues = await initializeI18n();
  String _locale = 'en';
  FlutterError.onError = (FlutterErrorDetails details) async {
    if (isInDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };
  // tokenCheck();
  runZoned<Future<Null>>(() async {
    runApp(new MyApp(
      _locale,
      localizedValues,
    ));
  }, onError: (error, stackTrace) async {});
}

class MyApp extends StatefulWidget {
  final Map<String, Map<String, String>> localizedValues;
  final String locale;

  MyApp(this.locale, this.localizedValues);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;
  @override
  void initState() {
    super.initState();
    getData();
    loggedIN();
  }

  var selectedLanguage;
  loggedIN() async {
    Common.getToken().then((loggedIn) {
      if (loggedIn != null) {
        setState(() {
          isLoggedIn = true;
        });
      } else {
        setState(() {
          isLoggedIn = false;
        });
      }
    });
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        selectedLanguage = prefs.getString('selectedLanguage');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale:
          Locale(selectedLanguage == null ? widget.locale : selectedLanguage),
      localizationsDelegates: [
        MyLocalizationsDelegate(widget.localizedValues),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: languages.map((language) => Locale(language, '')),
      debugShowCheckedModeBanner: false,
      title: APP_NAME,
      theme: ThemeData(
        // fontFamily: FONT_FAMILY,
        primaryColor: PRIMARY,
        accentColor: PRIMARY,
      ),
      home: isLoggedIn
          ? OrderList(
              locale:
                  selectedLanguage == null ? widget.locale : selectedLanguage,
              localizedValues: widget.localizedValues)
          : Login(
              locale:
                  selectedLanguage == null ? widget.locale : selectedLanguage,
              localizedValues: widget.localizedValues),
    );
  }
}
