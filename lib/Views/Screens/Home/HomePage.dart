import 'package:new_fixera/Controller/ExportController.dart';
import 'package:new_fixera/Controller/HomeApiController.dart';
import 'package:new_fixera/Model/JobModel/JobDialogModel.dart';
import 'package:new_fixera/SharedPreferance/shared_preferance.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:new_fixera/Views/Widget/PrivatePublicDialog.dart';
import 'package:new_fixera/main.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var savedType;
  bool favResult = true;
  int? paid;
  final HomeApiController homeApiController = Get.find<HomeApiController>();
  final JobController jobController = Get.put(JobController());

  @override
  void initState() {
    // TODO: implement initState

    SharedPref.to.prefss!.getString("token");
    SharedPref.to.prefss!.getString("token_type");
    token = SharedPref.to.prefss!.getString("token");
    tokenType = SharedPref.to.prefss!.getString("token_type");

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        homeApiController.fetchHomeApi();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(seconds: 1), () {
            setState(() {
              homeApiController.fetchHomeApi();
            });
          });
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _homePageSlider(),
                SizedBox(height: Get.height / 65),
                // horizontal card for jobs by category
                // _jobsByCategories(homeApiController),

                // SizedBox(height: Get.height / 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        'Featured Contractor',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height / 150),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        'People You Can Rely on',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w200),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                //Vertical card for Featured contractor
                Container(
                  height: Get.height / 3,
                  width: Get.width,
                  child: Obx(
                    () {
                      if (homeApiController.isLoading.value)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      else {
                        if (homeApiController.homeApiList.value.results ==
                            null) {
                          return Center(
                            child: Text("No Data Found"),
                          );
                        } else {
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: homeApiController!.homeApiList!.value!
                                .results!.featuredContractors!.length,
                            itemBuilder: (context, index) {
                              favResult = homeApiController!
                                  .homeApiList!
                                  .value!
                                  .results!
                                  .featuredContractors![index]
                                  .isFavourite!;
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
                                                child: homeApiController
                                                            .homeApiList
                                                            .value
                                                            .results!
                                                            .featuredContractors![
                                                                index]
                                                            .banner ==
                                                        "0"
                                                    ? Container(
                                                        height: 60,
                                                        width: 60,
                                                        color: Colors.grey,
                                                        child: Center(
                                                          child: Image.asset(
                                                            "images/fixera_logo.png",
                                                            height: 60,
                                                            width: 120,
                                                          ),
                                                        ),
                                                      )
                                                    : Image.network(
                                                        homeApiController!
                                                            .homeApiList!
                                                            .value!
                                                            .results!
                                                            .featuredContractors![
                                                                index]
                                                            .banner!,
                                                        height: 60,
                                                      ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    height: 60.0,
                                                    width: 80.0,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        homeApiController
                                                                    .homeApiList
                                                                    .value
                                                                    .results!
                                                                    .featuredContractors![
                                                                        index]
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
                                                        width: 15.0,
                                                      ),
                                                      Container(
                                                        width: 200,
                                                        child: Text(
                                                          homeApiController!
                                                              .homeApiList!
                                                              .value!
                                                              .results!
                                                              .featuredContractors![
                                                                  index]
                                                              .name!,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: Dimension
                                                                .text_size_medium,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                        child: Text(
                                                          "Open Jobs",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue),
                                                        ),
                                                        onTap: () async {
                                                          var _id =
                                                              homeApiController
                                                                  .homeApiList
                                                                  .value
                                                                  .results!
                                                                  .featuredContractors![
                                                                      index]
                                                                  .id;
                                                          print(_id);

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
                                                        color: Colors.grey,
                                                      ),
                                                      SizedBox(
                                                        width: 15.0,
                                                      ),
                                                      GestureDetector(
                                                        child: Text(
                                                          "Full Profile",
                                                          style: TextStyle(
                                                            color: Colors.blue,
                                                          ),
                                                        ),
                                                        onTap: () async {
                                                          var _id =
                                                              homeApiController
                                                                  .homeApiList
                                                                  .value
                                                                  .results!
                                                                  .featuredContractors![
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
                                      left: Get.width / 25,
                                      child: Container(
                                        height: 60.0,
                                        width: 60.0,
                                        color: Colors.grey[200],
                                        child: homeApiController
                                                    .homeApiList
                                                    .value
                                                    .results!
                                                    .featuredContractors![index]
                                                    .avatar ==
                                                "0"
                                            ? Center(
                                                child: Text(
                                                  "255x255",
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Image.network(
                                                  homeApiController!
                                                      .homeApiList!
                                                      .value!
                                                      .results!
                                                      .featuredContractors![
                                                          index]
                                                      .avatar!,
                                                  height: 60,
                                                ),
                                              ),
                                      ),
                                    ),
                                    Positioned(
                                      top: Get.height / 7.8,
                                      left: Get.width / 18,
                                      child: IconButton(
                                        onPressed: () async {
                                          savedType = "saved_freelancer";
                                          favResult = await homeApiController
                                              .repository
                                              .postFavourite(
                                                  userMap!["user_info"]["id"],
                                                  homeApiController
                                                      .homeApiList
                                                      .value
                                                      .results!
                                                      .featuredContractors![
                                                          index]
                                                      .id,
                                                  savedType);
                                          setState(
                                            () {
                                              homeApiController
                                                      .homeApiList
                                                      .value
                                                      .results!
                                                      .featuredContractors![index]
                                                      .isFavourite =
                                                  !homeApiController!
                                                      .homeApiList!
                                                      .value!
                                                      .results!
                                                      .featuredContractors![
                                                          index]
                                                      .isFavourite!;
                                            },
                                          );
                                        },
                                        icon: CircleAvatar(
                                          backgroundColor: favResult == true
                                              ? AppColors.textColorRed
                                              : Colors.grey,
                                          radius: 10,
                                          child: Icon(
                                            Icons.favorite,
                                            size: 12,
                                            color: AppColors.backgroundColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      }
                    },
                  ),
                ),
                SizedBox(height: Get.height / 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        //'Latest Posted Jobs',
                        'Bid Now',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: Get.height / 150),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Container(
                //       child: Text(
                //         'Start Today for Better',
                //         style: TextStyle(
                //           fontSize: 15,
                //           fontWeight: FontWeight.w200,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(height: 8),
                // //Latest Posted Jobs
                Container(
                  height: 300,
                  width: Get.width,
                  child: Obx(
                    () {
                      if (homeApiController.isLoading.value)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      else {
                        if (homeApiController.homeApiList.value.results ==
                            null) {
                          return Center(
                            child: Text("No Data Found"),
                          );
                        } else {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: homeApiController
                                .homeApiList.value!.results!.latestJobs!.length,
                            itemBuilder: (context, index) {
                              favResult = homeApiController!.homeApiList!.value!
                                  .results!.latestJobs![index].isFavourite!;
                              paid = homeApiController.homeApiList.value.results!
                                  .latestJobs![index].paymentStatus;
                              return SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      // Container(
                                      //   height: 200,
                                      //   width: 250,
                                      // child: Align(
                                      //   alignment: Alignment.bottomRight,
                                      //   child: Icon(Icons.favorite),
                                      // ),),
                                      Positioned(
                                        child: SizedBox(
                                          //height: 300,
                                          width: 250,
                                          child: Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        homeApiController
                                                                    .homeApiList
                                                                    .value
                                                                    .results!
                                                                    .latestJobs![
                                                                        index]
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
                                                        width: 15.0,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          homeApiController
                                                              .homeApiList
                                                              .value
                                                              .results!
                                                              .latestJobs![index]
                                                              .employer!,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: Dimension
                                                                  .text_size_semi_medium),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          homeApiController!
                                                              .homeApiList!
                                                              .value!
                                                              .results!
                                                              .latestJobs![index]
                                                              .title!,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: Dimension
                                                                  .text_size_medium),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        FontAwesomeIcons
                                                            .dollarSign,
                                                        color: Colors.green,
                                                        size: Dimension
                                                            .icon_size_small,
                                                      ),
                                                      SizedBox(
                                                        width: 15.0,
                                                      ),
                                                      Text(
                                                        homeApiController
                                                            .homeApiList
                                                            .value
                                                            .results!
                                                            .latestJobs![index]
                                                            .price
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: Dimension
                                                                .text_size_small),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        FontAwesomeIcons.flag,
                                                        size: Dimension
                                                            .icon_size_small,
                                                      ),
                                                      SizedBox(
                                                        width: 15.0,
                                                      ),
                                                      Text(
                                                        homeApiController!
                                                            .homeApiList!
                                                            .value!
                                                            .results!
                                                            .latestJobs![index]
                                                            .location!,
                                                        style: TextStyle(
                                                            fontSize: Dimension
                                                                .text_size_small),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.copy,
                                                        color: Colors.blue,
                                                        size: Dimension
                                                            .icon_size_small,
                                                      ),
                                                      SizedBox(
                                                        width: 15.0,
                                                      ),
                                                      Text(
                                                        homeApiController!
                                                            .homeApiList!
                                                            .value!
                                                            .results!
                                                            .latestJobs![index]
                                                            .type!,
                                                        style: TextStyle(
                                                            fontSize: Dimension
                                                                .text_size_small),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .access_time_outlined,
                                                        color: Colors.red,
                                                        size: Dimension
                                                            .icon_size_small,
                                                      ),
                                                      SizedBox(
                                                        width: 15.0,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          homeApiController
                                                              .homeApiList
                                                              .value!
                                                              .results!
                                                              .latestJobs![index]
                                                              .duration!,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: Dimension
                                                                  .text_size_small),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  userMap!["user_info"]
                                                              ["role_name"] ==
                                                          "contractor"
                                                      ? GestureDetector(
                                                          // color: paid == 1
                                                          //     ? Colors.purple
                                                          //     : AppColors
                                                          //         .primaryColor,

                                                          child: Text(
                                                            "View Jobs",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          onTap: () {
                                                            if (homeApiController
                                                                    .homeApiList
                                                                    .value
                                                                    .results!
                                                                    .latestJobs![
                                                                        index]
                                                                    .paymentStatus ==
                                                                1) {
                                                              print(homeApiController
                                                                  .homeApiList
                                                                  .value
                                                                  .results!
                                                                  .latestJobs![
                                                                      index]
                                                                  .id);
                                                              String url =
                                                                  homeApiController
                                                                      .homeApiList!
                                                                      .value!
                                                                      .results!
                                                                      .latestJobs![
                                                                          index]
                                                                      .jobUrl!;
                                                              setState(() {
                                                                Get.toNamed(
                                                                    AppRoutes
                                                                        .JOBDETAILSPAGE,
                                                                    arguments: [
                                                                      "AlreadyPaid",
                                                                      url
                                                                    ]);
                                                              });
                                                            } else if (homeApiController
                                                                    .homeApiList
                                                                    .value
                                                                    .results!
                                                                    .latestJobs![
                                                                        index]
                                                                    .paymentStatus ==
                                                                0) {
                                                              var id =
                                                                  homeApiController
                                                                      .homeApiList
                                                                      .value!
                                                                      .results!
                                                                      .latestJobs![
                                                                          index]
                                                                      .id;
                                                              String slug =
                                                                  homeApiController!
                                                                      .homeApiList!
                                                                      .value!
                                                                      .results!
                                                                      .latestJobs![
                                                                          index]
                                                                      .slug!;

                                                              movetoDialog(
                                                                  id, slug);
                                                            }

                                                            //New
                                                            // String url =
                                                            //     jobController
                                                            //         .list[index]
                                                            //         .jobUrl;
                                                            // print(
                                                            //     "Check Url+++++++++++++++++++++++++++++++++" +
                                                            //         url);
                                                            // setState(() {
                                                            //   Get.toNamed(
                                                            //       AppRoutes
                                                            //           .JOBDETAILSPAGE,
                                                            //       arguments: [
                                                            //         "AlreadyPaid",
                                                            //         url
                                                            //       ]);
                                                            // });
                                                            //New
                                                          })
                                                      : Text(" "),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: Get.height / 150,
                                        left: Get.width / 102,
                                        child: homeApiController
                                                    .homeApiList
                                                    .value
                                                    .results!
                                                    .latestJobs![index]
                                                    .isFeatured ==
                                                true
                                            ? Image.asset(
                                                'images/premium.jpg',
                                                height: 22,
                                                width: 22,
                                              )
                                            : Text(''),
                                      ),
                                      // Positioned(
                                      //   top: 210,
                                      //   left: Get.width / 2 - 5,
                                      //   child: IconButton(
                                      //     onPressed: () async {
                                      //       savedType = "saved_jobs";
                                      //       // setState(() {
                                      //       //   favResult = true;
                                      //       // });
                                      //       await homeApiController.repository
                                      //           .postFavourite(
                                      //               userMap["user_info"]["id"],
                                      //               homeApiController
                                      //                   .homeApiList
                                      //                   .value
                                      //                   .results
                                      //                   .latestJobs[index]
                                      //                   .id,
                                      //               savedType);
                                      //       setState(() {
                                      //         homeApiController
                                      //                 .homeApiList
                                      //                 .value
                                      //                 .results
                                      //                 .latestJobs[index]
                                      //                 .isFavourite =
                                      //             !homeApiController
                                      //                 .homeApiList
                                      //                 .value
                                      //                 .results
                                      //                 .latestJobs[index]
                                      //                 .isFavourite;
                                      //       });
                                      //     },
                                      //     icon: CircleAvatar(
                                      //       backgroundColor: favResult == true
                                      //           ? Colors.red
                                      //           : Colors.grey,
                                      //       radius: 13,
                                      //       child: Icon(
                                      //         Icons.favorite,
                                      //         size: 15,
                                      //         color: AppColors.backgroundColor,
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      Container(
                                        height: 200,
                                        width: 268,
                                        child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: IconButton(
                                              onPressed: () async {
                                                savedType = "saved_jobs";
                                                // setState(() {
                                                //   favResult = true;
                                                // });
                                                await homeApiController
                                                    .repository
                                                    .postFavourite(
                                                        userMap!["user_info"]
                                                            ["id"],
                                                        homeApiController
                                                            .homeApiList
                                                            .value!
                                                            .results!
                                                            .latestJobs![index]
                                                            .id,
                                                        savedType);
                                                setState(() {
                                                  homeApiController
                                                          .homeApiList
                                                          .value
                                                          .results!
                                                          .latestJobs![index]
                                                          .isFavourite =
                                                      !homeApiController!
                                                          .homeApiList!
                                                          .value!
                                                          .results!
                                                          .latestJobs![index]
                                                          .isFavourite!;
                                                });
                                              },
                                              icon: CircleAvatar(
                                                backgroundColor:
                                                    favResult == true
                                                        ? Colors.red
                                                        : Colors.grey,
                                                radius: 13,
                                                child: Icon(
                                                  Icons.favorite,
                                                  size: 15,
                                                  color:
                                                      AppColors.backgroundColor,
                                                ),
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      }
                    },
                  ),
                ),
                // SizedBox(
                //   height: 20,
                // )
              ],
            ),
          ),
        ),
      ),
    );
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
    JobDialogModel jobDialogModel =
        await homeApiController.repository.postJobDialog(jobId);
    jobController.jobDialogModel.value = jobDialogModel;
    jobController.update();
  }
}

//HomePage Slider And Text
Widget _homePageSlider() {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Positioned(
        child: SizedBox(
          height: Get.height / 4,
          width: Get.width,
          child: Carousel(
            showIndicator: false,
            images: [
              ExactAssetImage("images/Fixera.png"),
              ExactAssetImage("images/Fixera.png"),
              ExactAssetImage("images/Fixera.png"),
              ExactAssetImage("images/Fixera.png"),
            ],
          ),
        ),
      ),
      // Positioned(
      //     left: Get.width / 2 - 80,
      //     child: Container(
      //         child: Image.asset(
      //       "images/FixeraIcon.png",
      //       color: Color(0xFF07AFE7),
      //     ))),
      // Positioned(
      //     bottom: 6,
      //     child: Container(
      //       child: Text(
      //         'Explore Categories',
      //         style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      //       ),
      //     )),
      // Positioned(
      //   bottom: -16,
      //   child: Container(
      //     child: Text(
      //       'Jobs by categories',
      //       style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200),
      //     ),
      //   ),
      // ),
    ],
  );
}

//HomeModule 1st Part JobByCategories
Widget _jobsByCategories(HomeApiController homeApiController) {
  return Padding(
    padding: const EdgeInsets.only(top: 16),
    child: Container(
      height: 90,
      width: Get.width,
      child: Obx(
        () {
          if (homeApiController.isLoading.value)
            return Center(
              child: CircularProgressIndicator(),
            );
          else
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:
                  homeApiController.homeApiList.value!.results!.categories!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: SizedBox(
                    width: 180,
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          homeApiController!
                              .homeApiList!.value!.results!.categories![index].name!,
                          style: TextStyle(
                              fontSize: Dimension.text_size_semi_medium),
                        ),
                      ),
                      leading: homeApiController.homeApiList.value.results!
                                  .categories![index].image ==
                              "0"
                          ? Icon(Icons.error)
                          : CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: homeApiController.homeApiList.value
                                  .results!.categories![index].image,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                    ),
                  ),
                );
              },
            );
        },
      ),
    ),
  );
}
