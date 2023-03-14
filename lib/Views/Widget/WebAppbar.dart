import 'package:new_fixera/Views/Utilities/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

Widget webAppbar(String textShow, InAppWebViewController _webViewController) {
  return AppBar(
    backgroundColor: AppColors.primaryColor,
    title: Text(textShow),
    centerTitle: true,
    leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        if (_webViewController != null) {
          print("print Pressed");
          _webViewController.canGoBack().then((value) {
            if (value) {
              _webViewController.goBack();
            } else {
              Get.back();
            }
          });
        }
      },
    ),
  );
}
