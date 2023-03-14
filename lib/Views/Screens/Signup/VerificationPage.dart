import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerificationPage extends StatefulWidget {
  @override
  VerificationPageState createState() => VerificationPageState();
}

class VerificationPageState extends State<VerificationPage> {
  static final formKey = GlobalKey<FormState>();
  static TextEditingController controllerVerificationCode =
      new TextEditingController();

  String? verificationCode;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Column(
            children: [
              SizedBox(
                height: 35.0,
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
                height: 16.0,
              ),
              Container(
                alignment: Alignment.center,
                // color: AppColors.backgroundColor,
                child: Text(
                  "You\'re Almost There",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Dimension.text_size_medium,
                  ),
                ),
              ),
                SizedBox(
                height: 16.0,
              ),
              Container(
                alignment: Alignment.center,
                // color: AppColors.backgroundColor,
                child: Text(
                  "Almost creation of your account has been completed",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Dimension.text_size_small,
                    color: AppColors.textColorGrey,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
          // Container(
          //   height: 200.0,
          //   width: 200.0,
          //   // color: AppColors.textColor,
          //   decoration: BoxDecoration(
          //     // border: Border.all(
          //     //   color: Colors.red[500],
          //     // ),
          //     color: AppColors.textColorGrey,
          //     borderRadius: BorderRadius.all(
          //       Radius.circular(10),
          //     ),
          //   ),
          // ),

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
          // GestureDetector(
          //   child: Container(
          //     alignment: Alignment.center,
          //     // color: AppColors.backgroundColor,
          //     child: Text(
          //       "Why I need code?",
          //       textAlign: TextAlign.center,
          //       style: TextStyle(
          //         fontSize: Dimension.text_size_small,
          //         color: AppColors.primaryColor,
          //       ),
          //     ),
          //   ),
          //   onTap: () {
          //     print("Why I need code?");
          //   },
          // ),
          SizedBox(
            height: 35.0,
          ),
          Form(
            key: formKey,
            child: TextFormField(
              maxLines: 1,
              controller: controllerVerificationCode,
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
          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
