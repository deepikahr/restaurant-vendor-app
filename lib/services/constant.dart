import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  // app name
  static const APP_NAME = "Kitchen App";

  // delopy url production
  static String apiUrl = DotEnv().env['API_URL'];

  // local socketUrl
  static String apiEndPoint = apiUrl + 'api/';

  // ONE_SIGNAL_KEY
  static String oneSignalKey = DotEnv().env['ONE_SIGNAL_KEY'];

  // googleapikey
  static String googleMapApiKey = DotEnv().env['GOOGLE_MAP_API_KEY'];

  // language list
  static List<String> languagesList = ['en', 'fr', 'ar', 'zh'];
}
