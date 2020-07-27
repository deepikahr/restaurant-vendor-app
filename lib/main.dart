import 'dart:async';

import 'package:Kitchenapp/services/auth.dart';
import 'package:Kitchenapp/services/initialize_i18n.dart';
import 'package:Kitchenapp/services/localizations.dart'
    show MyLocalizationsDelegate;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/main/order-list.dart';
import './screens/auth/login.dart';
import './styles/styles.dart';
import 'screens/auth/login.dart';
import 'screens/main/order-list.dart';
import 'services/common.dart';
import 'services/constant.dart';
import 'styles/styles.dart';

AudioPlayer audioPlayer = AudioPlayer();

bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}

Future<void> main() async {
  // Stetho.initialize();
  await DotEnv().load('.env');
  WidgetsFlutterBinding.ensureInitialized();
  Map localizedValues = await initializeI18n();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String locale = prefs.getString('selectedLanguage') ?? "en";
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
    // ignore: deprecated_member_use
  }, onError: (error, stackTrace) async {});
}

void tokenCheck(locale, localizedValues) {
  print("jjj");
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
  final Map localizedValues;
  final String locale;
  MyApp(this.locale, this.localizedValues);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loginIn = false, loginCheck = false;
  Timer oneSignalTimer;
  @override
  void initState() {
    getGlobalSettingsData();
    super.initState();
    print("getGlobalSettingsData");
  }

  @override
  void dispose() {
    super.dispose();
    setState(() {
      audioPlayer.stop();
      audioPlayer.dispose();
    });
  }

  Future<void> initOneSignal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) async {
      if (notification != null) {
        await audioPlayer.play(
            "https://www.mediacollege.com/audio/tone/files/250Hz_44100Hz_16bit_05sec.wav");
      }
    });
    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {});
    OneSignal.shared.init(Constants.oneSignalKey, iOSSettings: {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.inAppLaunchUrl: true
    });
    OneSignal.shared.setInFocusDisplayType(
      OSNotificationDisplayType.notification,
    );

    OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
    var status = await OneSignal.shared.getPermissionSubscriptionState();
    String playerId = status.subscriptionStatus.userId;
    if (playerId != null) {
      prefs.setString("playerId", playerId);
      if (mounted) {
        setState(() {
          loginCheck = false;
        });
      }

      if (oneSignalTimer != null && oneSignalTimer.isActive)
        oneSignalTimer.cancel();
    }
  }

  getGlobalSettingsData() async {
    if (mounted) {
      setState(() {
        loginCheck = true;
      });
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("kk");
    await AuthService.getAdminSettings().then((onValue) {
      print(onValue);
      var adminSettings = onValue;
      oneSignalTimer = Timer.periodic(Duration(seconds: 2), (timer) {
        initOneSignal();
      });

      loginInCheck();
      if (adminSettings['currency'] == null) {
        prefs.setString('currency', '\$');
      } else {
        prefs.setString(
            'currency', '${adminSettings['currency']['currencySymbol']}');
      }
    }).catchError((onError) {
      print(onError);
    });
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
        MyLocalizationsDelegate(widget.localizedValues, [widget.locale]),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale(widget.locale)],
      debugShowCheckedModeBanner: false,
      title: Constants.APP_NAME,
      theme: ThemeData(
        primaryColor: PRIMARY,
        brightness: Brightness.light,
        accentColor: PRIMARY,
      ),
      home: loginCheck
          ? CheckTokenScreen()
          : loginIn
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

class CheckTokenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: PRIMARY,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          'lib/assets/splash.png',
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
