import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseFunctions {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static void initializeMassaging() async {
    messaging = FirebaseMessaging.instance;
  }

  static Future<String> getToken() async {
    String token = (await messaging.getToken()).toString();
    print("TOKEN___PRINT___HO___$token");
    return token;
  }
}
