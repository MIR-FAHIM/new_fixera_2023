import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/Repositories/repository.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:new_fixera/Views/Widget/ExportWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class ForgotOtp extends StatefulWidget {
  ForgotOtp({Key? key}) : super(key: key);

  @override
  _ForgotOtpState createState() => _ForgotOtpState();
}

class _ForgotOtpState extends State<ForgotOtp> {
  final MyRepository myRepository =
      MyRepository(apiClient: MyApiClient(httpClient: Client()));
  TextEditingController controllerForgotVerificationCode =
      TextEditingController();
  static final formKey = GlobalKey<FormState>();
  String? verificationCode;
  var user_id = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot otp"),
      ),
      body: Container(
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
              Container(
                alignment: Alignment.center,
                // color: AppColors.backgroundColor,
                child: Text(
                  "We have sent you verification on your email.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Dimension.text_size_small,
                    color: AppColors.textColorGrey,
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    maxLines: 1,
                    controller: controllerForgotVerificationCode,
                    decoration: InputDecoration(
                      hintText: 'Input Verification Code',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Please enter verification code";
                      } else {
                        verificationCode = value;
                        print(verificationCode);
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
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
    );
  }

  moveToResetPassword() async {
    bool forgotOtp;
    if (formKey.currentState!.validate()) {
      print(user_id);
      forgotOtp = await myRepository.verification(
        forgotVerification: verificationCode,
        userId: user_id,
      );
      if (forgotOtp == false) {
        Get.offAndToNamed(AppRoutes.PASSWORDRESET, arguments: user_id);
      } else {
        final scaffold = ScaffoldMessenger.of(context);
        scaffold.showSnackBar(
          SnackBar(
            content: Text('Enter Correct Code'),
            action: SnackBarAction(
                label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
          ),
        );
        print("error is true");
      }
    }
  }
}
