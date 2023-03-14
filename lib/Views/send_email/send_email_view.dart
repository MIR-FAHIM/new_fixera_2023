import 'dart:developer';

import 'package:new_fixera/Views/Utilities/AppColors.dart';
import 'package:new_fixera/Views/send_email/send_email_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SendEmailView extends GetView<SendEmailController> {
  @override
  Widget build(BuildContext context) {
    Get.put(SendEmailController());
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text("Email Send"),
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Form(
          key: controller.emailForm.value,
          child: Container(
            height: Get.height,
            width: Get.width,
            color: Colors.white,
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (v) {
                      controller.updateButtonStatus();
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.5),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.primaryColor, width: 2.0),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelText: "Email",
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    validator: (v) {
                      if (v.toString().isEmail) {
                        return null;
                      } else {
                        return "Please Enter Valid Email Addess";
                      }
                      // return controller.validteLoginCredential(
                      //     v, context);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: controller.subjectController,
                    onChanged: (v) {
                      controller.updateButtonStatus();
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.5),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.primaryColor, width: 2.0),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelText: "Subject",
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    validator: (v) {
                      if (v.toString().isNotEmpty) {
                        return null;
                      } else {
                        return "Subject is required";
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Container(
                  //   child: HtmlEditor(
                  //     showBottomToolbar: false,
                  //     hint: "Description",
                  //     key: controller.keyBodyEditor,
                  //     height: 400,
                  //   ),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          print("CHOOSE FILES");
                          controller.chooseFileUsingFilePicker();
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          height: 40,
                          decoration: BoxDecoration(
                            color: controller.hasFile.isFalse
                                ? Colors.grey[300]
                                : AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Choose Files",
                              style: TextStyle(
                                  color: controller.hasFile.isFalse
                                      ? Colors.black
                                      : Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  controller.hasFile.isTrue
                      ? Text("Picked ${controller.fileCount.value} files")
                      : SizedBox(),
                  SizedBox(
                    height: 20,
                  ),
                  controller.btnLoader.isFalse
                      ? InkWell(
                          onTap: () {
                            controller.updateButtonStatus();
                            if (controller.emailForm.value.currentState!
                                .validate()) {
                              controller.uploadImage();
                              //controller.sendEmail();
                            }
                          },
                          child: Container(
                            height: 45,
                            width: Get.width,
                            child: Center(
                              child: Text(
                                "Send Email",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: controller.buttonStatus.isTrue
                                    ? AppColors.primaryColor
                                    : Colors.grey),
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
