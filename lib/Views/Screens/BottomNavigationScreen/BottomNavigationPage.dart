import 'dart:convert';

import 'package:new_fixera/Controller/ExportController.dart';
import 'package:new_fixera/Controller/SettingsController.dart';
import 'package:new_fixera/Model/LoginModel/LoginModel.dart';
import 'package:new_fixera/Model/MarketPageModel/FullProfileModel.dart';
import 'package:new_fixera/Model/user_profile_model.dart';
import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/SharedPreferance/shared_preferance.dart';
import 'package:new_fixera/Views/Screens/ContractorProfileSetting/contractor_details_skills_inappwebview.dart';
import 'package:new_fixera/Views/Screens/ContractorProfileSetting/personal_info_status1.dart';
import 'package:new_fixera/Views/Screens/ContractorScreen/ContractorPage.dart';
import 'package:new_fixera/Views/Screens/ExportScreens.dart';
import 'package:new_fixera/Views/Screens/JobScreen/JobPage.dart';
import 'package:new_fixera/Views/Screens/MarketPlaceScreen/VendorPage.dart';
import 'package:new_fixera/Views/Screens/VendorProfileSetting/profile_status_1.dart';
import 'package:new_fixera/Views/Screens/VendorProfileSetting/vendor_profile_details_inappwebview.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:new_fixera/Views/Widget/ExportWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_fixera/main.dart';
import 'package:new_fixera/Controller/PostAJobController.dart';
import 'package:new_fixera/Controller/PostALeadController.dart';
import 'package:http/http.dart' as http;

//var paymentStatus;

class BottomNavigationPage extends StatefulWidget {
  @override
  _BottomNavigationPageState createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  var tokenVal;
  SettignsController settingsController = Get.put(SettignsController());
  final HomeApiController homeApiController =
      Get.put(HomeApiController(), permanent: true);
  final MarketPlaceController marketPlaceController =
      Get.put(MarketPlaceController(), permanent: true);
  final ContractorController contractorController =
      Get.put(ContractorController(), permanent: true);
  final PostAJobController postAJobController =
      Get.put(PostAJobController(), permanent: true);
  final PostALeadController postALeadController =
      Get.put(PostALeadController(), permanent: true);
  int _currentIndex = 0;
  var _screens = [
    HomePage(),
    JobPage(),
    ContractorPage(),
    VendorPage(),
  ];

  getStatus() async {
    print("TOKENNNNNNNNNN   $tokenVal");
    print("Calleeeeeddd");
    var headers = {'Authorization': 'Bearer $tokenVal'};

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
    super.initState();

    tokenVal = SharedPref.to.prefss!.getString("token");
    getStatus();
    print("AMAR HEDAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
  }

  @override
  Widget build(BuildContext context) {
    if (MyApiClient.completeStatus == null) {
      if (paymentCheck == "0") {
        return Scaffold(
          body: Stack(
            children: [
              _screens[_currentIndex],
              Container(
                height: Get.height,
                width: Get.width,
                color: Color(0x31a0c828),
                child: AlertDialog(
                  title: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          //dialogStatus = false;
                        });
                      },
                      child: Text(""),
                    ),
                  ),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: [
                        Center(
                          child: Text("Your profile",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Get.width / 20)),
                        ),
                        Center(
                          child: Text("is incomplete",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Get.width / 20)),
                        ),
                        Center(
                          child: Text("Please fill up",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Get.width / 20)),
                        ),
                        Center(
                          child: Text("your profile details",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Get.width / 20)),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            print(userMap!["user_info"]["role_name"]);
                            userMap!["user_info"]["role_name"] == "vendor"
                                ? Get.to(VendorProfileStatus1())
                                : Get.to(ContractorPayStatus1());
                          },
                          child: Container(
                            height: Get.height / 15,
                            width: Get.width / 3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.primaryColor),
                            child: Center(
                                child: Text(
                              "Create Profile",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      } else if (paymentCheck == "1") {
        return Scaffold(
          appBar: navAppBar(),
          drawer: NavDrawer(),
          body: Stack(
            children: [
              _screens[_currentIndex],
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            backgroundColor: AppColors.backgroundColor,
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: AppColors.bottomNavColor,
            unselectedFontSize: 12,
            selectedFontSize: 13,
            selectedLabelStyle: TextStyle(
              fontSize: 12.0,
            ),
            //unselectedLabelStyle:
            onTap: (value) {
              // Respond to item press.
              setState(() {
                 _currentIndex = value;
                // _index= value;
              });
            },
            items: [
              BottomNavigationBarItem(
                label: "Home",
                icon: Icon(
                  Icons.home_outlined,
                ),
              ),
              BottomNavigationBarItem(
                label: userMap!["user_info"]["role_name"] == "vendor"
                    ? "Browse Leads"
                    : "Browse Jobs",
                icon: Icon(
                  Icons.book_rounded,
                ),
              ),
              BottomNavigationBarItem(
                label: "Contractors",
                icon: Icon(
                  Icons.person_outline_outlined,
                ),
              ),
              BottomNavigationBarItem(
                label: "       Lead\nMarketPlace",
                icon: Icon(
                  Icons.business_center_outlined,
                ),
              ),
            ],
          ),
        );
      } else {
        return Scaffold(
          body: Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      }
    } else if (MyApiClient.completeStatus == "0") {
      return Scaffold(
        body: Stack(
          children: [
            _screens[_currentIndex],
            Container(
              height: Get.height,
              width: Get.width,
              color: Color(0x7ea0c828),
              child: AlertDialog(
                title: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        //dialogStatus = false;
                      });
                    },
                    child: Text(""),
                  ),
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      Center(
                        child: Text("Your profile is incomplete",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: Get.width / 20)),
                      ),
                      Center(
                        child: Text("Please fill up",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: Get.width / 20)),
                      ),
                      Center(
                        child: Text("your profile details",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: Get.width / 20)),
                      ),
                    ],
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print(userMap!["user_info"]["role_name"]);
                          userMap!["user_info"]["role_name"] == "vendor"
                              ? Get.to(VendorProfileStatus1())
                              : Get.to(ContractorPayStatus1());
                        },
                        child: Container(
                          height: Get.height / 15,
                          width: Get.width / 3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.primaryColor),
                          child: Center(
                              child: Text(
                            "Create Profile",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
    } else if (MyApiClient.completeStatus == "1") {
      return Scaffold(
        appBar: navAppBar(),
        drawer: NavDrawer(),
        body: Stack(
          children: [
            _screens[_currentIndex],
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          backgroundColor: AppColors.backgroundColor,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.bottomNavColor,
          unselectedFontSize: 12,
          selectedFontSize: 13,
          selectedLabelStyle: TextStyle(
            fontSize: 12.0,
          ),
          //unselectedLabelStyle:
          onTap: (value) {
            // Respond to item press.
            setState(() {
               _currentIndex = value;
              // _index= value;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(
                Icons.home_outlined,
              ),
            ),
            BottomNavigationBarItem(
              label: userMap!["user_info"]["role_name"] == "vendor"
                  ? "Browse Leads"
                  : "Browse Jobs",
              icon: Icon(
                Icons.book_rounded,
              ),
            ),
            BottomNavigationBarItem(
              label: "Contractors",
              icon: Icon(
                Icons.person_outline_outlined,
              ),
            ),
            BottomNavigationBarItem(
              label: "       Lead\nMarketPlace",
              icon: Icon(
                Icons.business_center_outlined,
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        body: Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
  }
}
