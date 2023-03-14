import 'dart:convert';
import 'dart:developer';

import 'package:new_fixera/Model/ContractorModel/ContractorDetailsModel.dart';
import 'package:new_fixera/Model/ContractorModel/ContractorPageModel.dart';
import 'package:new_fixera/Model/ContractorModel/ContractorSearchModel.dart';
import 'package:new_fixera/Model/FavouriteModel/FavouriteGetModel.dart';
import 'package:new_fixera/Model/ForgotModel/ForgotEmailModel.dart';
import 'package:new_fixera/Model/ForgotModel/ForgotResetPasswordModel.dart';
import 'package:new_fixera/Model/HomePageModel/HomeModel.dart';
import 'package:new_fixera/Model/JobModel/JobDialogModel.dart';
import 'package:new_fixera/Model/JobModel/JobPageModel.dart';
import 'package:new_fixera/Model/JobModel/JobPrivatePubLicModel.dart';
import 'package:new_fixera/Model/JobModel/jobSearchModel.dart';
import 'package:new_fixera/Model/LoginModel/LoginModel.dart';
import 'package:new_fixera/Model/LogoutModel/LogoutModel.dart';
import 'package:new_fixera/Model/MarketPageModel/FullProfileModel.dart';
import 'package:new_fixera/Model/MarketPageModel/OpenJobsModel.dart';
import 'package:new_fixera/Model/MarketPageModel/VendorPageModel.dart';
import 'package:new_fixera/Model/MarketPageModel/vendorSearchModel.dart';
import 'package:new_fixera/Model/PostAJobAndLeadModel/PostAjobAndLead.dart';
import 'package:new_fixera/Model/SignUpModel/ProfessionalInfoModel.dart';
import 'package:new_fixera/Model/SignUpModel/SignUpModel.dart';
import 'package:new_fixera/SharedPreferance/shared_pref_new.dart';
import 'package:new_fixera/SharedPreferance/shared_preferance.dart';
import 'package:new_fixera/Views/Screens/ExportScreens.dart';
import 'package:new_fixera/firebase_functions/firebase_functions.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' as G;
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:new_fixera/main.dart';
import 'package:new_fixera/Model/PostAJobAndLeadModel/PostAJob.dart';
import 'package:new_fixera/Model/PostAJobAndLeadModel/PostALead.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

bool? loginCheck;
bool? logOutCheck;
bool? errorStatus;

String? privatePublicResponse;

class MyApiClient {
  static var completeStatus;

  final http.Client? httpClient;

  MyApiClient({@required this.httpClient});

  //this is for header for Token checking in logout Api
  static header() => {
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': '$tokenType $token'
      };

  //this is for header for Token checking in all get api
  static header2() => {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': '$tokenType $token',
        'Accept': 'application/json',
      };

//{userMap["token_type"]}
//SignUpGet data Api
  getSignUpData() async {
    try {
      var response = await httpClient!.get(AppUrl.signUpGetUrl);
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("Done  SignUpGetData");
        String jsonResponseString = response.body;
        print(response.body);
        return signUpModelFromJson(jsonResponseString);
      } else if (response.statusCode == 401) {
        prefs!.setBool("loginStatus", false);
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("signUpgetData ::: ${e.toString()}");
    }
  }

//HomePage Api Calling
  getHome() async {
    try {
      var response =
          await httpClient!.get(AppUrl.homePageUrl, headers: header2());
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("Done HomePage");
        String jsonResponseString = response.body;
        return homeModelFromJson(jsonResponseString);
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("HomePage ::: ${e.toString()}");
    }
  }

//JobPage Api Calling
  getJobs(var page) async {
    try {
      var response = await httpClient!.get(AppUrl.jobPageUrl + "&page=$page",
          headers: header2());
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("Done JobPage");
        String jsonResponseString = response.body;
        return jobPageModelFromJson(jsonResponseString);
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("jobPage :::: ${e.toString()}");
    }
  }

