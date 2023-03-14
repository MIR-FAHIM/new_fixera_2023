import 'dart:convert';

import 'package:new_fixera/Model/ChangePassModel/Change_Pass_Model.dart';
import 'package:new_fixera/Model/ExportModel.dart';
import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/Repositories/repository.dart';
import 'package:new_fixera/SharedPreferance/shared_preferance.dart';
import 'package:new_fixera/Views/Screens/BottomNavigationScreen/BottomNavigationPage.dart';
import 'package:new_fixera/Views/Screens/ExportScreens.dart';
import 'package:new_fixera/Views/Utilities/AppColors.dart';
import 'package:new_fixera/Views/Utilities/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../../../main.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  static headers() => {
    'Content-Type': 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
    //'Authorization': '${userMap["access_token"]}'
    'Authorization': '$tokenType $token',
  };
  String? currentPass;
  String? newPass;
  String? confirmPass;

  bool status = false;

  var userToken;

  var loaderStatus;
  ChangePasswordModel? _changePasswordModel;

  TextEditingController oldPasswordController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPassController = new TextEditingController();
  final MyRepository myRepository =
      MyRepository(apiClient: MyApiClient(httpClient: Client()));

  Map<String, dynamic> userMap = jsonDecode(user!);

  changeUserPass(String old_password, String password,
      String password_confirmation) async {
    setState(() {
      loaderStatus=true;
    });

    try {
      var headers = {
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        //'Authorization': '${userMap["access_token"]}'
        'Authorization': '$tokenType $token',
        //'Authorization': userToken  //TODO use token from SP Rafid>>
      };
      var request = http.MultipartRequest(
          'POST',
          // Uri.parse(
          //     'https://www.fix-era.com/api/v1/profile/settings/change-password'));
      Uri.parse(
              'https://www.fix-era.com/api/v1/profile/settings/change-password'));
      request.fields.addAll({
        'old_password': oldPasswordController.text,
        'password': passwordController.text,
        'password_confirmation': confirmPassController.text
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();


      if (response.statusCode == 200) {
        print("VALUE_VALUE_BRO");
        Map<String, dynamic> resp =
        jsonDecode(await response.stream.bytesToString());
        print("YO__YO_BRO__$resp");
        print("___HLWWWWW______${resp["error"]}");
        setState(() {
          loaderStatus=false;
        });
        Fluttertoast.showToast(
            msg: "${resp["results"]}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 20.0);

        Route route = MaterialPageRoute(builder: (c) => SignInPage());
        Navigator.pushReplacement(context, route);
      } else {
        Map<String, dynamic> resp =
        jsonDecode(await response.stream.bytesToString());
        print("yo--yo---$resp");
        setState(() {
          loaderStatus=false;
        });
        Fluttertoast.showToast(
            msg: "${resp["message"]}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 15.0);

      }
    } catch (e) {
      print("MY___TOKEN____$token");
      print("THIS IS CATCH ERROR");
      print(e.toString() + "Catch Block Message");
    }
  }

  @override
  void initState() {
    super.initState();
    userToken = userMap["access_token"];
    currentPass = oldPasswordController.text;
    newPass = passwordController.text;
    confirmPass = confirmPassController.text;
    loaderStatus=false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Route route =
        MaterialPageRoute(builder: (c) => BottomNavigationPage());
        Navigator.pushReplacement(context, route);
        var a;
        return a;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          leading: IconButton(
            onPressed: () {
              Route route =
                  MaterialPageRoute(builder: (c) => BottomNavigationPage());
              Navigator.pushReplacement(context, route);
            },
            icon: Icon(Icons.arrow_back),
          ),

          title: Text("Change Password"),


        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 100, 20, 10),
            child: Form(
              child: Column(
                children: [
                  Material(
                    elevation: 2.0,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                      child: TextFormField(
                        controller: oldPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.lock,
                              color: Colors.grey,
                            ),
                            hintText: 'Current Password'),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Material(
                    elevation: 2.0,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.lock,
                              color: Colors.grey,
                            ),
                            hintText: 'New Password'),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Material(
                    elevation: 2.0,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                      child: TextFormField(
                        controller: confirmPassController,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.lock,
                              color: Colors.grey,
                            ),
                            hintText: 'Confirm Password'),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                    child: GestureDetector(
                      onTap: () {
                        changeUserPass(currentPass!, newPass!, confirmPass!);
                       // changeYourPass(currentPass, newPass, confirmPass);
                      },
                      child: Center(
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 1.5,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Center(
                              child: Container(
                            child:

                              loaderStatus==false?


                            Text(

                              "Update Password",

                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            )

                               :
                               Center(
                                 child: CircularProgressIndicator(),
                               )
                                ,
                          )),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future changeYourPass(
      String old_password, String password,
      String password_confirmation) async {


    final String url = "https://www.fix-era.com/api/v1/profile/settings/change-password";


    try {
      final response = await http.post(url, headers: headers(), body: {
        'old_password': oldPasswordController.text,
        'password': passwordController.text,
        'password_confirmation': confirmPassController.text
      });
      print(response.statusCode);

      if (response.statusCode == 200) {
        print("success");
        String jsonResponseString = response.body;
        print("IS___IT_____WORKING___RESPONE___$jsonResponseString");
        return (jsonDecode(jsonResponseString));
      } else {
        throw Exception('Failed to create RecievedCount.');
      }
    } catch (e) {
      print("MY___TOKEN____$token");
      print(e.toString());
    }
  }
}
