import 'dart:io';
import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/Repositories/repository.dart';
import 'package:new_fixera/SharedPreferance/shared_preferance.dart';
import 'package:new_fixera/Views/Screens/ChangePassword/Change_Password_Screen.dart';
import 'package:new_fixera/Views/Screens/ContractorProfileSetting/contractor_details_skills_inappwebview.dart';
import 'package:new_fixera/Views/Screens/ContractorProfileSetting/contractor_experience_education_inappwebview.dart';
import 'dart:io' show Platform;
import 'package:new_fixera/Views/Screens/ContractorProfileSetting/contractor_payment_settings_inappwebview.dart';
import 'package:new_fixera/Views/Screens/ContractorProfileSetting/contractor_projects_certification_inappwebview.dart';
import 'package:new_fixera/Views/Screens/Signin/SignInPage.dart';
import 'package:new_fixera/Views/Screens/VendorProfileSetting/vendor_profile_details_inappwebview.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:new_fixera/Views/create_estimation/create_estimation.dart';
import 'package:new_fixera/Views/create_estimation/create_estimation_list.dart';
import 'package:new_fixera/Views/create_invoice/create_invoice_view.dart';
import 'package:new_fixera/Views/send_email/send_email_view.dart';
import 'package:new_fixera/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import '../create_estimation/estimation_list_controller.dart';
import '../create_workorder/create_work_order_view.dart';
import 'NavDrawerTile.dart';
import 'package:expandable/expandable.dart';

class NavDrawer extends StatelessWidget {
  final MyRepository myRepository =
      MyRepository(apiClient: MyApiClient(httpClient: Client()));
  String? firstname;
  String? lastname;

