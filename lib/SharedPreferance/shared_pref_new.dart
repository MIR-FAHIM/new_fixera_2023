import 'package:shared_preferences/shared_preferences.dart';

class SharedPreffNew {

  static String? token;




  static bool appLoginStatus = false;
  static SharedPreffNew to = SharedPreffNew();
  initial()async{
    prefssNew = await SharedPreferences.getInstance();
  }

  SharedPreferences? prefssNew;
  static String? userID ;
  static String? packageID;
  static String? userType;

}
