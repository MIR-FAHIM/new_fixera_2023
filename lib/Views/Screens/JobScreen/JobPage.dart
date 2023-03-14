import 'package:new_fixera/Controller/JobController.dart';
import 'package:new_fixera/Model/JobModel/JobDialogModel.dart';
import 'package:new_fixera/Views/Widget/ExportWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/Repositories/repository.dart';
import 'package:new_fixera/Views/Utilities/AppColors.dart';
import 'package:new_fixera/Views/Utilities/AppDimension.dart';
import 'package:new_fixera/Views/Utilities/AppRoutes.dart';
import 'package:new_fixera/Views/Widget/PrivatePublicDialog.dart';
import 'package:new_fixera/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class JobPage extends StatefulWidget {
  @override
  _JobPageState createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  var savedType;
  bool isFavColors = true;
  int? paid;
  bool dataFetch = true;

  final JobController jobController = Get.put(JobController());

  final MyRepository myRepository =
      MyRepository(apiClient: MyApiClient(httpClient: Client()));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          return Container(
            height: Get.height,
            child: RefreshIndicator(
              onRefresh: () {
                return Future.delayed(Duration(seconds: 1), () {
                  var page = 0.obs;
                  setState(() {
                    jobController.page.value = 1;
                    jobController.list.clear();
                    jobController.fetchJob(page);
                  });
                });
              },
              child: Column(
                children: [
                  Expanded(
                    child: jobController.list.length == 0
                        ? Container()
                        : ListView.builder(
                            controller: jobController.scrollController,
                            addAutomaticKeepAlives: true,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: false,
                            itemCount: jobController.list.length,
                            // jobController.list[index].results.jobs.data.length,

                            itemBuilder: (context, index) {
                              isFavColors =
                                  jobController.list[index].isFavourite;
                              paid = jobController.list[index].paymentStatus;
                              // print("This is Templist");
                              // print(jobController.list);
                              return InkWell(
                                onTap: () {
                                  //  Get.toNamed(AppRoutes.SENDPROPOSAL);
                                },
                                child: Padding(
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
                                        child: Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    jobController.list[index]
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
                                                  Text(
                                                    jobController
                                                        .list[index].employer,
                                                    style: TextStyle(
                                                        fontSize: Dimension
                                                            .text_size_semi_medium),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      jobController
                                                          .list[index].title,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: Dimension
                                                              .text_size_large),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    FontAwesomeIcons.dollarSign,
                                                    color: Colors.green,
                                                    size: Dimension
                                                        .icon_size_medium,
                                                  ),
                                                  SizedBox(
                                                    width: 15.0,
                                                  ),
                                                  Text(
                                                    jobController
                                                        .list[index].price
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: Dimension
                                                            .text_size_medium_large),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    FontAwesomeIcons.flag,
                                                    size: Dimension
                                                        .icon_size_medium,
                                                  ),
                                                  SizedBox(
                                                    width: 15.0,
                                                  ),
                                                  Text(
                                                    jobController
                                                        .list[index].location,
                                                    style: TextStyle(
                                                        fontSize: Dimension
                                                            .text_size_medium_large),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.copy,
                                                    color: Colors.blue,
                                                    size: Dimension
                                                        .icon_size_medium,
                                                  ),
                                                  SizedBox(
                                                    width: 15.0,
                                                  ),
                                                  Text(
                                                    jobController
                                                        .list[index].type,
                                                    style: TextStyle(
                                                        fontSize: Dimension
                                                            .text_size_medium_large),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.access_time_outlined,
                                                    color: Colors.red,
                                                    size: Dimension
                                                        .icon_size_medium,
                                                  ),
                                                  SizedBox(
                                                    width: 15.0,
                                                  ),
                                                  Text(
                                                    jobController
                                                        .list[index].duration,
                                                    style: TextStyle(
                                                        fontSize: Dimension
                                                            .text_size_medium_large),
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
                                                                FontWeight.w700,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      onTap: () {
                                                        if (jobController
                                                                .list[index]
                                                                .paymentStatus ==
                                                            1) {
                                                          String url =
                                                              jobController
                                                                  .list[index]
                                                                  .jobUrl;
                                                          print("Check Url" +
                                                              url);
                                                          setState(() {
                                                            Get.toNamed(
                                                                AppRoutes
                                                                    .JOBDETAILSPAGE,
                                                                arguments: [
                                                                  "AlreadyPaid",
                                                                  url
                                                                ]);
                                                          });
                                                        } else if (jobController
                                                                .list[index]
                                                                .paymentStatus ==
                                                            0) {
                                                          var id = jobController
                                                              .list[index].id;
                                                          // String slug =
                                                          //     jobController
                                                          //         .list[index]
                                                          //         .slug;
                                                          String slug =
                                                              jobController
                                                                  .list[index]
                                                                  .slug;

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
                                                      },
                                                    )
                                                  : Text(" ")
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: Get.height / 150,
                                        left: Get.width / 102,
                                        child: jobController
                                                    .list[index].isFeatured ==
                                                true
                                            ? Image.asset(
                                                'images/premium.jpg',
                                                height: 22,
                                                width: 22,
                                              )
                                            : Text(""),
                                      ),
                                      Positioned(
                                        top: Get.height / 10,
                                        left: Get.width / 1.1 - 8,
                                        child: IconButton(
                                          onPressed: () async {
                                            savedType = "saved_jobs";
                                            await jobController.repository
                                                .postFavourite(
                                                    userMap!["user_info"]["id"],
                                                    jobController
                                                        .list[index].id,
                                                    savedType);
                                            setState(() {
                                              jobController
                                                      .list[index].isFavourite =
                                                  !jobController
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
                                  ),
                                ),
                              );
                            }),
                  ),
                  Visibility(
                    visible: jobController.isLoading.value,
                    child: Align(
                      child: CupertinoActivityIndicator(),
                      alignment: Alignment.bottomCenter,
                    ),
                  )
                ],
              ),
            ),
          );
        }),
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
    JobDialogModel jobDialogModel = await myRepository.postJobDialog(jobId);
    jobController.jobDialogModel.value = jobDialogModel;
    jobController.update();
  }
}
