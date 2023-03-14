import 'package:new_fixera/Controller/ExportController.dart';
import 'package:new_fixera/Controller/HomeApiController.dart';
import 'package:new_fixera/Model/ExportModel.dart';
import 'package:new_fixera/Model/JobModel/JobDialogModel.dart';
import 'package:new_fixera/Views/Utilities/AppColors.dart';
import 'package:new_fixera/Views/Utilities/AppDimension.dart';
import 'package:new_fixera/Views/Utilities/AppRoutes.dart';
import 'package:new_fixera/Views/Widget/ExportWidget.dart';
import 'package:new_fixera/Views/Widget/PrivatePublicDialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../main.dart';

class OpenJobs extends StatefulWidget {
  @override
  _OpenJobsState createState() => _OpenJobsState();
}

class _OpenJobsState extends State<OpenJobs> {
  var savedType;
  bool? favResult;
  var id;
  int? paid;
  OpenJobsModel? _openJobsModel;
  final HomeApiController homeApiController = Get.find();
  final MarketPlaceController marketPlaceController = Get.find();
  final JobController jobController = Get.put(JobController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = Get.arguments;
    fetchOpenJobs(id);
  }

  fetchOpenJobs(var id) async {
    OpenJobsModel openJobsModel =
        await marketPlaceController.repository.postOpenJobs(id);
    setState(() {
      _openJobsModel = openJobsModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Open Jobs"),
      ),
      body: _openJobsModel != null
          ? Container(
              height: Get.height,
              child: RefreshIndicator(
                onRefresh: () {
                  return Future.delayed(Duration(seconds: 1), () async {
                    OpenJobsModel openJobsModel =
                        await marketPlaceController.repository.postOpenJobs(id);
                    setState(() {
                      _openJobsModel = openJobsModel;
                    });
                  });
                },
                child: _openJobsModel!.results!.length == 0
                    ? Container(
                        height: 20,
                        width: Get.width,
                        color: Colors.red,
                        child: Center(
                            child: Text(
                          "No Jobs Found",
                          style: TextStyle(color: Colors.black),
                        )),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: false,
                        itemCount: _openJobsModel!.results!.length,
                        itemBuilder: (context, index) {
                          favResult = _openJobsModel!.results![index].isFavourite;
                          paid = _openJobsModel!.results![index].paymentstatus;

                          return Padding(
                            padding: const EdgeInsets.only(
                              top: 1.0,
                              left: 5.0,
                              right: 5.0,
                              bottom: 0.0,
                            ),
                            child: GestureDetector(
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
                                                _openJobsModel!.results![index]
                                                            .verifyStatus ==
                                                        true
                                                    ? Icons.check_circle
                                                    : Icons
                                                        .check_circle_outline,
                                                color: Colors.green,
                                                size:
                                                    Dimension.icon_size_medium,
                                              ),
                                              SizedBox(
                                                width: 15.0,
                                              ),
                                              Text(
                                                _openJobsModel!
                                                    .results![index].employer!,
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
                                                  _openJobsModel!
                                                      .results![index].title!,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: Dimension
                                                          .text_size_medium_large),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.dollarSign,
                                                color: Colors.green,
                                                size:
                                                    Dimension.icon_size_medium,
                                              ),
                                              SizedBox(
                                                width: 15.0,
                                              ),
                                              Text(
                                                _openJobsModel!
                                                    .results![index].price
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
                                                size:
                                                    Dimension.icon_size_medium,
                                              ),
                                              SizedBox(
                                                width: 15.0,
                                              ),
                                              Text(
                                                _openJobsModel!
                                                    .results![index].location!,
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
                                                size:
                                                    Dimension.icon_size_medium,
                                              ),
                                              SizedBox(
                                                width: 15.0,
                                              ),
                                              Text(
                                                _openJobsModel!
                                                    .results![index].type!,
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
                                                size:
                                                    Dimension.icon_size_medium,
                                              ),
                                              SizedBox(
                                                width: 15.0,
                                              ),
                                              Text(
                                                _openJobsModel!
                                                    .results![index].duration!,
                                                style: TextStyle(
                                                    fontSize: Dimension
                                                        .text_size_medium_large),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          userMap!["user_info"]["role_name"] ==
                                                  "contractor"
                                              ? GestureDetector(

                                                  child: Text(
                                                    "View Jobs",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.white),
                                                  ),
                                                  onTap: () {
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

                                                    if (_openJobsModel!
                                                            .results![index]
                                                            .paymentstatus ==
                                                        1) {
                                                      String url =
                                                          _openJobsModel!
                                                              .results![index]
                                                              .jobUrl!;
                                                      setState(
                                                        () {
                                                          Get.toNamed(
                                                              AppRoutes
                                                                  .JOBDETAILSPAGE,
                                                              arguments: [
                                                                "AlreadyPaid",
                                                                url
                                                              ]);
                                                        },
                                                      );
                                                    } else if (_openJobsModel!
                                                            .results![index]
                                                            .paymentstatus ==
                                                        0) {
                                                      var id = _openJobsModel!
                                                          .results![index].id;
                                                      String slug =
                                                          _openJobsModel!
                                                              .results![index]
                                                              .slug!;

                                                      movetoDialog(id, slug);
                                                    }
                                                  })
                                              : Text(" ")
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: Get.height / 150,
                                    left: Get.width / 102,
                                    child: _openJobsModel!
                                                .results![index].isFeatured ==
                                            true
                                        ? Image.asset(
                                            'images/premium.jpg',
                                            height: 22,
                                            width: 22,
                                          )
                                        : Text(''),
                                  ),
                                  Positioned(
                                    top: Get.height / 10,
                                    left: Get.width / 1.1 - 8,
                                    child: IconButton(
                                      onPressed: () async {
                                        savedType = "saved_jobs";
                                        await homeApiController.repository
                                            .postFavourite(
                                                userMap!["user_info"]["id"],
                                                _openJobsModel!
                                                    .results![index].id,
                                                savedType);
                                        setState(
                                          () {
                                            _openJobsModel!.results![index]
                                                    .isFavourite =
                                                !_openJobsModel!
                                                    .results![index].isFavourite!;
                                          },
                                        );
                                      },
                                      icon: CircleAvatar(
                                        backgroundColor: favResult == true
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
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            )
          : Align(
              child: LinearProgressIndicator(),
              alignment: Alignment.topCenter,
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
      },
    );
    JobDialogModel jobDialogModel =
        await homeApiController.repository.postJobDialog(jobId);
    jobController.jobDialogModel.value = jobDialogModel;
    jobController.update();
  }
}
