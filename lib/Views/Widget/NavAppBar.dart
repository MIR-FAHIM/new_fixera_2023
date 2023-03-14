import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar navAppBar() {
  return AppBar(
    backgroundColor: AppColors.primaryColor,
    elevation: 1.5,
    centerTitle: true,
    // leading: Icon(
    //   Icons.menu,
    // ),
    title: GestureDetector(


      onTap: () {
        // print("Im a useless search");
        Get.toNamed(AppRoutes.SEARCH);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            "I am looking for",
          ),
        ],
      ),
    ),
    actions: [
      SizedBox(
        width: 40.0,
      ),
    ],
  );
}