  @override
  Widget build(BuildContext context) {
    firstname = userMap!["user_info"]["first_name"];
    lastname = userMap!["user_info"]["last_name"];

    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.grey[300],
              //height: Get.height * 0.2,
              width: Get.width,
              child: ListTile(
                contentPadding: EdgeInsets.only(top: 25, left: 16),
                leading: userMap!["user_info"]["avatar"] == "0"
                    ? IconButton(
                        iconSize: 45,
                        onPressed: () {},
                        icon: Icon(
                          Icons.account_circle,
                          size: 50,
                        ),
                      )
                    : SizedBox(
                        height: 60,
                        width: 60,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(45),
                            child: Image.network(
                              userMap!["user_info"]["avatar"].toString(),
                              height: 60,
                              width: 60,
                            )),
                      ),
                // title:
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      firstname! + " " + lastname!,
                    ),
                    Text(
                      userMap!["user_info"]["role_name"] == "vendor"
                          ? "Lead MarketPlace"
                          : 'Contractor',
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.FULLPROFILEPAGE,
                            arguments: userMap!["user_info"]["id"]);
                      },
                      child: Text(
                        "Profile",
                        style: TextStyle(color: Colors.blue[900]),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //this is for contractor navigation Drawer
            userMap!["user_info"]["role_name"] == "contractor"
                ? Container(
                    child: Column(
                      children: [
                        NavDrawerTile(
                          navIcon: Icons.dashboard,
                          navTitle: 'DashBoard',
                          onNavPress: () {
                            Get.toNamed(AppRoutes.DASHBOARD);
                          },
                        ),
                        NavDrawerTile(
                          navIcon: Icons.message,
                          navTitle: 'Message Center',
                          onNavPress: () {
                            Get.toNamed(AppRoutes.MESSAGECENTER);
                          },
                        ),
                        //   NavDrawerTile(
                        //   navIcon: Icons.message,
                        //   navTitle: 'Check file',
                        //   onNavPress: () {
                        //     Get.toNamed(AppRoutes.CHECKFILE);
                        //   },

                        // ),

                        NavDrawerTile(
                          navIcon: Icons.post_add,
                          navTitle: 'Post a Project',
                          onNavPress: () {
                            Get.toNamed(AppRoutes.NAVPOSTAJOBANDLEAD);
                          },
                        ),
                        NavDrawerTile(
                          navIcon: Icons.loyalty,
                          navTitle: 'Projects',
                          onNavPress: () {
                            Get.toNamed(AppRoutes.PROJECTS);
                          },
                        ),
                        NavDrawerTile(
                          navIcon: Icons.person_pin_outlined,
                          navTitle: 'Proposals',
                          onNavPress: () {
                            Get.toNamed(AppRoutes.NAVPROPOSALS);
                          },
                        ),

                        NavDrawerTile(
                          navIcon: Icons.wallet_giftcard_sharp,
                          navTitle: 'Wallet',
                          onNavPress: () {
                            Get.toNamed(AppRoutes.WALLET);
                          },
                        ),
                        NavDrawerTile(
                          navIcon: Icons.payments_outlined,
                          navTitle: 'Invoices',
                          onNavPress: () {
                            Get.toNamed(AppRoutes.INVOICEPAGE);
                          },
                        ),
                        NavDrawerTile(
                          navIcon: Icons.payments_outlined,
                          navTitle: 'Create Estimation',
                          onNavPress: () {
                            //Get.put(CreateEstimationListController());
                            Get.to(() => CreateEstimationList());
                          },
                        ),
                        NavDrawerTile(
                          navIcon: Icons.payments_outlined,
                          navTitle: 'Create Work order',
                          onNavPress: () {
                            Get.to(() => CreateWorkOrderView());
                          },
                        ),
                        NavDrawerTile(
                          navIcon: Icons.payments_outlined,
                          navTitle: 'Create Invoice',
                          onNavPress: () {
                            Get.to(() => CreateInvoiceView());
                          },
                        ),
                        // NavDrawerTile(
                        //   navIcon: Icons.grain,
                        //   navTitle: 'In App purchase',
                        //   onNavPress: () {
                        //     Route route =
                        //     MaterialPageRoute(builder: (c) => MyPayApp());
                        //     Navigator.pushReplacement(context, route);
                        //   },
                        // ),
                        NavDrawerTile(
                          navIcon: Icons.credit_card,
                          navTitle: 'Buy Credit',
                          onNavPress: () {
                            Get.toNamed(AppRoutes.BUYCREDITPAGE);
                          },
                        ),
                        NavDrawerTile(
                          navIcon: Icons.grain,
                          navTitle: 'Packages',
                          onNavPress: () {
                            Get.toNamed(AppRoutes.PACKAGES);
                          },
                        ),

                        NavDrawerTile(
                          navIcon: Icons.favorite,
                          navTitle: 'My Saved Items',
                          onNavPress: () {
                            Get.toNamed(AppRoutes.FAVOURITE);
                          },
                        ),
                        NavDrawerTile(
                          navIcon: Icons.how_to_reg,
                          navTitle: 'How it Works',
                          onNavPress: () {
                            Get.toNamed(AppRoutes.HOWITWORKS);
                          },
                        ),
                        NavDrawerTile(
                          navIcon: Icons.privacy_tip,
                          navTitle: 'Privacy Policy',
                          onNavPress: () {
                            Get.toNamed(AppRoutes.PRIVACYPOLICY);
                          },
                        ),
                        // NavDrawerTile(
                        //   navIcon: Icons.settings,
                        //   navTitle: 'Settings',
                        //   onNavPress: () {
                        //     Get.toNamed(AppRoutes.SETTINGSWEB);
                        //   },
                        // ),

                        /* NavDrawerTile(
                          navIcon: Icons.settings,
                          navTitle: 'Profile Setting',
                          onNavPress: () {
                            print("Profile Setting");
                            Get.toNamed(AppRoutes.PROFILE_SETTINGS);
                          },
                        ),*/

                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: ExpandablePanel(
                            collapsed:
                            const SizedBox(
                              height: 10,
                            ),
                            header: NavDrawerTile(
                              navIcon: Icons.settings,
                              navTitle: 'Profile Setting',
                            ),
                            expanded: Padding(
                              padding: const EdgeInsets.only(left: 100),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Route route = MaterialPageRoute(
                                          builder: (c) =>
                                              ContractorDetailsSkillsDemo());
                                      Navigator.pushReplacement(context, route);

                                      // Route route = MaterialPageRoute(
                                      //     builder: (c) =>
                                      //         ContractorPersonalDetailSCreen());
                                      // Navigator.pushReplacement(context, route);
                                    },
                                    child: Text(
                                      "Personal Details & Skills",
                                      softWrap: true,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Route route = MaterialPageRoute(
                                          builder: (c) =>
                                              ContractorExperienceEduInappwebview());
                                      Navigator.pushReplacement(context, route);
                                    },
                                    child: Text(
                                      "Experience & Education",
                                      softWrap: true,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Route route = MaterialPageRoute(
                                          builder: (c) =>
                                              ContractorProjectsCertificationInappWebView());
                                      Navigator.pushReplacement(context, route);

                                      // Route route = MaterialPageRoute(
                                      //     builder: (c) =>
                                      //         ContractorProjectAndCertificateScreen());
                                      // Navigator.pushReplacement(context, route);
                                    },
                                    child: Text(
                                      "Projects & Certifications",
                                      softWrap: true,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Route route = MaterialPageRoute(
                                          builder: (c) =>
                                              ContractorPaymentInappwebview());
                                      Navigator.pushReplacement(context, route);
                                    },
                                    child: Text(
                                      "Payment Settings",
                                      softWrap: true,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => SendEmailView());
                                    },
                                    child: Text(
                                      "Email Send",
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: ExpandablePanel(
                            collapsed:
                            const SizedBox(
                              height: 10,
                            ),
                            header: NavDrawerTile(
                              navIcon: Icons.settings,
                              navTitle: 'Account Setting',
                              onNavPress: () {
                                // Get.toNamed(AppRoutes.ACCOUNT_SETTINGS);
                              },
                            ),
                            expanded: Padding(
                              padding: const EdgeInsets.only(left: 100),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () =>
                                        Get.toNamed(AppRoutes.MANAGE_ACCOUNT),
                                    child: Text(
                                      "Manage Account",
                                      softWrap: true,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () =>
                                        Get.toNamed(AppRoutes.EMAIL_ACCOUNT),
                                    child: Text(
                                      "Email Notification ",
                                      softWrap: true,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () => Get.toNamed(
                                        AppRoutes.DEACTIVATE_ACCOUNT),
                                    child: Text(
                                      "De-active Account ",
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // NavDrawerTile(
                        //   navIcon: Icons.lock,
                        //   navTitle: 'Test',
                        //   onNavPress: () {
                        //     Route route = MaterialPageRoute(
                        //         builder: (c) => TestMyApp());
                        //     Navigator.pushReplacement(context, route);
                        //   },
                        // ),
                        NavDrawerTile(
                          navIcon: Icons.lock,
                          navTitle: 'Change Password',
                          onNavPress: () {
                            Route route = MaterialPageRoute(
                                builder: (c) => ChangePasswordScreen());
                            Navigator.pushReplacement(context, route);
                          },
                        ),

                        NavDrawerTile(
                          navIcon: Icons.logout,
                          navTitle: 'Logout',
                          onNavPress: () async {
                            try {
                              Get.defaultDialog(
                                  title: "Logout",
                                  middleText:
                                      "Are you sure, You want to Logout?",
                                  onConfirm: () async {
                                    await myRepository.postLogOut();
                                    if (logOutCheck == false) {
                                      prefs?.clear();
                                      SharedPref.to.prefss!.remove("loggedin");
                                      print(SharedPref.to.prefss!
                                              .getBool("loggedin")
                                              .toString() +
                                          "****************Before Logout*********************");

                                      // final dir = Directory(
                                      //     "/storage/emulated/0/Android/data/com.fixera.app/files/Fixera");
                                      // dir.deleteSync(recursive: true);
                                      if (Platform.isAndroid) {
                                        //SystemNavigator.pop();
                                        SharedPref.to.prefss!.remove("loggedin");
                                        bool afterLogoutState = false;
                                        SharedPref.to.prefss!.setBool(
                                            "loggedin", afterLogoutState);
                                        print(SharedPref.to.prefss!
                                                .getBool("loggedin")
                                                .toString() +
                                            "*********After Logout*********************");
                                        Route route = MaterialPageRoute(
                                            builder: (c) => SignInPage());
                                        Navigator.pushReplacement(
                                            context, route);
                                        //Get.offAll(SignInPage());
                                      } else if (Platform.isIOS) {
                                        SharedPref.to.prefss!.remove("loggedin");
                                        bool afterLogoutState = false;
                                        SharedPref.to.prefss!.setBool(
                                            "loggedin", afterLogoutState);
                                        print(SharedPref.to.prefss!
                                                .getBool("loggedin")
                                                .toString() +
                                            "*********After Logout*********************");
                                        Route route = MaterialPageRoute(
                                            builder: (c) => SignInPage());
                                        Navigator.pushReplacement(
                                            context, route);
                                      }

                                      //Get.offAllNamed(AppRoutes.SIGNINPAGE);
                                    } else if (logOutCheck == true) {
                                      Get.defaultDialog(
                                          title: "Alert",
                                          middleText: "Token is Expired");
                                      loginStatus = false;
                                      prefs!.setBool("loginStatus", loginStatus);
                                      Route route = MaterialPageRoute(
                                          builder: (c) => SignInPage());
                                      Navigator.pushReplacement(context, route);
                                    }
                                  },
                                  onCancel: () {
                                    Get.back();
                                  });
                            } catch (e) {}
                          },
                        ),
                      ],
                    ),
                  )
                :

                //this is for Vendor navigation  Drawer
                Container(
                    child: Column(
                      children: [
                        NavDrawerTile(
                          navIcon: Icons.dashboard,
                          navTitle: 'DashBoard',
                          onNavPress: () {
                            Get.toNamed(AppRoutes.DASHBOARD);
                          },
                        ),
                        NavDrawerTile(
                          navIcon: Icons.message,
                          navTitle: 'Message Center',
                          onNavPress: () {
                            Get.toNamed(AppRoutes.MESSAGECENTER);
                          },
                        ),
                        NavDrawerTile(
                          navIcon: Icons.post_add,
                          navTitle: 'Post a Lead',
                          onNavPress: () {
                            Get.toNamed(AppRoutes.NAVPOSTAJOBANDLEAD);
                          },
                        ),
                        NavDrawerTile(
                          navIcon: Icons.loyalty,
                          navTitle: 'Leads',
                          onNavPress: () {
                            Get.toNamed(AppRoutes.PROJECTS);
                          },
                        ),
                        NavDrawerTile(
                          navIcon: Icons.wallet_giftcard_sharp,
                          navTitle: 'Transfer History',
                          onNavPress: () {
                            Get.toNamed(AppRoutes.TRANSFERHISTORY);
                          },
                        ),
                        NavDrawerTile(
                          navIcon: Icons.payments_outlined,
                          navTitle: 'Invoices',
                          onNavPress: () {
                            Get.toNamed(AppRoutes.INVOICEPAGE);
                          },
                        ),
                        NavDrawerTile(
                          navIcon: Icons.grain,
                          navTitle: 'Packages',
                          onNavPress: () {
                            // Get.toNamed(AppRoutes.INAPPPURCHASE);
                            Get.toNamed(AppRoutes.PACKAGES);
                          },
                        ),
                        // NavDrawerTile(
                        //   navIcon: Icons.grain,
                        //   navTitle: 'In App purchase',
                        //   onNavPress: () {
                        //     Route route =
                        //     MaterialPageRoute(builder: (c) => InAppPurchasePage());
                        //     Navigator.pushReplacement(context, route);
                        //   },
                        // ),

                        NavDrawerTile(
                          navIcon: Icons.favorite,
                          navTitle: 'My Saved Items',
                          onNavPress: () {
                            Get.toNamed(AppRoutes.FAVOURITE);
                          },
                        ),
                        NavDrawerTile(
                          navIcon: Icons.how_to_reg,
                          navTitle: 'How it Works',
                          onNavPress: () {
                            Get.toNamed(AppRoutes.HOWITWORKS);
                          },
                        ),
                        NavDrawerTile(
                          navIcon: Icons.privacy_tip,
                          navTitle: 'Privacy Policy',
                          onNavPress: () {
                            Get.toNamed(AppRoutes.PRIVACYPOLICY);
                          },
                        ),
                        // NavDrawerTile(
                        //   navIcon: Icons.settings,
                        //   navTitle: 'Settings',
                        //   onNavPress: () {
                        //     Get.toNamed(AppRoutes.SETTINGSWEB);
                        //   },
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: ExpandablePanel(
                            collapsed:
                            const SizedBox(
                              height: 10,
                            ),
                            header: NavDrawerTile(
                              navIcon: Icons.settings,
                              navTitle: 'Profile Setting',
                              onNavPress: () {
                                // Get.toNamed(AppRoutes.ACCOUNT_SETTINGS);
                              },
                            ),
                            expanded: Padding(
                              padding: const EdgeInsets.only(left: 100),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Route route = MaterialPageRoute(
                                          builder: (c) =>
                                              VendorProfileDetailInappwebview());
                                      Navigator.pushReplacement(context, route);
                                    },
                                    child: Text(
                                      "Profile Details",
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: ExpandablePanel(
                            collapsed:
                            const SizedBox(
                              height: 10,
                            ),
                            header: NavDrawerTile(
                              navIcon: Icons.settings,
                              navTitle: 'Account Setting',
                              onNavPress: () {
                                // Get.toNamed(AppRoutes.ACCOUNT_SETTINGS);
                              },
                            ),
                            expanded: Padding(
                              padding: const EdgeInsets.only(left: 100),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () =>
                                        Get.toNamed(AppRoutes.MANAGE_ACCOUNT),
                                    child: Text(
                                      "Manage Account",
                                      softWrap: true,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () =>
                                        Get.toNamed(AppRoutes.EMAIL_ACCOUNT),
                                    child: Text(
                                      "Email Notification ",
                                      softWrap: true,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () => Get.toNamed(
                                        AppRoutes.DEACTIVATE_ACCOUNT),
                                    child: Text(
                                      "De-active Account ",
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        NavDrawerTile(
                          navIcon: Icons.lock,
                          navTitle: 'Change Password',
                          onNavPress: () {
                            Route route = MaterialPageRoute(
                                builder: (c) => ChangePasswordScreen());
                            Navigator.pushReplacement(context, route);
                          },
                        ),
                        NavDrawerTile(
                          navIcon: Icons.logout,
                          navTitle: 'Logout',
                          onNavPress: () async {
                            try {
                              Get.defaultDialog(
                                  title: "Logout",
                                  middleText:
                                      "Are you sure, You want to Logout?",
                                  onConfirm: () async {
                                    await myRepository.postLogOut();
                                    if (logOutCheck == false) {
                                      prefs?.clear();
                                      SharedPref.to.prefss!.remove("loggedin");
                                      print(SharedPref.to.prefss!
                                              .getBool("loggedin")
                                              .toString() +
                                          "****************Before Logout*********************");

                                      // final dir = Directory(
                                      //     "/storage/emulated/0/Android/data/com.fixera.app/files/Fixera");
                                      // dir.deleteSync(recursive: true);
                                      if (Platform.isAndroid) {
                                        //SystemNavigator.pop();
                                        SharedPref.to.prefss!.remove("loggedin");
                                        bool afterLogoutState = false;
                                        SharedPref.to.prefss!.setBool(
                                            "loggedin", afterLogoutState);
                                        print(SharedPref.to.prefss!
                                                .getBool("loggedin")
                                                .toString() +
                                            "*********After Logout*********************");
                                        Route route = MaterialPageRoute(
                                            builder: (c) => SignInPage());
                                        Navigator.pushReplacement(
                                            context, route);
                                      } else if (Platform.isIOS) {
                                        SharedPref.to.prefss!.remove("loggedin");
                                        bool afterLogoutState = false;
                                        SharedPref.to.prefss!.setBool(
                                            "loggedin", afterLogoutState);
                                        print(SharedPref.to.prefss!
                                                .getBool("loggedin")
                                                .toString() +
                                            "*********After Logout*********************");
                                        Route route = MaterialPageRoute(
                                            builder: (c) => SignInPage());
                                        Navigator.pushReplacement(
                                            context, route);
                                      }

                                      //Get.offAllNamed(AppRoutes.SIGNINPAGE);
                                    } else if (logOutCheck == true) {
                                      Get.defaultDialog(
                                          title: "Alert",
                                          middleText: "Token is Expired");
                                      loginStatus = false;
                                      prefs!.setBool("loginStatus", loginStatus);
                                      Route route = MaterialPageRoute(
                                          builder: (c) => SignInPage());
                                      Navigator.pushReplacement(context, route);
                                    }
                                  },
                                  onCancel: () {
                                    Get.back();
                                  });
                            } catch (e) {}
                          },
                          // onNavPress: () async {
                          //
                          //   // try {
                          //   //   Get.defaultDialog(
                          //   //       title: "Logout",
                          //   //       middleText:
                          //   //           "Are you sure, You want to Logout?",
                          //   //       onConfirm: () async {
                          //   //         await myRepository.postLogOut();
                          //   //         if (logOutCheck == false) {
                          //   //           prefs?.clear();
                          //   //           SharedPref.to.prefss.remove("loggedin");
                          //   //           print(SharedPref.to.prefss
                          //   //                   .getBool("loggedin")
                          //   //                   .toString() +
                          //   //               "****************Before Logout*********************");
                          //   //
                          //   //           final dir = Directory(
                          //   //               "/storage/emulated/0/Android/data/com.fixera.app/files/Fixera");
                          //   //           dir.deleteSync(recursive: true);
                          //   //           if (Platform.isAndroid) {
                          //   //             //SystemNavigator.pop();
                          //   //             SharedPref.to.prefss
                          //   //                 .remove("token_type");
                          //   //             SharedPref.to.prefss.remove("token");
                          //   //             // prefs.remove("loginStatus");
                          //   //             bool afterLogoutState = false;
                          //   //             SharedPref.to.prefss.setBool(
                          //   //                 "loggedin", afterLogoutState);
                          //   //             print(SharedPref.to.prefss
                          //   //                     .getBool("loggedin")
                          //   //                     .toString() +
                          //   //                 "*********After Logout*********************");
                          //   //             Route route = MaterialPageRoute(
                          //   //                 builder: (c) => SignInPage());
                          //   //             Navigator.pushReplacement(
                          //   //                 context, route);
                          //   //           } else if (Platform.isIOS) {
                          //   //             exit(0);
                          //   //           }
                          //   //
                          //   //           //Get.offAllNamed(AppRoutes.SIGNINPAGE);
                          //   //         } else if (logOutCheck == true) {
                          //   //           Get.defaultDialog(
                          //   //               title: "Alert",
                          //   //               middleText: "Token is Expired");
                          //   //           loginStatus = false;
                          //   //           prefs.setBool("loginStatus", loginStatus);
                          //   //           Navigator.of(context).pushAndRemoveUntil(
                          //   //               MaterialPageRoute(
                          //   //                   builder: (context) =>
                          //   //                       SignInPage()),
                          //   //               (Route<dynamic> route) => false);
                          //   //         }
                          //   //       },
                          //   //       onCancel: () {
                          //   //         Get.back();
                          //   //       });
                          //   // } catch (e) {}
                          // },
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
