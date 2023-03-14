import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CongratulationsPage extends StatefulWidget {
  @override
  _CongratulationsPageState createState() => _CongratulationsPageState();
}

class _CongratulationsPageState extends State<CongratulationsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Column(
            children: [
              SizedBox(
                height: 16.0,
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
                height: 40.0,
              ),
              Container(
                alignment: Alignment.center,
                // color: AppColors.backgroundColor,
                child: Text(
                  "Congratulations!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Dimension.text_size_extra1_large,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                alignment: Alignment.center,
                // color: AppColors.backgroundColor,
                child: Text(
                  "Your account has been created. You can go to your dashboard by clicking on the \'Login Now\' button.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Dimension.text_size_semi_medium,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 35.0,
          ),
          GestureDetector(
            onTap: () {
              //Get.offAndToNamed(AppRoutes.BOTTOMNAVIGATIONPAGE);
              Get.offAndToNamed(AppRoutes.SIGNINPAGE);
            },

            child: Padding(
              padding: const EdgeInsets.only(
                top: 15.0,
                bottom: 15.0,
                right: 40.0,
                left: 40.0,
              ),
              child: Text(
                //"GO TO DASHBOARD",
                "Login Now",
                style: TextStyle(
                  color: AppColors.backgroundColor,
                  fontSize: Dimension.text_size_large,
                ),
              ),
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
   