  //VendorPage which is now MarketPlace , Api is  Calling here
  getMarketPlace(var page) async {
    try {
      var response = await httpClient!.get(AppUrl.vendorPageUrl + "&page=$page",
          headers: header2());
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("Done vendorPage");
        String jsonResponseString = response.body;
        return vendorPageModelFromJson(jsonResponseString);
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("vendor ${e.toString()}");
    }
  }

//ContractorPage Api Calling
  getContractor(var page) async {
    print("contractor Page no");
    print(page);
    try {
      var response = await httpClient!
          .get(AppUrl.contractorPageUrl + "&page=$page", headers: header2());
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      if (response.statusCode == 200) {
        print(AppUrl.contractorPageUrl + "&page=$page");
        print("Done contractorPage  ${response.body}");

        String jsonResponseString = response.body;
        return contractorPageModelFromJson(jsonResponseString);
      } else {
        print(AppUrl.contractorPageUrl + "&page=$page");
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("getContractor ${e.toString()}");
    }
  }

//list the favourite in favourite page which is in nav drawer
  getFavourite() async {
    try {
      var response =
          await httpClient!.get(AppUrl.favouritGetUrl, headers: header2());
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("Done favouriteList");
        String jsonResponseString = response.body;
        print(jsonResponseString);
        return favouriteGetModelFromJson(jsonResponseString);
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("favouriteList ${e.toString()}");
    }
  }

//this is for search in vendor
  getVendorSearch(String vendorSearchUrl) async {
    print("apiProvider");
    print(vendorSearchUrl);
    try {
      var response = await httpClient!.get(vendorSearchUrl, headers: header2());
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("Done vendorSearchList");
        String jsonResponseString = response.body;
        print(jsonResponseString);
        return vendorSearchModelFromJson(jsonResponseString);
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("vendorSearchList ${e.toString()}");
    }
  }

//this is for Contractor Search where url are come from SearchPage Contractor portion
  getContractorSearch(String contractorSearchUrl) async {
    print("apiProvider");
    print(contractorSearchUrl);
    try {
      var response =
          await httpClient!.get(contractorSearchUrl, headers: header2());
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("Done contractorSearchList");
        String jsonResponseString = response.body;
        print(jsonResponseString);
        return contractorSearchModelFromJson(jsonResponseString);
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("contractorSearchList ${e.toString()}");
    }
  }

//this is for Job Search where url are come from SearchPage Browse Project portion
  getJobSearch(
    String jobSearchUrl,
  ) async {
    print("apiProvider");
    print(jobSearchUrl);
    try {
      var response = await httpClient!.get(jobSearchUrl, headers: header2());
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("Done jobSearchList");
        String jsonResponseString = response.body;
        print(jsonResponseString);
        return jobSearchModelFromJson(jsonResponseString);
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("jobSearchList ${e.toString()}");
    }
  }

//this is for Post a Job for Contractor where id 3 for Contractor
  getPostAJobData() async {
    print("apiProvider");
    try {
      var response = await httpClient!.get(AppUrl.getPostaJobUrl + "?role_id=3",
          headers: header2());
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("Done PostAJob");
        String jsonResponseString = response.body;
        print(jsonResponseString);
        return postAJobModelFromJson(jsonResponseString);
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("post A Job " + e.toString());
    }
  }

//this is for Post a Job for Contractor where id 2 for vendor
  getPostALeadData() async {
    print("apiProvider");
    try {
      var response = await httpClient!.get(AppUrl.getPostaJobUrl + "?role_id=2",
          headers: header2());
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("Done PostALead");
        String jsonResponseString = response.body;
        print(jsonResponseString);
        return postALeadFromJson(jsonResponseString);
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("post A Lead " + e.toString());
    }
  }

//this is for postAjobApi where arribute are come form PostAjobAndLead page where multiple  file is also sent using Dio packages
  Future<Object> postAjob(
      {String? postAjobAndLeadUrl,
      List<File>? fileList,
      required Map<String, String>? body}) async {
    var code;
    try {
      Dio dio = Dio();
      var formData = FormData();
      for (var file in fileList!) {
        formData.files.addAll([
          MapEntry("attachments[]", await MultipartFile.fromFile(file.path)),
        ]);
      }
      formData.fields.addAll(body!.entries!);
      print("Post Job Body ${postAjobAndLeadUrl}");
      print("Post Header ${header2()}");

      var response = await dio.post(postAjobAndLeadUrl,
          data: formData, options: Options(headers: header2()));
      print("++++++++++++");
      print(response);

      print(response.statusCode);
      code = response;
      return response;
    } catch (e) {
      Fluttertoast.showToast(
          msg: code,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 14.0);
      print(SharedPref.to.prefss!.getString("token"));
      print("+++++++++++***********+++++++++");
      print("postAjob ${e.toString()}");
      var a = "";
      return a;
    }
  }

//this is for contractorDetails APi where id is sent to the server
  Future<ContractorDetailsModel?> postContractorDetailsJob(var id) async {
    var code;

    try {
      var response = await httpClient!.post(
          "${AppUrl.contractorDetailsUrl}?user_id=$id",
          headers: header2());

      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      String responseString;
      if (response.statusCode == 200) {
        print("${AppUrl.contractorDetailsUrl}?user_id=$id");
        responseString = response.body;
        print("ContractorDetailsResponse Done");
        print(responseString);
        return contractorDetailsModelFromJson(responseString);
      } else if (response.statusCode == 401) {
        print("${AppUrl.contractorDetailsUrl}?user_id=$id");
        responseString = response.body;
        print(responseString);
        return contractorDetailsModelFromJson(responseString);
      } else {
        responseString = response.body;
        print("${AppUrl.contractorDetailsUrl}?user_id=$id");
        print("ContractorDetailsResponse Done");
        print(responseString);
        return contractorDetailsModelFromJson(responseString);
      }
    } catch (e) {
      print("contractorDetails ${e.toString()}");
    }
    return null;
  }

//this is for openJobs APi where id is sent to the server
  Future<OpenJobsModel?> postOpenJobs(var id) async {
    try {
      final response = await httpClient!
          .post("${AppUrl.openJobsUrl}?user_id=$id", headers: header2());
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      String responseString;
      if (response.statusCode == 200) {
        responseString = response.body;
        print("openJobsResponse");
        print(responseString);
        return openJobsModelFromJson(responseString);
      } else if (response.statusCode == 401) {
        responseString = response.body;
        print(responseString);
        return null;
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("OpenJobs ${e.toString()}");
    }
    return null;
  }

//this is for job is public or Private Which is come from all the jobs button for Contractor Role
  Future<JobPrivatePublicModel?> postPublicPrivateJob(
      String slug, var id, String status) async {
    try {
      final response = await httpClient!.post(
          "${AppUrl.privatePublicJobsUrl}?job_slug=$slug&job_id=$id&status=$status",
          headers: header2());
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      String responseString;
      if (response.statusCode == 200) {
        print("AAAAAAAAAAAAAA");
        responseString = response.body;
        print("publicPrivateJobPost Done");
        print(responseString);

        print(jsonDecode((response.body))['message']);
        print(jsonDecode((response.body))['error']);

        privatePublicResponse = jsonDecode((response.body))['message'];
        errorStatus = jsonDecode((response.body))['error'];
        return jobPrivatePublicModelFromJson(responseString);
      } else if (response.statusCode == 401) {
        print("BBBBBBBBBBBBB");
        responseString = response.body;
        print(responseString);
        return null;
      } else {
        print("CCCCCCCCCCCCC");
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("postPublicPrivateJob ${e.toString()}");
    }
    return null;
  }

//this is for fullProfile APi where id is sent to the server
  Future<FullProfileModel?> postFullProfile(var id) async {
    try {
      final response = await httpClient!
          .post("${AppUrl.fullProfileUrl}?user_id=$id", headers: header2());
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      String responseString;
      if (response.statusCode == 200) {
        responseString = response.body;
        print("FullProfileResponse");
        print(responseString);
        return fullProfileModelFromJson(responseString);
      } else if (response.statusCode == 401) {
        responseString = response.body;
        print(responseString);
        return null;
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("postFullProfile ${e.toString()}");
    }
    return null;
  }

  Future<LoginModel?> postLoginData(String email, String password) async {
    print("working1");
    Map<String, dynamic> value;
    try {
      print("working2");
      dynamic firebasetoken = await FirebaseFunctions.getToken();
      final response = await httpClient!.post(
          "${AppUrl.loginUrl}?email=$email&password=$password&device_id=$firebasetoken",
          headers: header2());

      print("This is StatusCode in APIPROVIDER:: ${response.body}");

      String responseString;
      print("working3");
      print("${AppUrl.loginUrl}?email=$email&password=$password");

      print(
          "aaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccddddddddddddddd");

      if (response.statusCode == 200) {
        print(
            "aaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccddddddddddddddd");
        print("1");
        print("${AppUrl.loginUrl}?email=$email&password=$password");
        print("working4");
        value = json.decode(response.body);
        print("VALUE_VALUE_BRO_$value");
        String saveTokenString = response.body;
        SharedPref.to.prefss = await SharedPreferences.getInstance();
        final key = "Login_Token";
        String myValue = saveTokenString;
        SharedPref.to.prefss!.setString(key, myValue);
        Map mapsss = jsonDecode(saveTokenString);
        print(mapsss);
        final tokenValue = mapsss["access_token"];
        final tokenType = mapsss["token_type"];

        //SharedPreffNew.to.prefssNew.setString("token", tokenValue);

        SharedPref.to.prefss!.setString("token", tokenValue);
        SharedPref.to.prefss!.setString("token_type", tokenType);
        print("TOKEN___KI__THIKKKASSS___${mapsss["access_token"]}");
        print("working5");
        responseString = response.body;
        print("working6");
        prefs!.setString("userInfo", responseString);
        user = prefs!.getString("userInfo");
        userMap = jsonDecode(user!);



        print("working7");
        print("LOGIN___BROOOO____RESPONSE___${response.body}");
        print("working8");
        SharedPref.myToken = SharedPref.to.prefss!.getString("token");
        print("SHAREPREF___THEKE___GET____TOKEN___${SharedPref.myToken}");
        if (responseString.contains("false")) {
          print("${AppUrl.loginUrl}?email=$email&password=$password");
          loginCheck = false;
          print("LOGIN___BROOOO____Token___ ${userMap!["access_token"]}");
          print("LOGIN___BROOOO____RESPONSE___${response.body}");
        } else {
          print("${AppUrl.loginUrl}?email=$email&password=$password");
          print("Error in PostData for SharedPreferences");
        }

        print("COMPLETE STATUS: ");
        print("COMPLETE STATUS: " +
            "${userMap!["user_info"]["profile_completion_status"]}");

        completeStatus = "${userMap!["user_info"]["profile_completion_status"]}";

        print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
        print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
        print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
        print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
        print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");

        return loginModelFromJson(responseString);
      } else if (response.statusCode == 401) {
        print("2");
        responseString = response.body;
        if (responseString.contains("true")) {
          print("3");
          print("${AppUrl.loginUrl}?email=$email&password=$password");
          loginCheck = true;
        } else {
          print("4");
          print("${AppUrl.loginUrl}?email=$email&password=$password");
          print(response.statusCode);
          print("LOGIN___BROOOO____RESPONSE___${response.body}");
        }
        return null;
      }
    } catch (e) {
      print("5");
      print("${AppUrl.loginUrl}?email=$email&password=$password");
      print("Login ${e.toString()}");
      rethrow;
    }
  }

  //this is for SignIn APi where email and Password are come from SignIn Page
  // Future<LoginModel> postLoginData(String email, String password) async {
  //   print("working1");
  //   Map<String, dynamic> value;
  //   try {
  //     print("working2");
  //     final response = await httpClient!
  //         .post("${AppUrl.loginUrl}?email=$email&password=$password");
  //     print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
  //     String responseString;
  //     print("working3");
  //     if (response.statusCode == 200) {
  //       print("working4");
  //       value = json.decode(response.body);
  //       print("VALUE_VALUE_BRO_$value");
  //       String saveTokenString = response.body;
  //       SharedPref.to.prefss = await SharedPreferences.getInstance();
  //       final key = "Login_Token";
  //       String myValue = saveTokenString;
  //       SharedPref.to.prefss.setString(key, myValue);
  //       Map mapsss = jsonDecode(saveTokenString);
  //       print("Mapsss");
  //       print(mapsss);
  //       final tokenValue = mapsss["access_token"];
  //       final tokenType = mapsss["token_type"];
  //       SharedPref.to.prefss.setString("token", tokenValue);
  //       SharedPref.to.prefss.setString("token_type", tokenType);
  //
  //       responseString = response.body;
  //
  //       prefs.setString("userInfo", responseString);
  //       user = prefs.getString("userInfo");
  //       userMap = jsonDecode(user);
  //
  //       SharedPref.myToken = SharedPref.to.prefss.getString("token");
  //
  //       if (responseString.contains("false")) {
  //         loginCheck = false;
  //         print("LOGIN___BROOOO____Token___ ${userMap["access_token"]}");
  //         print("LOGIN___BROOOO____RESPONSE___${response.body}");
  //       } else {
  //         print("Error in PostData for SharedPreferences");
  //       }
  //       return loginModelFromJson(responseString);
  //     } else if (response.statusCode == 401) {
  //       responseString = response.body;
  //       if (responseString.contains("true")) {
  //         loginCheck = true;
  //       } else {
  //         print(response.statusCode);
  //         print("LOGIN___BROOOO____RESPONSE___${response.body}");
  //       }
  //       return null;
  //     }
  //   } catch (e) {
  //     print("Login ${e.toString()}");
  //   }
  //   return null;
  // }

  //Logout Api where Header declare are Above
  Future<LogoutModel?> postLogOut() async {
    try {
      final response =
          await httpClient!.post(AppUrl.logOutUrl, headers: header());
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      String responseString;
      if (response.statusCode == 200) {
        responseString = response.body;
        if (responseString.contains("false")) {
          print("logout Sucessfully");
          userMap!["error"] = true;
          print(userMap);
          logOutCheck = false;
        } else {
          print(response.statusCode);
          print(response.body);
        }
        return logoutModelFromJson(responseString);
      } else if (response.statusCode == 401) {
        responseString = response.body;
        if (responseString.contains("true")) {
          print("Token is Expired");
          logOutCheck = true;
        } else {
          print(response.statusCode);
          print(response.body);
        }

        return null;
      }
    } catch (e) {
      print("postLogOut ${e.toString()}");
    }
    return null;
  }

  //this is for ForgotEmail APi where email is Sent
  Future<ForgotEmail?> forgotEmail(String email) async {
    try {
      final response =
          await httpClient!.post("${AppUrl.forgotEmail}?email=$email");
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      String responseString;
      if (response.statusCode == 200) {
        responseString = response.body;
        return forgotEmailFromJson(responseString);
      } else if (response.statusCode == 401) {
        responseString = response.body;
        print(responseString);
        return null;
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("forgotEmail ${e.toString()}");
    }
    return null;
  }

  //this is for VerificationCode  APi for both SigunUp and ForgotOtp where email is Sent
  Future<bool?> verification(
      {String? verification,
      var userId,
      String? type,
      String? email,
      String? phone,
      String? password}) async {
    String forgotUrl =
        "${AppUrl.forgotVerifyOtp}?otp=$verification&user_id=$userId";
    String signUpVerifyUrl =
        "${AppUrl.forgotVerifyOtp}?otp=$verification&user_id=$userId&type=$type&email=$email&phone=$phone&password=$password";
    String verifyUrl;

    type == "register" ? verifyUrl = signUpVerifyUrl : verifyUrl = forgotUrl;
    try {
      final response = await httpClient!.post(verifyUrl);
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      String responseString;
      if (response.statusCode == 200) {
        responseString = response.body;
        if (responseString.contains("false") && type == "register") {
          loginCheck = false;
          prefs!.setString("userInfo", responseString);
        }
        return false;
      } else if (response.statusCode == 401) {
        responseString = response.body;
        if (responseString.contains("true")) {
          loginCheck = true;
        }
        print(responseString);
        return true;
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("verification ${e.toString()}");
    }
    return null;
  }

  //this is for ForgotResetPassword  APi where email is Sent
  Future<ForgotResetPasswordModel?> forgotResetPassword(
      var userId, String password, String confirmPassword) async {
    try {
      print(password);
      print(userId);
      print(confirmPassword);
      final response = await httpClient!.post(
          "${AppUrl.forgotResetPass}?user_id=$userId&password=$password&password_confirmation=$confirmPassword");
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      String responseString;
      if (response.statusCode == 200) {
        responseString = response.body;
        return forgotResetPasswordModelFromJson(responseString);
      } else if (response.statusCode == 401) {
        responseString = response.body;
        print(responseString);
        return null;
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("forgotResetPassword ${e.toString()}");
    }
    return null;
  }

  Future<ForgotResetPasswordModel?> changePassword(String old_password,
      String password, String password_confirmation) async {
    try {
      print(password_confirmation);
      final response = await httpClient!.post(
          "${AppUrl.changePassword}?old_password=$old_password&password=$password&password_confirmation=$password_confirmation");
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      String responseString;
      if (response.statusCode == 200) {
        responseString = response.body;
        return forgotResetPasswordModelFromJson(responseString);
      } else if (response.statusCode == 401) {
        responseString = response.body;
        print(responseString);
        return null;
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("ConfirmPassword ${e.toString()}");
    }
    return null;
  }

  //emaiExist Api is Calling here
  Future<bool?> emaiExist(String email) async {
    try {
      print(email);
      final response =
          await httpClient!.post("${AppUrl.emailExistUrl}?email=$email");
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      String responseString;
      if (response.statusCode == 200) {
        responseString = response.body;
        return false;
      } else if (response.statusCode == 401) {
        responseString = response.body;
        print(responseString);

        return true;
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("emaiExist ${e.toString()}");
    }
    return null;
  }

  //SignUpApi which is in Professional Page in next Sceen method is called here
  Future<ProfessionalInfoModel?> signUpPost(
      String fname,
      String lname,
      String email,
      String phone,
      var locations,
      var role,
      var employees,
      var department,
      var categories,
      var password,
      var initialSignature) async {
    try {
      //String leadUrl = "${AppUrl.signUpPostUrl}?first_name=$fname&last_name=$lname&email=$email&phone=$phone&locations=$locations&role=$role&employees=$employees&department=$department&password=$password&password_confirmation=$password&initial-signature=$initialSignature";
      String leadUrl =
          "${AppUrl.signUpPostUrl}?first_name=$fname&last_name=$lname&email=$email&phone=$phone&locations=$locations&role=$role&employees=$employees&department=$department&password=$password&password_confirmation=$password";

      //String categoriesUrl = "${AppUrl.signUpPostUrl}?first_name=$fname&last_name=$lname&email=$email&phone=$phone&locations=$locations&role=$role&categories=$categories&password=$password&password_confirmation=$password&initial-signature=$initialSignature";
      String categoriesUrl =
          "${AppUrl.signUpPostUrl}?first_name=$fname&last_name=$lname&email=$email&phone=$phone&locations=$locations&role=$role&categories=$categories&password=$password&password_confirmation=$password";

      var leadSignature = {"initial-signature": "${initialSignature.toString()}"};
      var categoriesSignature = {"initial-signature": "${initialSignature.toString()}"};
      // var leadSignature = {"initial-signature": "ABC"};
      // var categoriesSignature = {"initial-signature": "ABC"};
      ProfessionalInfoPageState.grpVal == 0
          ? log("HERE URL: ${leadUrl} ${leadSignature}")
          : log("HERE URL: ${categoriesUrl} ${categoriesSignature}");

      String singUpUrl;
      ProfessionalInfoPageState.grpVal == 0
          ? singUpUrl = leadUrl
          : singUpUrl = categoriesUrl;
      //final response = await httpClient!.post(singUpUrl);
      final response = await httpClient!.post(singUpUrl,
          body: ProfessionalInfoPageState.grpVal == 0
              ? leadSignature
              : categoriesSignature);
      print("This is StatusCode in APIPROVIDER:: ${response.body}");
      String responseString;
      if (response.statusCode == 200) {
        print("*****************200");
        responseString = response.body;
        return professionalInfoModelFromJson(responseString);
      } else if (response.statusCode == 401) {
        print("*****************401");
        responseString = response.body;
        print(responseString);
        return professionalInfoModelFromJson(responseString);
      } else {
        print("*****************else");
        print(response.statusCode);
        print(response.body);
        print(leadUrl);
        print(categoriesUrl);
        print("*****************else");
      }
    } catch (e) {
      print("*****************catch block");
      print("signUpPost ${e.toString()}");
    }
    return null;
  }

  //favourite Api is Calling here
  Future<bool?> postFavourite(var id, var favId, String savedEmployee) async {
    try {
      print(id);
      print(favId);
      print(savedEmployee);
      final response = await httpClient!.post(
          "${AppUrl.favouriteUrl}?id=$id&favorite_id=$favId&type=$savedEmployee",
          headers: header2());
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      String responseString;
      if (response.statusCode == 200) {
        responseString = response.body;
        return false;
      } else if (response.statusCode == 401) {
        responseString = response.body;
        print(responseString);
        return true;
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("postFavourite ${e.toString()}");
    }
    return null;
  }

  //this is for ForgotResetPassword  APi where email is Sent
  Future<JobDialogModel?> jobDialogPost(var jobId) async {
    try {
      print(jobId);
      final response = await httpClient!
          .post("${AppUrl.jobDialogUrl}?job_id=$jobId", headers: header2());
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      String responseString;
      if (response.statusCode == 200) {
        responseString = response.body;
        print("jobdialog Post done");
        print(responseString);
        return jobDialogModelFromJson(responseString);
      } else if (response.statusCode == 401) {
        responseString = response.body;
        print(responseString);
        return null;
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("jobDialogPost ${e.toString()}");
    }
    return null;
  }

// getCategories() async {
//   try {
//     var response = await httpClient!.get(baseUrl+'list/get-categories');
//     List <CategoriesModel> categoryModel=[];
//     if(response.statusCode == 200){
//       Map<String, dynamic> jsonResponse = json.decode(response.body);
//       CategoriesModel listMyModel =  CategoriesModel.fromJson(jsonResponse);
//        categoryModel.add(listMyModel);
//     }
//     return categoryModel;
//   } catch(_){ }
// }

// getId(id) async {
//   try {
//       var response = await httpClient!.get(baseUrl);
//     if(response.statusCode == 200){
//       Map<String, dynamic> jsonResponse = json.decode(response.body);
//         // TODO: implement methods!
//     }else print ('erro -get');
//   } catch(_){ }
// }

// add(obj) async{
//   try {
//     var response = await httpClient!.post( baseUrl,
//       headers: {'Content-Type':'application/json'},

//       body: jsonEncode(obj) );
//     if(response.statusCode == 200){
//       // TODO: implement methods!
//     }else print ('erro -post');
//   } catch(_){ }
// }

// edit(obj) async{
//   try {
//     var response = await httpClient!.put( baseUrl,
//       headers: {'Content-Type':'application/json'},
//       body: jsonEncode(obj) );
//     if(response.statusCode == 200){
//       // TODO: implement methods!
//     }else print ('erro -post');
//   } catch(_){ }
// }

// delete(obj) async{
//   try {
//     var response = await httpClient!.delete( baseUrl);
//       if(response.statusCode == 200){
//         // TODO: implement methods!
//       }else print ('erro -post');
//   } catch(_){ }
// }

}
