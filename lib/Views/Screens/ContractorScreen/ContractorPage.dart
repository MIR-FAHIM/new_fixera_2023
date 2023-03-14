import 'package:new_fixera/Controller/ContractorController.dart';
import 'package:new_fixera/Controller/ExportController.dart';
import 'package:new_fixera/Model/ContractorModel/ContractorDetailsModel.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:new_fixera/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import 'ContractorDetailsPage.dart';

class ContractorPage extends StatefulWidget {
  @override
  _ContractorPageState createState() => _ContractorPageState();
}

class _ContractorPageState extends State<ContractorPage> {
  var savedType;
  bool isFavColors = true;
  var _id;
  final ContractorController contractorController = Get.find();

  ContractorDetailsModel? _contractorDetailsModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: Obx(() {
        return Container(
            height: Get.height,
            child: RefreshIndicator(
              onRefresh: () {
                return Future.delayed(Duration(seconds: 1), () {
                  var page = 0.obs;
                  setState(() {
                    contractorController.page.value = 1;
                    contractorController.list.clear();
                    contractorController.fetchContractor(page);
                  });
                });
              },
              child: Column(
                children: [
                  Expanded(
                    child: contractorController.list.length == 0
                        ? Container()
                        : ListView.builder(
                            controller:
                                contractorController.scrollControllerContractor,
                            addAutomaticKeepAlives: true,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: false,
                            itemCount: contractorController.list.length,
                            itemBuilder: (context, index) {
                              isFavColors =
                                  contractorController.list[index].isFavourite;
                              //  print("This is ContractorTemplist");
                              //     print(contractorController.list);
                              return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Positioned(
                                        child: GestureDetector(
                                          onTap: () async {
                                            _id = contractorController
                                                .list[index].id;

                                            setState(() {
                                              Get.toNamed(
                                                  AppRoutes
                                                      .CONTRACTORDETAILSPAGE,
                                                  arguments: _id);
                                            });
                                            // Get.to(()=>ContratorDetailsPage(contractorController.list[index]
                                            //     ));
                                          },
                                          child: Card(
                                            color: Colors.white,
                                            child: SizedBox(
                                              //height: 80,
                                              child: ListTile(
                                                title: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      contractorController
                                                                  .list[index]
                                                                  .verifyStatus ==
                                                              true
                                                          ? Icons.check_circle
                                                          : Icons
                                                              .check_circle_outline,
                                                      color: Colors.green,
                                                      size: Dimension
                                                          .icon_size_medium,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          contractorController
                                                                      .list[
                                                                          index]
                                                                      .name
                                                                      .toString()
                                                                      .length <
                                                                  14
                                                              ? contractorController
                                                                  .list[index]
                                                                  .name
                                                              : contractorController
                                                                      .list[
                                                                          index]
                                                                      .name
                                                                      .substring(
                                                                          0,
                                                                          12) +
                                                                  "...",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: Dimension
                                                                .text_size_medium,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                subtitle: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      contractorController
                                                          .list[index].tagline,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "\$ " +
                                                              contractorController
                                                                  .list[index]
                                                                  .hourlyRate
                                                                  .toString() +
                                                              " /hr |",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        RatingBar.builder(
                                                          ignoreGestures: true,
                                                          itemSize: 20,
                                                          initialRating: double.parse(
                                                        contractorController
                                                            .list[
                                                        index]
                                                            .rating) ==
                                                            null
                                                            ? 0
                                                            : double.parse(
                                                            contractorController
                                                                .list[
                                                            index]
                                                                .rating),
                                                          minRating: 0,
                                                          direction:
                                                              Axis.horizontal,
                                                          // allowHalfRating: true,
                                                          itemCount: 5,
                                                          //itemPadding: EdgeInsets.only(),
                                                          itemBuilder:
                                                              (context, _) =>
                                                                  Icon(
                                                            Icons.star,
                                                            size: 2,
                                                            color: Colors.amber,
                                                          ), onRatingUpdate: (double value) {  },
                                                          // onRatingUpdate: (rating) {
                                                          //   print(rating);
                                                          // },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                leading: Container(
                                                  height: 120,
                                                  width: 60,
                                                  child: contractorController
                                                              .list[index]
                                                              .avatar ==
                                                          "0"
                                                      ? Container(
                                                          color: Colors.grey,
                                                          child: Center(
                                                            child: Text(
                                                              '255x255',
                                                              style: TextStyle(
                                                                  fontSize: 8),
                                                            ),
                                                          ),
                                                        )
                                                      : Image.network(
                                                          contractorController
                                                              .list[index]
                                                              .avatar),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: Get.height / 30,
                                        left: Get.width / 1.1 - 17,
                                        child: IconButton(
                                          onPressed: () async {
                                            savedType = "saved_freelancer";
                                            await contractorController
                                                .repository
                                                .postFavourite(
                                                    userMap!["user_info"]["id"],
                                                    contractorController
                                                        .list[index].id,
                                                    savedType);
                                            setState(() {
                                              contractorController
                                                      .list[index].isFavourite =
                                                  !contractorController
                                                      .list[index].isFavourite;
                                            });
                                          },
                                          icon: CircleAvatar(
                                            backgroundColor: isFavColors == true
                                                ? Colors.red
                                                : Colors.grey,
                                            radius: 13,
                                            child: Icon(
                                              Icons.favorite,
                                              size: 15,
                                              color: AppColors.backgroundColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ));
                            }),
                  ),
                  Visibility(
                    visible: contractorController.isLoading.value,
                    child: Align(
                      child: CupertinoActivityIndicator(),
                      alignment: Alignment.bottomCenter,
                    ),
                  )
                ],
              ),
            ));
      })),
    );
  }
}
