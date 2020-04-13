import 'dart:async';

import 'package:Kitchenapp/services/auth.dart';
import 'package:Kitchenapp/services/initialize_i18n.dart';
import 'package:Kitchenapp/services/localizations.dart'
    show MyLocalizationsDelegate;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/main/order-list.dart';
import './screens/auth/login.dart';
import './styles/styles.dart';
import 'screens/auth/login.dart';
import 'screens/main/order-list.dart';
import 'services/common.dart';
import 'services/constant.dart';
import 'styles/styles.dart';

bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}

Future<void> main() async {
  // Stetho.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  Map<String, Map<String, String>> localizedValues = await initializeI18n();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String locale = prefs.getString('selectedLanguage') == null
      ? 'en'
      : prefs.getString('selectedLanguage');
  FlutterError.onError = (FlutterErrorDetails details) async {
    if (isInDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  tokenCheck(locale, localizedValues);
  runZoned<Future<Null>>(() async {
    runApp(new MyApp(locale, localizedValues));
  }, onError: (error, stackTrace) async {});
}

void tokenCheck(locale, localizedValues) {
  Common.getToken().then((tokenVerification) async {
    if (tokenVerification != null) {
      AuthService.verifyTokenOTP(tokenVerification).then((verifyInfo) async {
        if (verifyInfo['success'] == true) {
        } else {
          Common.removeToken();
        }
      });
    }
  });
}

class MyApp extends StatefulWidget {
  final Map<String, Map<String, String>> localizedValues;
  final String locale;
  MyApp(this.locale, this.localizedValues);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loginIn = false;
  bool loginCheck = false;
  @override
  void initState() {
    super.initState();
    loginInCheck();
  }

  loginInCheck() {
    Common.getToken().then((value) {
      if (value != null) {
        if (mounted) {
          setState(() {
            loginIn = true;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            loginIn = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale(widget.locale),
      localizationsDelegates: [
        MyLocalizationsDelegate(widget.localizedValues),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: LANGUAGES.map((language) => Locale(language, '')),
      debugShowCheckedModeBanner: false,
      title: APP_NAME,
      theme: ThemeData(
        primaryColor: PRIMARY,
        brightness: Brightness.light,
      ),
      home: loginIn
          ? OrderList(
              locale: widget.locale,
              localizedValues: widget.localizedValues,
            )
          : Login(
              locale: widget.locale,
              localizedValues: widget.localizedValues,
            ),
    );
  }
}
