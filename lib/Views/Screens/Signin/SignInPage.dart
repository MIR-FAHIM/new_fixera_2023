import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/Repositories/repository.dart';
import 'package:new_fixera/SharedPreferance/shared_preferance.dart';
import 'package:new_fixera/Views/Utilities/AppColors.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:new_fixera/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

bool loginStatus = false;

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

enum FormType { login, register }

class _SignInPageState extends State<SignInPage> {
  int visible = 0;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _emailFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();
  final MyRepository myRepository =
      MyRepository(apiClient: MyApiClient(httpClient: Client()));

  String _email = "";
  String _password = "";
  FormType _form = FormType
      .login; // our default setting is to login, and we should switch to creating an account when the user chooses to

  _LoginPageState() {
    _emailFilter.addListener(_emailListen);
    _passwordFilter.addListener(_passwordListen);
  }

  void _emailListen() {
    if (_emailFilter.text.isNotEmpty) {
      _email = _emailFilter.text;
    }
  }

  void _passwordListen() {
    if (_passwordFilter.text.trim().isEmpty) {
      _password = "";
    } else {
      _password = _passwordFilter.text.trim();
    }
  }

  // Swap in between our two forms, registering and logging in
  void _formChange() async {
    setState(() {
      if (_form == FormType.register) {
        _form = FormType.login;
      } else {
        _form = FormType.register;
      }
    });
  }

  Widget _buildTextFields() {
    return new Container(
      child: new Column(
        children: <Widget>[
          Form(
            key: formKey,
            // ignore: deprecated_member_use
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              children: <Widget>[
                TextFormField(
                  maxLines: 1,
                  controller: _emailFilter,
                  decoration: new InputDecoration(
                    labelText: 'Email',
                    suffixIcon: Icon(
                      Icons.email_outlined,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.trim().isEmpty)
                      return "Email is Required";
                    else if (!GetUtils.isEmail(value.trim()))
                      return "Please enter valid email";
                    else
                      return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  maxLines: 1,
                  controller: _passwordFilter,
                  decoration: new InputDecoration(
                    labelText: 'Password',
                    suffixIcon: Icon(
                      Icons.lock_outline,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Password is Required";
                    }
                  },
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  moveToHome() async {
    bool login = false;
    final key = "loggedin";
    if (formKey.currentState!.validate()) {
      String email = _emailFilter.text;
      String password = _passwordFilter.text;
      print(email + "" + password);
      print("SignIn call");
      setState(
        () {
          visible++;
          FocusScope.of(context).unfocus();
          loginStatus = true;
          prefs!.setBool("loginStatus", loginStatus);
          login = true;
          SharedPref.to.prefss!.setBool(key, login);
          print("***********************************" +
              SharedPref.to.prefss!.getBool("loggedin").toString() +
              "******After SIgnin Button Press");
        },
      );
      await myRepository.postLoginData(email, password);
      setState(
        () async {
          visible = 0;
          if (loginCheck == true) {
            loginStatus = false;
            prefs!.setBool("loginStatus", loginStatus);
            Route route = MaterialPageRoute(builder: (c) => SignInPage());
            Navigator.pushReplacement(context, route);

            showDialog(
                context: context,
                builder: (BuildContext context) {
                  AlertDialog dialog = AlertDialog(
                    content: Text(
                      "Unauthorized",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    actions: [
                      GestureDetector(
                        child: Text("Cancel"),
                        onTap: () async {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  );
                  return dialog;
                });

            // Get.defaultDialog(
            //   title: "Alert",
            //   middleText: "Unauthorized",
            //   onCancel: () {
            //     //Get.back();
            //     //Navigator.of(context, rootNavigator: true).pop();
            //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignInPage()));
            //     },
            // );
          } else if (loginCheck == false) {
            // loginStatus = true;
            // prefs.setBool("loginStatus", loginStatus);
            _emailFilter.clear();
            _passwordFilter.clear();
            print("XYZXYZXYZXYZYXYZYXYYZYZYXXYX");
            await Future.delayed(Duration(milliseconds: 200));
            Get.offNamed(AppRoutes.BOTTOMNAVIGATIONPAGE);
          }
        },
      );
    }
  }

  Widget _buildButtons() {
    if (_form == FormType.login) {
      return Container(
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () => moveToHome(),
              child: AnimatedContainer(
                duration: Duration(seconds: 2),
                height: visible == 1 ? 50 : 60,
                width: visible == 1 ? 50 : 140,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius:
                        BorderRadius.circular(visible == 1 ? 60 : 10)),
                alignment: Alignment.center,
                child: visible == 1
                    ? Center(child: CircularProgressIndicator())
                    : Text(
                        "Sign In",
                        style: TextStyle(
                          color: AppColors.backgroundColor,
                          fontSize: Dimension.text_size_large,
                        ),
                      ),
              ),
            ),
            GestureDetector(
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  fontSize: Dimension.text_size_medium,
                ),
              ),
              onTap: _passwordReset,
            )
          ],
        ),
      );
    } else {
      return Container(
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Text('Create an Account'),
              onTap: _createAccountPressed,
            ),
            GestureDetector(
              child: Text('Have an account? Click here to login.'),
              onTap: _formChange,
            )
          ],
        ),
      );
    }
  }

  // These functions can self contain any user auth logic required, they all have access to _email and _password

  void _loginPressed() {
    print('The user wants to login with $_email and $_password');
  }

  void _createAccountPressed() {
    print('The user wants to create an accoutn with $_email and $_password');
  }

  void _passwordReset() {
    print("The user wants a password reset request sent to $_email");
    Get.toNamed(AppRoutes.FORGOTMAIL);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        var a ;

        return a;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text("Sign In Now"),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        bottomNavigationBar: Container(
          width: Get.width,
          color: AppColors.primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Do not have an account?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    //fontSize: Dimension.text_size_small,
                    color: AppColors.backgroundColor,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  child: Text(
                    "Create Account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      //fontSize: Dimension.text_size_small,
                      color: AppColors.backgroundColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Get.offAndToNamed(AppRoutes.SIGNUPPAGE);
                  },
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 28.0,
                            ),
                            Container(
                              alignment: Alignment.center,
                              // color: AppColors.backgroundColor,
                              child: Image.asset(
                                'images/fixera_logo.png',
                                height: 40,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            // Container(
                            //   alignment: Alignment.center,
                            //   // color: AppColors.backgroundColor,
                            //   child: Text(
                            //     "What is Lorem Ipsum Lorem Ipsum is simply dummy text of the printing.",
                            //     textAlign: TextAlign.center,
                            //     style: TextStyle(
                            //       fontSize: Dimension.text_size_small,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        child: Column(
                          children: [
                            _buildTextFields(),
                            SizedBox(
                              height: 25.0,
                            ),
                            _buildButtons()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
