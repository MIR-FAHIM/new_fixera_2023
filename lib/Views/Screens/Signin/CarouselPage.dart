import 'dart:async';
import 'dart:convert';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import 'package:http/http.dart' as http;

class CarouselPage extends StatefulWidget {
  @override
  _CarouselPageState createState() => _CarouselPageState();
}

class _CarouselPageState extends State<CarouselPage> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var _duration = new Duration(milliseconds: 3000);
    timer = Timer(_duration, navigationPage);
  }


  void navigationPage() {
    Get.offAndToNamed(AppRoutes.SIGNINPAGE);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 120,
                          // color: AppColors.backgroundColor,
                          // child: Image.asset(
                          //   'images/fixera_logo.png',
                          //   height: 120,
                          // ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        // Container(
                        //   alignment: Alignment.center,
                        //   // color: AppColors.backgroundColor,
                        //   child: Text(
                        //     "What is Lorem Ipsum Lorem Ipsum is simply dummy text of the printing.",
                        //     textAlign: TextAlign.center,
                        //     style: TextStyle(
                        //       fontSize: Dimension.text_size_medium,
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 20.0,
                        ),
                        // FlatButton(
                        //   onPressed: () {
                        //     timer.cancel();
                        //     print("dispose called");
                        //
                        //     Get.offAndToNamed(AppRoutes.SIGNINPAGE);
                        //   },
                        //   child: Text(
                        //     "Skip",
                        //     style: TextStyle(
                        //       fontSize: Dimension.text_size_large,
                        //       fontWeight: FontWeight.w500,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 300.0,
                  child: Image.asset(
                    'images/fixera_logo.png',
                    height: 120,
                  ),
                  // child: Carousel(
                  //   showIndicator: false,
                  //   autoplayDuration: Duration(milliseconds: 1500),
                  //   images: [
                  //     ExactAssetImage("images/Fixera.png"),
                  //     ExactAssetImage("images/Fixera.png"),
                  //   //  ExactAssetImage("images/Fixera.png"),V
                  //   ],
                  // ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
