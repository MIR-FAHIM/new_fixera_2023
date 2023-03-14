import 'package:new_fixera/Views/Utilities/AppColors.dart';
import 'package:new_fixera/Views/create_workorder/controller/create_work_order_controller.dart';
import 'package:new_fixera/Views/create_workorder/create_workorder_webview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utilities/AppDimension.dart';

class CreateWorkOrderView extends GetView<CreateWorkOrderController> {
  @override
  Widget build(BuildContext context) {
    Get.put(CreateWorkOrderController());
    return Obx(() {
      return WillPopScope(
        onWillPop: () async {
          controller.goBack();
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            title: Text("Work Order List"),
            leading: GestureDetector(
              onTap: () {
                controller.goBack();
              },
              child: Icon(Icons.arrow_back),
            ),
            actions: [
              InkWell(
                onTap: () {
                  Get.to(() => CreateWorkOrderWebview());
                },
                child: Container(
                  margin: EdgeInsets.only(top: 7, bottom: 7, right: 5),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Create Work Order Form",
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
                              "Work Order List",
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
                            itemCount: controller
                                .workOrderData.value.results!.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              var workOder = controller
                                  .workOrderData.value.results!.data![index];
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
                                        "${controller.parsedTime(workOder!.createdAt!)}"),
                                    Text(
                                      "Receivable Email: ",
                                      style: controller.titleTextStyle,
                                    ),
                                    Text("${workOder.receivableEmail}"),
                                    Text(
                                      "Job Name: ",
                                      style: controller.titleTextStyle,
                                    ),
                                    Text("${workOder.jobName}"),
                                    Text(
                                      "Price: ",
                                      style: controller.titleTextStyle,
                                    ),
                                    Text("\$${workOder.price}"),
                                    Text(
                                      "Customer Info: ",
                                      style: controller.titleTextStyle,
                                    ),
                                    Text("• ${workOder.customerName}"),
                                    Text("• ${workOder.customerAddress}"),
                                    Text(
                                      "Company Representative Info: ",
                                      style: controller.titleTextStyle,
                                    ),
                                    Text("• ${workOder.comRepName}"),
                                    Text("• ${workOder.comRepPhone}"),
                                    Text("• ${workOder.comRepEmail}"),
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
                      controller.getInvoiceList();
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
