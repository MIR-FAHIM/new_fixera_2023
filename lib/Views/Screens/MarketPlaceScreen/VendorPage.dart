import 'package:new_fixera/Controller/ExportController.dart';
import 'package:new_fixera/Views/Utilities/AppDimension.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:new_fixera/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class VendorPage extends StatefulWidget {
  @override
  _VendorPageState createState() => _VendorPageState();
}

class _VendorPageState extends State<VendorPage> {
  var savedType;
  bool isFavColors = true;
  var _id;
  final MarketPlaceController marketPlaceController =
      Get.put(MarketPlaceController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () {
            return Container(
              height: Get.height,
              child: Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () {
                        return Future.delayed(Duration(seconds: 1), () {
                          var page = 0.obs;
                          setState(() {
                            marketPlaceController.page.value = 1;
                            marketPlaceController.list.clear();
                            marketPlaceController.fetchMarketPlace(page);
                          });
                        });
                      },
                      child: marketPlaceController.list.length == 0
                          ? Container()
                          :
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              child: Image.asset(
                                  "images/marketplacebanner.jpeg",
                                fit: BoxFit.fill,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              controller:
                              marketPlaceController.scrollController,
                              itemCount:
                              marketPlaceController.list.length,
                              itemBuilder: (context, index) {
                                isFavColors = marketPlaceController
                                    .list[index].isFavourite;
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    top: 1.0,
                                    left: 5.0,
                                    right: 5.0,
                                    bottom: 0.0,
                                  ),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Card(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: marketPlaceController
                                                      .list[index]
                                                      .banner ==
                                                      "0"
                                                      ? Container(
                                                    color:
                                                    Colors.grey,
                                                    height: 90.0,
                                                    // width: Get.width / 1.1,
                                                    child: Center(
                                                      child: Image
                                                          .asset(
                                                        "images/fixera_logo.png",
                                                        height: 60,
                                                        width: 120,
                                                      ),
                                                    ),
                                                  )
                                                      : CachedNetworkImage(
                                                    fit:
                                                    BoxFit.fill,
                                                    height: 90,
                                                    imageUrl: marketPlaceController
                                                        .list[index]
                                                        .banner
                                                        .toString(),
                                                    placeholder:
                                                        (context,
                                                        url) =>
                                                        Align(),
                                                    errorWidget: (context,
                                                        url,
                                                        error) =>
                                                        Icon(Icons
                                                            .error),
                                                  ),
                                                  //  Image.network(
                                                  //     marketPlaceController
                                                  //         .list[index].banner,
                                                  //     height: 90,
                                                  //   ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Container(
                                                      height: 100.0,
                                                      width: 80.0,
                                                      color: Colors.white,
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          marketPlaceController
                                                              .list[
                                                          index]
                                                              .verifyStatus ==
                                                              true
                                                              ? Icons
                                                              .check_circle
                                                              : Icons
                                                              .check_circle_outline,
                                                          color: Colors
                                                              .green,
                                                          size: Dimension
                                                              .icon_size_medium,
                                                        ),
                                                        SizedBox(
                                                          width: 15.0,
                                                        ),
                                                        Container(
                                                          width: 200,
                                                          child: Text(
                                                            marketPlaceController
                                                                .list[
                                                            index]
                                                                .name,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            style:
                                                            TextStyle(
                                                              fontSize:
                                                              Dimension
                                                                  .text_size_medium,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20.0,
                                                    ),
                                                    Row(
                                                      children: [
                                                        GestureDetector(
                                                          child: Text(
                                                            "Open Jobs",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blue),
                                                          ),
                                                          onTap:
                                                              () async {
                                                            _id = marketPlaceController
                                                                .list[
                                                            index]
                                                                .id;

                                                            setState(
                                                                  () {
                                                                Get.toNamed(
                                                                    AppRoutes
                                                                        .OPENJOB,
                                                                    arguments:
                                                                    _id);
                                                              },
                                                            );
                                                          },
                                                        ),
                                                        SizedBox(
                                                          width: 15.0,
                                                        ),
                                                        Container(
                                                          width: 1,
                                                          height: 20.0,
                                                          color:
                                                          Colors.grey,
                                                        ),
                                                        SizedBox(
                                                          width: 15.0,
                                                        ),
                                                        GestureDetector(
                                                          child: Text(
                                                            "Full Profile",
                                                            style:
                                                            TextStyle(
                                                              color: Colors
                                                                  .blue,
                                                            ),
                                                          ),
                                                          onTap:
                                                              () async {
                                                            _id = marketPlaceController
                                                                .list[
                                                            index]
                                                                .id;

                                                            setState(
                                                                  () {
                                                                Get.toNamed(
                                                                    AppRoutes
                                                                        .FULLPROFILEPAGE,
                                                                    arguments:
                                                                    _id);
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                          top: Get.height / 20,
                                          left: Get.width / 20,
                                          child: marketPlaceController
                                              .list[index]
                                              .avatar ==
                                              "0"
                                              ? Container(
                                            height: 90.0,
                                            width: 90.0,
                                            color: Colors.grey[200],
                                            child: Center(
                                              child: Text(
                                                "255 X 255",
                                                style: TextStyle(
                                                    fontSize: 10),
                                              ),
                                            ),
                                          )
                                              : CachedNetworkImage(
                                            height: 90,
                                            width: 90,
                                            fit: BoxFit.fill,
                                            imageUrl:
                                            marketPlaceController
                                                .list[index]
                                                .avatar
                                                .toString(),
                                            placeholder:
                                                (context, url) =>
                                                Align(
                                                  child:
                                                  LinearProgressIndicator(),
                                                  alignment: Alignment
                                                      .topCenter,
                                                ),
                                            errorWidget: (context,
                                                url, error) =>
                                                Icon(Icons.error),
                                          )),
                                      // Image.network(
                                      //     marketPlaceController
                                      //         .list[index].avatar.toString(),
                                      //     height: 90,
                                      //     width: 90,
                                      //   ),

                                      Positioned(
                                        top: Get.height / 5.5,
                                        left: Get.width / 10,
                                        child: IconButton(
                                          onPressed: () async {
                                            savedType = "saved_employers";
                                            await marketPlaceController
                                                .repository
                                                .postFavourite(
                                                userMap!["user_info"]
                                                ["id"],
                                                marketPlaceController
                                                    .list[index].id,
                                                savedType);
                                            setState(() {
                                              marketPlaceController
                                                  .list[index]
                                                  .isFavourite =
                                              !marketPlaceController
                                                  .list[index]
                                                  .isFavourite;
                                            });
                                          },
                                          icon: CircleAvatar(
                                            backgroundColor:
                                            isFavColors == true
                                                ? AppColors
                                                .textColorRed
                                                : Colors.grey,
                                            radius: 13,
                                            child: Icon(
                                              Icons.favorite,
                                              size: 15,
                                              color: AppColors
                                                  .backgroundColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      // SingleChildScrollView(
                      //         child: Column(
                      //           children: [
                      //             Container(
                      //               child: Image.asset(
                      //                   "images/marketplacebanner.jpeg"),
                      //             ),
                      //             Expanded(
                      //               child: ListView.builder(
                      //                 shrinkWrap: true,
                      //                 physics: NeverScrollableScrollPhysics(),
                      //                 controller: marketPlaceController
                      //                     .scrollController,
                      //                 itemCount:
                      //                     marketPlaceController.list.length,
                      //                 itemBuilder: (context, index) {
                      //                   isFavColors = marketPlaceController
                      //                       .list[index].isFavourite;
                      //
                      //                   return Padding(
                      //                     padding: const EdgeInsets.only(
                      //                       top: 1.0,
                      //                       left: 5.0,
                      //                       right: 5.0,
                      //                       bottom: 0.0,
                      //                     ),
                      //                     child: Stack(
                      //                       overflow: Overflow.visible,
                      //                       children: [
                      //                         Card(
                      //                           child: Column(
                      //                             crossAxisAlignment:
                      //                                 CrossAxisAlignment.start,
                      //                             children: [
                      //                               Row(
                      //                                 children: [
                      //                                   Expanded(
                      //                                     child: marketPlaceController
                      //                                                 .list[
                      //                                                     index]
                      //                                                 .banner ==
                      //                                             "0"
                      //                                         ? Container(
                      //                                             color: Colors
                      //                                                 .grey,
                      //                                             height: 90.0,
                      //                                             // width: Get.width / 1.1,
                      //                                             child: Center(
                      //                                               child: Image
                      //                                                   .asset(
                      //                                                 "images/fixera_logo.png",
                      //                                                 height:
                      //                                                     60,
                      //                                                 width:
                      //                                                     120,
                      //                                               ),
                      //                                             ),
                      //                                           )
                      //                                         : CachedNetworkImage(
                      //                                             fit: BoxFit
                      //                                                 .fill,
                      //                                             height: 90,
                      //                                             imageUrl: marketPlaceController
                      //                                                 .list[
                      //                                                     index]
                      //                                                 .banner
                      //                                                 .toString(),
                      //                                             placeholder:
                      //                                                 (context,
                      //                                                         url) =>
                      //                                                     Align(),
                      //                                             errorWidget: (context,
                      //                                                     url,
                      //                                                     error) =>
                      //                                                 Icon(Icons
                      //                                                     .error),
                      //                                           ),
                      //                                     //  Image.network(
                      //                                     //     marketPlaceController
                      //                                     //         .list[index].banner,
                      //                                     //     height: 90,
                      //                                     //   ),
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                               Row(
                      //                                 children: [
                      //                                   Column(
                      //                                     children: [
                      //                                       Container(
                      //                                         height: 100.0,
                      //                                         width: 80.0,
                      //                                         color:
                      //                                             Colors.white,
                      //                                       ),
                      //                                     ],
                      //                                   ),
                      //                                   Column(
                      //                                     crossAxisAlignment:
                      //                                         CrossAxisAlignment
                      //                                             .start,
                      //                                     children: [
                      //                                       Row(
                      //                                         children: [
                      //                                           Icon(
                      //                                             marketPlaceController
                      //                                                         .list[
                      //                                                             index]
                      //                                                         .verifyStatus ==
                      //                                                     true
                      //                                                 ? Icons
                      //                                                     .check_circle
                      //                                                 : Icons
                      //                                                     .check_circle_outline,
                      //                                             color: Colors
                      //                                                 .green,
                      //                                             size: Dimension
                      //                                                 .icon_size_medium,
                      //                                           ),
                      //                                           SizedBox(
                      //                                             width: 15.0,
                      //                                           ),
                      //                                           Container(
                      //                                             width: 200,
                      //                                             child: Text(
                      //                                               marketPlaceController
                      //                                                   .list[
                      //                                                       index]
                      //                                                   .name,
                      //                                               overflow:
                      //                                                   TextOverflow
                      //                                                       .ellipsis,
                      //                                               style:
                      //                                                   TextStyle(
                      //                                                 fontSize:
                      //                                                     Dimension
                      //                                                         .text_size_medium,
                      //                                               ),
                      //                                             ),
                      //                                           ),
                      //                                         ],
                      //                                       ),
                      //                                       SizedBox(
                      //                                         height: 20.0,
                      //                                       ),
                      //                                       Row(
                      //                                         children: [
                      //                                           GestureDetector(
                      //                                             child: Text(
                      //                                               "Open Jobs",
                      //                                               style: TextStyle(
                      //                                                   color: Colors
                      //                                                       .blue),
                      //                                             ),
                      //                                             onTap:
                      //                                                 () async {
                      //                                               _id = marketPlaceController
                      //                                                   .list[
                      //                                                       index]
                      //                                                   .id;
                      //
                      //                                               setState(
                      //                                                 () {
                      //                                                   Get.toNamed(
                      //                                                       AppRoutes
                      //                                                           .OPENJOB,
                      //                                                       arguments:
                      //                                                           _id);
                      //                                                 },
                      //                                               );
                      //                                             },
                      //                                           ),
                      //                                           SizedBox(
                      //                                             width: 15.0,
                      //                                           ),
                      //                                           Container(
                      //                                             width: 1,
                      //                                             height: 20.0,
                      //                                             color: Colors
                      //                                                 .grey,
                      //                                           ),
                      //                                           SizedBox(
                      //                                             width: 15.0,
                      //                                           ),
                      //                                           GestureDetector(
                      //                                             child: Text(
                      //                                               "Full Profile",
                      //                                               style:
                      //                                                   TextStyle(
                      //                                                 color: Colors
                      //                                                     .blue,
                      //                                               ),
                      //                                             ),
                      //                                             onTap:
                      //                                                 () async {
                      //                                               _id = marketPlaceController
                      //                                                   .list[
                      //                                                       index]
                      //                                                   .id;
                      //
                      //                                               setState(
                      //                                                 () {
                      //                                                   Get.toNamed(
                      //                                                       AppRoutes
                      //                                                           .FULLPROFILEPAGE,
                      //                                                       arguments:
                      //                                                           _id);
                      //                                                 },
                      //                                               );
                      //                                             },
                      //                                           ),
                      //                                         ],
                      //                                       ),
                      //                                     ],
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                               SizedBox(
                      //                                 height: 5.0,
                      //                               ),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                         Positioned(
                      //                             top: Get.height / 20,
                      //                             left: Get.width / 20,
                      //                             child: marketPlaceController
                      //                                         .list[index]
                      //                                         .avatar ==
                      //                                     "0"
                      //                                 ? Container(
                      //                                     height: 90.0,
                      //                                     width: 90.0,
                      //                                     color:
                      //                                         Colors.grey[200],
                      //                                     child: Center(
                      //                                       child: Text(
                      //                                         "255 X 255",
                      //                                         style: TextStyle(
                      //                                             fontSize: 10),
                      //                                       ),
                      //                                     ),
                      //                                   )
                      //                                 : CachedNetworkImage(
                      //                                     height: 90,
                      //                                     width: 90,
                      //                                     fit: BoxFit.fill,
                      //                                     imageUrl:
                      //                                         marketPlaceController
                      //                                             .list[index]
                      //                                             .avatar
                      //                                             .toString(),
                      //                                     placeholder:
                      //                                         (context, url) =>
                      //                                             Align(
                      //                                       child:
                      //                                           LinearProgressIndicator(),
                      //                                       alignment: Alignment
                      //                                           .topCenter,
                      //                                     ),
                      //                                     errorWidget: (context,
                      //                                             url, error) =>
                      //                                         Icon(Icons.error),
                      //                                   )),
                      //                         // Image.network(
                      //                         //     marketPlaceController
                      //                         //         .list[index].avatar.toString(),
                      //                         //     height: 90,
                      //                         //     width: 90,
                      //                         //   ),
                      //
                      //                         Positioned(
                      //                           top: Get.height / 5.5,
                      //                           left: Get.width / 10,
                      //                           child: IconButton(
                      //                             onPressed: () async {
                      //                               savedType =
                      //                                   "saved_employers";
                      //                               await marketPlaceController
                      //                                   .repository
                      //                                   .postFavourite(
                      //                                       userMap["user_info"]
                      //                                           ["id"],
                      //                                       marketPlaceController
                      //                                           .list[index].id,
                      //                                       savedType);
                      //                               setState(() {
                      //                                 marketPlaceController
                      //                                         .list[index]
                      //                                         .isFavourite =
                      //                                     !marketPlaceController
                      //                                         .list[index]
                      //                                         .isFavourite;
                      //                               });
                      //                             },
                      //                             icon: CircleAvatar(
                      //                               backgroundColor:
                      //                                   isFavColors == true
                      //                                       ? AppColors
                      //                                           .textColorRed
                      //                                       : Colors.grey,
                      //                               radius: 13,
                      //                               child: Icon(
                      //                                 Icons.favorite,
                      //                                 size: 15,
                      //                                 color: AppColors
                      //                                     .backgroundColor,
                      //                               ),
                      //                             ),
                      //                           ),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   );
                      //                 },
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                    ),
                  ),
                  Visibility(
                    visible: marketPlaceController.isLoading.value,
                    child: Align(
                      child: CupertinoActivityIndicator(),
                      alignment: Alignment.bottomCenter,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
