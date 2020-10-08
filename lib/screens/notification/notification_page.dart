import 'package:flutter/material.dart';

import '../../main.dart';

class HomeNotification extends StatefulWidget {
  final Map<String, Map<String, String>> localizedValues;
  final String locale;

  const HomeNotification({Key key, this.localizedValues, this.locale})
      : super(key: key);

  @override
  _HomeNotificationState createState() => _HomeNotificationState();
}

class _HomeNotificationState extends State<HomeNotification> {
  bool isLoading = true;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () async {
      goToHome();
    });
    super.initState();
  }

  goToHome() {
    main();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading ? CircularProgressIndicator() : Container(),
      ),
    );
  }
}
