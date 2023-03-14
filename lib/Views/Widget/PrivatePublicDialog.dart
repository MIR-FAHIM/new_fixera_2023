import 'dart:convert';

import 'package:new_fixera/Controller/JobController.dart';
import 'package:new_fixera/Model/JobModel/JobPrivatePubLicModel.dart';
import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/Repositories/repository.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class MyDialog extends StatefulWidget {
  String? slug;
  var jobId;

  MyDialog({this.slug, this.jobId});

  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  JobPrivatePublicModel? _jobPrivatePublicModel;

  final JobController jobController = Get.put(JobController());

  final MyRepository myRepository =
      MyRepository(apiClient: MyApiClient(httpClient: Client()));

  void public() async {
    print("PUBLIC");
    await myRepository.postPublicPrivateJob(
        widget.slug!, widget.jobId, 'public');

    if (errorStatus == true) {
      print("ERROR TRUE");
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(privatePublicResponse!),
        duration: Duration(milliseconds: 3000),
      ));
    } else {
      print("ERROR FALSE");
      Get.offAndToNamed(AppRoutes.JOBDETAILSPAGE,
          arguments: ["NotPaid", widget.slug, widget.jobId, 'public']);
    }
  }

  void private() async {
    print("PRIVATE");
    await myRepository.postPublicPrivateJob(
        widget.slug!, widget.jobId, 'private');

    if (errorStatus == true) {
      print("ERROR TRUE");
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(privatePublicResponse!),
        duration: Duration(milliseconds: 3000),
      ));
    } else {
      print("ERROR FALSE");
      Get.offAndToNamed(AppRoutes.JOBDETAILSPAGE,
          arguments: ["NotPaid", widget.slug, widget.jobId, 'private']);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("SLUG: " + widget.slug!);
    return AlertDialog(
      title: Obx(() => jobController.jobDialogModel.value != null
          ? Text(
              jobController!.jobDialogModel!.value!.results!.modalHeader!,
              style: TextStyle(
                  fontSize: Get.width / 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            )
          : Text("")),
      content: Obx(() => jobController.jobDialogModel.value != null
          ? Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(32))),
              //height: 250,
              child: SingleChildScrollView(
                child: Column(children: [
                  Text(
                    jobController!
                        .jobDialogModel.value.results!.modalBodyMessageOne!,
                    //textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: Get.width / 30),
                  ),
                  SizedBox(height: 15),
                  Text(
                    jobController!
                        .jobDialogModel.value.results!.modalBodyMessageTwo!,
                    //textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: Get.width / 30),
                  ),
                  SizedBox(height: 15),
                  Text(
                    jobController!
                        .jobDialogModel.value.results!.modalBodyMessageThree!,
                    // textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: Get.width / 30),
                  ),
                  SizedBox(height: 8),
                ]),
              ),
            )
          : Center(child: CircularProgressIndicator())),
      actions: <Widget>[
        Obx(() => jobController.jobDialogModel.value != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: Get.height / 20,
                      width: Get.width / 6,
                      color: Colors.red,
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: Get.width / 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // GestureDetector(
                  //   color: Colors.red,
                  //   onPressed: () {
                  //     Get.back();
                  //   },
                  //   child: Text(
                  //     "Cancel",
                  //     style: TextStyle(
                  //       fontSize: Get.width/40,
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    width: Get.width / 70,
                  ),
                  GestureDetector(
                    onTap: () {
                      public();
                    },
                    child: Container(
                      height: Get.height / 20,
                      width: Get.width / 6,
                      color: AppColors.primaryColor,
                      child: Center(
                        child: Text(
                          "Public",
                          style: TextStyle(
                            fontSize: Get.width / 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // GestureDetector(
                  //   onPressed: public,
                  //   color: AppColors.primaryColor,
                  //   child: Text(
                  //     "Public",
                  //     style: TextStyle(
                  //       fontSize: Get.width/40,
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    width: Get.width / 70,
                  ),
                  GestureDetector(
                    onTap: () {
                      private();
                    },
                    child: Container(
                      height: Get.height / 20,
                      width: Get.width / 6,
                      color: AppColors.primaryColor,
                      child: Center(
                        child: Text(
                          "Private",
                          style: TextStyle(
                            fontSize: Get.width / 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // GestureDetector(
                  //     onPressed: private,
                  //     color: AppColors.primaryColor,
                  //     child: Text("Private",
                  //         style: TextStyle(
                  //           fontSize: Get.width/40,
                  //           color: Colors.white,
                  //         )))
                ],
              )
            : Text("")),
      ],
    );
  }
}
