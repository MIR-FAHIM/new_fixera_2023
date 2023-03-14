import 'package:new_fixera/Views/Utilities/AppColors.dart';
import 'package:new_fixera/Views/create_estimation/create_estimation.dart';
import 'package:new_fixera/Views/create_estimation/estimation_detail.dart';
import 'package:new_fixera/Views/create_estimation/estimation_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utilities/AppDimension.dart';

class CreateEstimationList extends GetView<CreateEstimationListController> {
  @override
  Widget build(BuildContext context) {
    Get.put(CreateEstimationListController());
    return Obx(() {
      return WillPopScope(
        onWillPop: () async {
          controller.goBack();
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            title: Text("Estimation List"),
            leading: GestureDetector(
              onTap: () {
                controller.goBack();
              },
              child: Icon(Icons.arrow_back),
            ),
            actions: [
              InkWell(
                onTap: () {
                  Get.to(() => CreateEstimationForm());
                },
                child: Container(
                  margin: EdgeInsets.only(top: 7, bottom: 7, right: 5),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Create Estimation Form",
                      style: TextStyle(fontSize: 10, color: Colors.black),
                    ),
                  ),
                ),
              )
            ],
          ),
          body: controller.pageLoader.isTrue
              ? Container(
                  height: Get.height,
                  width: Get.width,
                  color: Colors.white,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(
                  height: Get.height,
                  width: Get.width,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            Container(
                              color: Color(0xffA0C828),
                              height: 60,
                              width: 3,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Estimation List",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimension.text_size_medium),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: ListView.builder(
                            //shrinkWrap: true,
                            // physics: NeverScrollableScrollPhysics(),
                            itemCount: controller
                                .estimationData.value.results!.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              var estimation = controller
                                  .estimationData.value.results!.data![index];
                              return Container(
                                margin: EdgeInsets.only(bottom: 10),
                                padding: EdgeInsets.all(10),
                                width: Get.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(width: 1)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Since: ",
                                      style: controller.titleTextStyle,
                                    ),
                                    Text(
                                        "${controller.parsedTime(estimation.createdAt!)}"),
                                    Text(
                                      "Receivable Email: ",
                                      style: controller.titleTextStyle,
                                    ),
                                    Text("${estimation.receiverEmail}"),
                                    Text(
                                      "Project Title: ",
                                      style: controller.titleTextStyle,
                                    ),
                                    Text("${estimation.projectTitle}"),
                                    Text(
                                      "Price: ",
                                      style: controller.titleTextStyle,
                                    ),
                                    Text("\$${estimation.price}"),
                                    Text(
                                      "Company Representative Info: ",
                                      style: controller.titleTextStyle,
                                    ),
                                    Text(
                                        "• ${estimation.companyRepresentiveName}"),
                                    Text(
                                        "• ${estimation.companyRepresentiveEmail}"),
                                    Text(
                                        "• ${estimation.companyRepresentivePhone}"),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        height: 40,
                                        width: Get.width / 5,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: Colors.black, width: 1)),
                                        child: IconButton(
                                          onPressed: () {
                                            String url =
                                                "https://www.fix-era.com/api/v1/create-estimation/${estimation.id}";
                                            print(url);
                                            Get.to(() => EstimationDetail(
                                                  url: url,
                                                ));
                                          },
                                          icon: Icon(
                                            Icons.remove_red_eye,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                        //color: Colors.blue,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          bottomNavigationBar: Container(
            height: 50,
            width: Get.width,
            color: Colors.white,
            child: Align(
              alignment: Alignment.center,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: controller.pageNumbers.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () async {
                      controller.pageLoader.value = true;
                      controller.apiPageNumber.value = index + 1;
                      controller.pageNumbers.clear();
                      controller.getEstimationList();
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: 40,
                      width: 40,
                      child: Center(
                        child: Text("${index + 1}"),
                      ),
                      decoration: BoxDecoration(
                        color: controller.apiPageNumber.value == index + 1
                            ? AppColors.primaryColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
    });
  }
}
