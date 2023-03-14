import 'package:new_fixera/Model/ExportModel.dart';
import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/Repositories/repository.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:new_fixera/Views/Widget/ExportWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class PasswordResetPage extends StatefulWidget {
  PasswordResetPage({Key? key}) : super(key: key);

  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  static TextEditingController controllerForgotPassword =
      new TextEditingController();
  static TextEditingController controllerForgotConfirmPassword =
      new TextEditingController();
  static final formKey = GlobalKey<FormState>();
  var _user_id = Get.arguments;
  final MyRepository myRepository =
      MyRepository(apiClient: MyApiClient(httpClient: Client()));
  ForgotResetPasswordModel? _forgotResetPasswordModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: Container(
    child: Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40.0,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                // minLines: 1,
                maxLines: 1,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Password is Required";
                  } else if (value.length < 6) {
                    return "Password must be atleast 6 character";
                  }
                },
                controller: controllerForgotPassword,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                maxLines: 1,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "ConfirmPassword is required";
                  } else if (value != controllerForgotPassword.text) {
                    return "Password is not Matched";
                  }
                },
                controller: controllerForgotConfirmPassword,
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => moveToResetPassword(),

              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  'SUBMIT',
                  style: TextStyle(
                    color: AppColors.backgroundColor,
                    fontSize: Dimension.text_size_large,
                  ),
                ),
              ),

            ),
          ],
        ),
      ),
    ),
      ),
    );
  }

  moveToResetPassword() async {
    if (formKey.currentState!.validate()) {
      if (formKey.currentState!.validate()) {
        print(_user_id);
        ForgotResetPasswordModel forgotResetPasswordModel =
            await myRepository.forgotResetPassword(
                _user_id,
                controllerForgotPassword.text,
                controllerForgotConfirmPassword.text);
        setState(() {
          _forgotResetPasswordModel = forgotResetPasswordModel;
        });
        if (forgotResetPasswordModel.error == false) {
          Get.defaultDialog(
              title: "Password Reset",
              middleText:
                  "Congratulations, You successfully Changed your Password",
              onConfirm: () {
                Get.offAndToNamed(AppRoutes.SIGNINPAGE);
              });
        } else {
          print("******");
          print(_forgotResetPasswordModel!.error);
        }
      }
    }
  }
}
