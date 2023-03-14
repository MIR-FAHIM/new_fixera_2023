import 'dart:async';
import 'dart:convert';
import 'package:new_fixera/SharedPreferance/shared_pref_new.dart';
import 'package:new_fixera/SharedPreferance/shared_preferance.dart';
import 'package:new_fixera/Views/Utilities/AppColors.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:new_fixera/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_fixera/Controller/ExportController.dart';
import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/Repositories/repository.dart';
import 'package:http/http.dart' as http;

var paymentCheck;

class SplashPage extends StatefulWidget {


  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  ImagepermissionController? imagepermissionController;

  var tokenVal;
  //HomeApiController homeApiController;

  getUser() async {
    user = await prefs!.getString("userInfo");
    userMap = jsonDecode(user!);
  }

  getStatus() async {

    print("TOKENNNNNNNNNN   $tokenVal");
    print("Calleeeeeddd");
    var headers = {
      'Authorization':
          'Bearer $tokenVal'
    };

    var response = await http.get(
        Uri.parse('https://www.fix-era.com/api/v1/user-profile'),
        headers: headers);

    print('Response_APPBD_SERVER ${response.statusCode}');

    try {
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        print("VALUE_VALUE_BRO_$result");

        print("Result" + result.toString());
        print("Profile " +
            result['user_info']['profile_completion_status'].toString());
        print("I AM 200+++++++++++++++++++++++++++++++");

        paymentCheck =
            result['user_info']['profile_completion_status'].toString();

        print("PAYMENT STATUS: " + paymentCheck);
      } else {
        print("I AM ELSE+++++++++++++++++++++++++++");
      }
    } on Exception catch (e) {
      print("Catch: " + e.toString());
    }
  }

  @override
  void initState() {
   // tokenVal= SharedPref.to.prefss!.getString("token");

   // getStatus();

    startTime();

    //getUser();

    super.initState();
  }

  startTime() async {
    var _duration = new Duration(milliseconds: 5000);
    Timer(_duration, navigationPage);
    imagepermissionController = Get.put(
        ImagepermissionController(
          repository: MyRepository(
            apiClient: MyApiClient(
              httpClient: http.Client(),
            ),
          ),
        ),
        permanent: true);
    //  homeApiController = Get.put(
    // HomeApiController(),
    // permanent: true
    // );
  }

  void navigationPage() async {
    try {



           Get.offAndToNamed(AppRoutes.CAROUSELPAGE);

    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: AppColors.backgroundColor,
          child: Container(
            alignment: Alignment.center,
            color: AppColors.backgroundColor,
            child: Image.asset(
              'images/fixera_logo.png',
              height: 150,
            ),
          ),
        ),
      ),
    );
  }
}
