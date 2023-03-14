import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static String? myToken ;
  static String? location;
  static var status;
  static SharedPref to = SharedPref();
  late SharedPreferences prefss;

  initial() async {
    prefss = await SharedPreferences.getInstance();
  }


}
