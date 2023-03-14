import 'package:new_fixera/Controller/ExportController.dart';
import 'package:new_fixera/Model/JobModel/JobDialogModel.dart';
import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/Repositories/repository.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:new_fixera/Controller/FovaouriteGetController.dart';
import 'package:new_fixera/Views/Widget/NormalAppBar.dart';
import 'package:new_fixera/Views/Widget/PrivatePublicDialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../../main.dart';

class Favourite extends StatefulWidget {
  Favourite({Key? key}) : super(key: key);

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  int? grpVal = 0;
  int? paid;

  grpValFunc(value) {
    setState(() {
      grpVal = value;
    });
  }

  final FavouriteGetController favouritegetController =
      Get.put(FavouriteGetController());
  final ContractorController contractorController =
      Get.put(ContractorController());
  final MarketPlaceController marketPlaceController =
      Get.put(MarketPlaceController());
  final JobController jobController = Get.put(JobController());

  final MyRepository myRepository =
      MyRepository(apiClient: MyApiClient(httpClient: Client()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Saved Items"),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Radio(value: 0, groupValue: grpVal, onChanged: grpValFunc),
                  Text(
                    "Contractor",
                    style: TextStyle(
                      fontSize: Dimension.text_size_Semi_small,
                    ),
                  ),
                  Radio(
                    value: 1,
                    groupValue: grpVal,
                    onChanged: grpValFunc,
                  ),
                  Text(
                    userMap!["user_info"]["role_name"] == "contractor"
                        ? "Browse Projects"
                        : "Browse Leads",
                    style: TextStyle(
                      fontSize: Dimension.text_size_Semi_small,
                    ),
                  ),
                  Radio(
                    value: 2,
                    groupValue: grpVal,
                    onChanged: grpValFunc,
                  ),
                  Text(
                    "MarketPlaces",
                    style: TextStyle(
                      fontSize: Dimension.text_size_Semi_small,
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            // grpVal == 0
            //     ? Container(
            //         height: Get.height,
            //         child: Obx(() {
            //           if (favouritegetController.isLoading.value)
            //             return Align(
            //                 alignment: Alignment.topCenter,
            //                 child: LinearProgressIndicator(
            //                   minHeight: 2,
            //                 ));
            //           else
            //             return ListView.builder(
            //                 scrollDirection: Axis.vertical,
            //                 itemCount: favouritegetController.favouriteList
            //                     .value.results.savedFreelancers.length,
            //                 itemBuilder: (context, index) {
            //                   return Padding(
            //                       padding: const EdgeInsets.symmetric(
            //                           horizontal: 10),
            //                       child: Stack(
            //                         clipBehavior: Clip.none,
            //                         children: [
            //                           Positioned(
            //                             child: GestureDetector(
            //                               onTap: () {
            //                                 var id = favouritegetController
            //                                     .favouriteList
            //                                     .value
            //                                     .results
            //                                     .savedFreelancers[index]
            //                                     .id;
            //                                 setState(() {
            //                                   Get.toNamed(
            //                                       AppRoutes
            //                                           .CONTRACTORDETAILSPAGE,
            //                                       arguments: id);
            //                                 });
            //                               },
            //                               child: Card(
            //                                 color: Colors.white,
            //                                 child: SizedBox(
            //                                   height: 80,
            //                                   child: ListTile(
            //                                     title: Row(
            //                                       crossAxisAlignment:
            //                                           CrossAxisAlignment
            //                                               .baseline,
            //                                       textBaseline:
            //                                           TextBaseline.alphabetic,
            //                                       children: [
            //                                         Icon(
            //                                           favouritegetController
            //                                                       .favouriteList
            //                                                       .value
            //                                                       .results
            //                                                       .savedFreelancers[
            //                                                           index]
            //                                                       .verifyStatus ==
            //                                                   true
            //                                               ? Icons.check_circle
            //                                               : Icons
            //                                                   .check_circle_outline,
            //                                           color: Colors.green,
            //                                           size: Dimension
            //                                               .icon_size_medium,
            //                                         ),
            //                                         SizedBox(
            //                                           width: 10,
            //                                         ),
            //                                         Text(
            //                                           favouritegetController
            //                                                       .favouriteList
            //                                                       .value
            //                                                       .results
            //                                                       .savedFreelancers[
            //                                                           index]
            //                                                       .name
            //                                                       .toString()
            //                                                       .length >
            //                                                   12
            //                                               ? favouritegetController
            //                                                       .favouriteList
            //                                                       .value
            //                                                       .results
            //                                                       .savedFreelancers[
            //                                                           index]
            //                                                       .name
            //                                                       .substring(
            //                                                           0, 12) +
            //                                                   "..."
            //                                               : favouritegetController
            //                                                   .favouriteList
            //                                                   .value
            //                                                   .results
            //                                                   .savedFreelancers[
            //                                                       index]
            //                                                   .name,
            //                                           style: TextStyle(
            //                                               fontSize: 16),
            //                                         ),
            //                                       ],
            //                                     ),
            //                                     subtitle: Column(
            //                                       crossAxisAlignment:
            //                                           CrossAxisAlignment.start,
            //                                       children: [
            //                                         Text(
            //                                           favouritegetController
            //                                               .favouriteList
            //                                               .value
            //                                               .results
            //                                               .savedFreelancers[
            //                                                   index]
            //                                               .tagline,
            //                                           overflow:
            //                                               TextOverflow.ellipsis,
            //                                           style: TextStyle(
            //                                               fontSize: 16,
            //                                               color: Colors.black),
            //                                         ),
            //                                         Text(
            //                                           "\$ " +
            //                                               "${favouritegetController.favouriteList.value.results.savedFreelancers[index].hourlyRate}" +
            //                                               " |",
            //                                           style: TextStyle(
            //                                             fontSize: 14,
            //                                           ),
            //                                         ),
            //                                       ],
            //                                     ),
            //                                     leading: Container(
            //                                       height: 120,
            //                                       width: 60,
            //                                       child: favouritegetController
            //                                                   .favouriteList
            //                                                   .value
            //                                                   .results
            //                                                   .savedFreelancers[
            //                                                       index]
            //                                                   .avatar ==
            //                                               "0"
            //                                           ? Container(
            //                                               color: Colors.grey,
            //                                               child: Center(
            //                                                 child: Text(
            //                                                   '255x255',
            //                                                   style: TextStyle(
            //                                                       fontSize: 8),
            //                                                 ),
            //                                               ),
            //                                             )
            //                                           : Image.network(
            //                                               favouritegetController
            //                                                   .favouriteList
            //                                                   .value
            //                                                   .results
            //                                                   .savedFreelancers[
            //                                                       index]
            //                                                   .avatar
            //                                                   .toString()),
            //                                     ),
            //                                   ),
            //                                 ),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ));
            //                 });
            //         }),
            //       )
            //     : grpVal == 1
            //         ? Container(
            //             height: Get.height / 1.3,
            //             child: Obx(() {
            //               if (favouritegetController.isLoading.value)
            //                 return Align(
            //                     alignment: Alignment.topCenter,
            //                     child: LinearProgressIndicator(
            //                       minHeight: 2,
            //                     ));
            //               return Container(
            //                 height: Get.height,
            //                 child: ListView.builder(
            //                     scrollDirection: Axis.vertical,
            //                     shrinkWrap: false,
            //                     itemCount: favouritegetController
            //                         .favouriteList.value.results.jobs.length,
            //                     itemBuilder: (context, index) {
            //                       paid = favouritegetController.favouriteList
            //                           .value.results.jobs[index].paymentStatus;
            //                       return Padding(
            //                         padding: const EdgeInsets.only(
            //                           top: 1.0,
            //                           left: 5.0,
            //                           right: 5.0,
            //                           bottom: 0.0,
            //                         ),
            //                         child: GestureDetector(
            //                           child: Stack(
            //                             clipBehavior: Clip.none,
            //                             children: [
            //                               Card(
            //                                 child: Padding(
            //                                   padding:
            //                                       const EdgeInsets.all(18.0),
            //                                   child: Column(
            //                                     children: [
            //                                       Row(
            //                                         children: [
            //                                           Icon(
            //                                             favouritegetController
            //                                                         .favouriteList
            //                                                         .value
            //                                                         .results
            //                                                         .jobs[index]
            //                                                         .verifyStatus ==
            //                                                     true
            //                                                 ? Icons.check_circle
            //                                                 : Icons
            //                                                     .check_circle_outline,
            //                                             color: Colors.green,
            //                                             size: Dimension
            //                                                 .icon_size_medium,
            //                                           ),
            //                                           SizedBox(
            //                                             width: 15.0,
            //                                           ),
            //                                           Text(
            //                                             favouritegetController
            //                                                 .favouriteList
            //                                                 .value
            //                                                 .results
            //                                                 .jobs[index]
            //                                                 .employer,
            //                                             style: TextStyle(
            //                                                 fontSize: Dimension
            //                                                     .text_size_medium),
            //                                           ),
            //                                         ],
            //                                       ),
            //                                       Row(
            //                                         children: [
            //                                           Text(
            //                                             favouritegetController
            //                                                 .favouriteList
            //                                                 .value
            //                                                 .results
            //                                                 .jobs[index]
            //                                                 .title,
            //                                             style: TextStyle(
            //                                                 fontSize: Dimension
            //                                                     .text_size_semi_medium),
            //                                           ),
            //                                         ],
            //                                       ),
            //                                       Row(
            //                                         children: [
            //                                           Icon(
            //                                             FontAwesomeIcons
            //                                                 .dollarSign,
            //                                             color: Colors.green,
            //                                             size: Dimension
            //                                                 .icon_size_medium,
            //                                           ),
            //                                           SizedBox(
            //                                             width: 15.0,
            //                                           ),
            //                                           Text(
            //                                             favouritegetController
            //                                                 .favouriteList
            //                                                 .value
            //                                                 .results
            //                                                 .jobs[index]
            //                                                 .price
            //                                                 .toString(),
            //                                             style: TextStyle(
            //                                                 fontSize: Dimension
            //                                                     .text_size_medium_large),
            //                                           ),
            //                                         ],
            //                                       ),
            //                                       Row(
            //                                         children: [
            //                                           Icon(
            //                                             FontAwesomeIcons.flag,
            //                                             size: Dimension
            //                                                 .icon_size_medium,
            //                                           ),
            //                                           SizedBox(
            //                                             width: 15.0,
            //                                           ),
            //                                           Text(
            //                                             favouritegetController
            //                                                 .favouriteList
            //                                                 .value
            //                                                 .results
            //                                                 .jobs[index]
            //                                                 .location,
            //                                             style: TextStyle(
            //                                                 fontSize: Dimension
            //                                                     .text_size_medium_large),
            //                                           ),
            //                                         ],
            //                                       ),
            //                                       Row(
            //                                         children: [
            //                                           Icon(
            //                                             Icons.copy,
            //                                             color: Colors.blue,
            //                                             size: Dimension
            //                                                 .icon_size_medium,
            //                                           ),
            //                                           SizedBox(
            //                                             width: 15.0,
            //                                           ),
            //                                           Text(
            //                                             favouritegetController
            //                                                 .favouriteList
            //                                                 .value
            //                                                 .results
            //                                                 .jobs[index]
            //                                                 .type,
            //                                             style: TextStyle(
            //                                                 fontSize: Dimension
            //                                                     .text_size_medium_large),
            //                                           ),
            //                                         ],
            //                                       ),
            //                                       Row(
            //                                         children: [
            //                                           Icon(
            //                                             Icons
            //                                                 .access_time_outlined,
            //                                             color: Colors.red,
            //                                             size: Dimension
            //                                                 .icon_size_medium,
            //                                           ),
            //                                           SizedBox(
            //                                             width: 15.0,
            //                                           ),
            //                                           Text(
            //                                             favouritegetController
            //                                                 .favouriteList
            //                                                 .value
            //                                                 .results
            //                                                 .jobs[index]
            //                                                 .duration,
            //                                             style: TextStyle(
            //                                                 fontSize: Dimension
            //                                                     .text_size_medium_large),
            //                                           ),
            //                                         ],
            //                                       ),
            //                                       userMap["user_info"]
            //                                                   ["role_name"] ==
            //                                               "contractor"
            //                                           ? GestureDetector(
            //
            //                                               child: Text(
            //                                                 "View Jobs",
            //                                                 style: TextStyle(
            //                                                     fontWeight:
            //                                                         FontWeight
            //                                                             .w700,
            //                                                     color: Colors
            //                                                         .white),
            //                                               ),
            //                                               onTap: () {
            //                                                 //New
            //                                                 //     String url =
            //                                                 //         favouritegetController
            //                                                 //             .favouriteList
            //                                                 //             .value
            //                                                 //             .results
            //                                                 //             .jobs[
            //                                                 //         index]
            //                                                 //             .jobUrl;
            //                                                 //     setState(() {
            //                                                 //       Get.toNamed(
            //                                                 //           AppRoutes
            //                                                 //               .JOBDETAILSPAGE,
            //                                                 //           arguments: [
            //                                                 //             "AlreadyPaid",
            //                                                 //             url
            //                                                 //           ]);
            //                                                 //     });
            //                                                 //New
            //
            //                                                 if (favouritegetController
            //                                                         .favouriteList
            //                                                         .value
            //                                                         .results
            //                                                         .jobs[index]
            //                                                         .paymentStatus ==
            //                                                     1) {
            //                                                   String url =
            //                                                       favouritegetController
            //                                                           .favouriteList
            //                                                           .value
            //                                                           .results
            //                                                           .jobs[
            //                                                               index]
            //                                                           .jobUrl;
            //                                                   setState(() {
            //                                                     Get.toNamed(
            //                                                         AppRoutes
            //                                                             .JOBDETAILSPAGE,
            //                                                         arguments: [
            //                                                           "AlreadyPaid",
            //                                                           url
            //                                                         ]);
            //                                                   });
            //                                                 } else if (favouritegetController
            //                                                         .favouriteList
            //                                                         .value
            //                                                         .results
            //                                                         .jobs[index]
            //                                                         .paymentStatus ==
            //                                                     0) {
            //                                                   var id =
            //                                                       favouritegetController
            //                                                           .favouriteList
            //                                                           .value
            //                                                           .results
            //                                                           .jobs[
            //                                                               index]
            //                                                           .id;
            //                                                   String slug =
            //                                                       favouritegetController
            //                                                           .favouriteList
            //                                                           .value
            //                                                           .results
            //                                                           .jobs[
            //                                                               index]
            //                                                           .slug;
            //
            //                                                   movetoDialog(
            //                                                       id, slug);
            //                                                 }
            //                                               })
            //                                           : Text(" ")
            //                                     ],
            //                                   ),
            //                                 ),
            //                               ),
            //                               Positioned(
            //                                 top: Get.height / 150,
            //                                 left: Get.width / 102,
            //                                 child: Image.asset(
            //                                   'images/premium.jpg',
            //                                   height: 22,
            //                                   width: 22,
            //                                 ),
            //                               ),
            //                             ],
            //                           ),
            //                           onTap: () {
            //                             // Get.toNamed(AppRoutes.JOBDETAILSPAGE);
            //                           },
            //                         ),
            //                       );
            //                     }),
            //               );
            //             }),
            //           )
            //         : grpVal == 2
            //             ? Container(
            //                 height: Get.height / 1.3,
            //                 child: Obx(() {
            //                   if (favouritegetController.isLoading.value)
            //                     return Align(
            //                         alignment: Alignment.topCenter,
            //                         child: LinearProgressIndicator(
            //                           minHeight: 2,
            //                         ));
            //                   else
            //                     return ListView.builder(
            //                         itemCount: favouritegetController
            //                             .favouriteList
            //                             .value
            //                             .results
            //                             .savedEmployers
            //                             .length,
            //                         itemBuilder: (context, index) {
            //                           return Padding(
            //                             padding: const EdgeInsets.only(
            //                               top: 1.0,
            //                               left: 5.0,
            //                               right: 5.0,
            //                               bottom: 0.0,
            //                             ),
            //                             child: Stack(
            //                               clipBehavior: Clip.none,
            //                               children: [
            //                                 Card(
            //                                   child: Column(
            //                                     crossAxisAlignment:
            //                                         CrossAxisAlignment.start,
            //                                     children: [
            //                                       Row(
            //                                         children: [
            //                                           Expanded(
            //                                             child: Container(
            //                                               color: Colors.grey,
            //                                               height: 90.0,
            //                                               // width: Get.width / 1.1,
            //                                               child: favouritegetController
            //                                                           .favouriteList
            //                                                           .value
            //                                                           .results
            //                                                           .savedEmployers[
            //                                                               index]
            //                                                           .banner ==
            //                                                       '0'
            //                                                   ? Center(
            //                                                       child: Text(
            //                                                           "1920x500"),
            //                                                     )
            //                                                   : CachedNetworkImage(
            //                                                       fit: BoxFit
            //                                                           .fill,
            //                                                       height: 90,
            //                                                       imageUrl: favouritegetController
            //                                                           .favouriteList
            //                                                           .value
            //                                                           .results
            //                                                           .savedEmployers[
            //                                                               index]
            //                                                           .banner
            //                                                           .toString(),
            //                                                       placeholder:
            //                                                           (context,
            //                                                                   url) =>
            //                                                               Align(),
            //                                                       errorWidget: (context,
            //                                                               url,
            //                                                               error) =>
            //                                                           Icon(Icons
            //                                                               .error),
            //                                                     ),
            //
            //                                               //  Image.network(favouritegetController
            //                                               //     .favouriteList
            //                                               //     .value
            //                                               //     .results
            //                                               //     .savedEmployers[
            //                                               //         index]
            //                                               //     .banner)
            //                                             ),
            //                                           ),
            //                                         ],
            //                                       ),
            //                                       Row(
            //                                         children: [
            //                                           Column(
            //                                             children: [
            //                                               Container(
            //                                                 height: 100.0,
            //                                                 width: 100.0,
            //                                                 color: Colors.white,
            //                                               ),
            //                                             ],
            //                                           ),
            //                                           Column(
            //                                             crossAxisAlignment:
            //                                                 CrossAxisAlignment
            //                                                     .start,
            //                                             children: [
            //                                               Row(
            //                                                 children: [
            //                                                   Icon(
            //                                                     favouritegetController
            //                                                                 .favouriteList
            //                                                                 .value
            //                                                                 .results
            //                                                                 .savedEmployers[
            //                                                                     index]
            //                                                                 .verifyStatus ==
            //                                                             true
            //                                                         ? Icons
            //                                                             .check_circle
            //                                                         : Icons
            //                                                             .check_circle_outline,
            //                                                     color: Colors
            //                                                         .green,
            //                                                     size: Dimension
            //                                                         .icon_size_medium,
            //                                                   ),
            //                                                   SizedBox(
            //                                                     width: 15.0,
            //                                                   ),
            //                                                   Container(
            //                                                     width: 200,
            //                                                     child: Text(
            //                                                       favouritegetController
            //                                                           .favouriteList
            //                                                           .value
            //                                                           .results
            //                                                           .savedEmployers[
            //                                                               index]
            //                                                           .name,
            //                                                       overflow:
            //                                                           TextOverflow
            //                                                               .ellipsis,
            //                                                       style:
            //                                                           TextStyle(
            //                                                         fontSize:
            //                                                             Dimension
            //                                                                 .text_size_medium,
            //                                                       ),
            //                                                     ),
            //                                                   ),
            //                                                 ],
            //                                               ),
            //                                               SizedBox(
            //                                                 height: 20.0,
            //                                               ),
            //                                               Row(
            //                                                 children: [
            //                                                   GestureDetector(
            //                                                     child: Text(
            //                                                       "Open Jobs",
            //                                                       style: TextStyle(
            //                                                           color: Colors
            //                                                               .blue),
            //                                                     ),
            //                                                     onTap: () {
            //                                                       setState(() {
            //                                                         var _id = favouritegetController
            //                                                             .favouriteList
            //                                                             .value
            //                                                             .results
            //                                                             .savedEmployers[
            //                                                                 index]
            //                                                             .id;
            //                                                         Get.toNamed(
            //                                                             AppRoutes
            //                                                                 .OPENJOB,
            //                                                             arguments:
            //                                                                 _id);
            //                                                       });
            //                                                     },
            //                                                   ),
            //                                                   SizedBox(
            //                                                     width: 15.0,
            //                                                   ),
            //                                                   Container(
            //                                                     width: 1,
            //                                                     height: 20.0,
            //                                                     color:
            //                                                         Colors.grey,
            //                                                   ),
            //                                                   SizedBox(
            //                                                     width: 15.0,
            //                                                   ),
            //                                                   GestureDetector(
            //                                                     child: Text(
            //                                                       "Full Profile",
            //                                                       style:
            //                                                           TextStyle(
            //                                                         color: Colors
            //                                                             .blue,
            //                                                       ),
            //                                                     ),
            //                                                     onTap: () {
            //                                                       setState(() {
            //                                                         var _id = favouritegetController
            //                                                             .favouriteList
            //                                                             .value
            //                                                             .results
            //                                                             .savedEmployers[
            //                                                                 index]
            //                                                             .id;
            //                                                         Get.toNamed(
            //                                                             AppRoutes
            //                                                                 .FULLPROFILEPAGE,
            //                                                             arguments:
            //                                                                 _id);
            //                                                       });
            //                                                     },
            //                                                   ),
            //                                                 ],
            //                                               ),
            //                                             ],
            //                                           ),
            //                                         ],
            //                                       ),
            //                                       SizedBox(
            //                                         height: 5.0,
            //                                       ),
            //                                     ],
            //                                   ),
            //                                 ),
            //                                 Positioned(
            //                                   top: Get.height / 20,
            //                                   left: Get.width / 20,
            //                                   child: Container(
            //                                     height: 90.0,
            //                                     width: 90.0,
            //                                     color: Colors.grey[200],
            //                                     child: favouritegetController
            //                                                 .favouriteList
            //                                                 .value
            //                                                 .results
            //                                                 .savedEmployers[
            //                                                     index]
            //                                                 .avatar ==
            //                                             '0'
            //                                         ? Center(
            //                                             child: Text("255x255"),
            //                                           )
            //                                         : CachedNetworkImage(
            //                                             fit: BoxFit.fill,
            //                                             height: 90,
            //                                             imageUrl:
            //                                                 favouritegetController
            //                                                     .favouriteList
            //                                                     .value
            //                                                     .results
            //                                                     .savedEmployers[
            //                                                         index]
            //                                                     .avatar
            //                                                     .toString(),
            //                                             placeholder:
            //                                                 (context, url) =>
            //                                                     Align(),
            //                                             errorWidget: (context,
            //                                                     url, error) =>
            //                                                 Icon(Icons.error),
            //                                           ),
            //
            //                                     // Image.network(
            //                                     //     favouritegetController
            //                                     //         .favouriteList
            //                                     //         .value
            //                                     //         .results
            //                                     //         .savedEmployers[
            //                                     //             index]
            //                                     //         .avatar)
            //                                   ),
            //                                 ),
            //                               ],
            //                             ),
            //                           );
            //                         });
            //                 }),
            //               )
            //             : null
          ],
        )));
  }

  void movetoDialog(var jobId, String slug) async {
    showDialog(
        context: context,
        builder: (_) {
          return MyDialog(
            slug: slug,
            jobId: jobId,
          );
        });
    JobDialogModel jobDialogModel = await myRepository.postJobDialog(jobId);
    jobController.jobDialogModel.value = jobDialogModel;
    jobController.update();
  }
}
