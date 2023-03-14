import 'package:new_fixera/Controller/ExportController.dart';
import 'package:new_fixera/Model/JobModel/JobDialogModel.dart';
import 'package:new_fixera/Model/MarketPageModel/FullProfileModel.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:new_fixera/Views/Widget/ExportWidget.dart';
import 'package:new_fixera/Views/Widget/PrivatePublicDialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../main.dart';

class FullProfilePage extends StatefulWidget {
  FullProfilePage({Key? key}) : super(key: key);

  @override
  _FullProfilePageState createState() => _FullProfilePageState();
}

class _FullProfilePageState extends State<FullProfilePage> {
  var savedType;
  bool? favResult;
  FullProfileModel? _fullProfileModel;
  var id;
  int? paid;
  final HomeApiController homeApiController = Get.find();
  final MarketPlaceController marketPlaceController = Get.find();
  final JobController jobController = Get.put(JobController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = Get.arguments;
    fetchFullProfile(id);
  }

  fetchFullProfile(var id) async {
    print(id);
    FullProfileModel fullProfileModel =
        await marketPlaceController.repository.postFullProfile(id);
    setState(() {
      _fullProfileModel = fullProfileModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("********" + id.toString() + "**********");
    return Scaffold(
      appBar: AppBar(
        title: Text("Full Profile"),
      ),
      body: _fullProfileModel != null
          ? Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          child: SizedBox(
                            width: Get.width,
                            child: _fullProfileModel!.results!.banner == "0"
                                ? Center(
                                    child: Container(
                                      height: 220,
                                      width: Get.width,
                                      color: Colors.grey,
                                      child: Center(
                                        child: Image.asset(
                                          "images/fixera_logo.png",
                                          height: 60,
                                          width: 120,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 220,
                                    width: Get.width,
                                    child: Image.network(
                                      _fullProfileModel!.results!.banner!,
                                    ),
                                  ),
                          ),
                        ),
                        Positioned(
                          top: 180,
                          left: 20,
                          right: 20,
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Card(
                                  elevation: 0,
                                  color: Colors.white,
                                  child: SizedBox(
                                    height: 100,
                                    child: ListTile(
                                      title: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            _fullProfileModel!
                                                        .results!.verifyStatus ==
                                                    true
                                                ? Icons.check_circle
                                                : Icons.check_circle_outline,
                                            color: Colors.green,
                                            size: Dimension.icon_size_medium,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(
                                              _fullProfileModel!.results!.name!,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: Dimension
                                                      .text_size_semi_medium),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              savedType = "saved_employers";
                                              await homeApiController.repository
                                                  .postFavourite(
                                                      userMap!["user_info"]
                                                          ["id"],
                                                      _fullProfileModel!
                                                          .results!.id!,
                                                      savedType);
                                              setState(
                                                () {
                                                  _fullProfileModel!
                                                          .results!.isFavourite =
                                                      !_fullProfileModel!
                                                          .results!.isFavourite!;
                                                },
                                              );
                                            },
                                            child: CircleAvatar(
                                              radius: 13,
                                              backgroundColor: _fullProfileModel!
                                                          .results!
                                                          .isFavourite ==
                                                      true
                                                  ? Colors.red
                                                  : Colors.grey,
                                              child: Icon(
                                                Icons.favorite_outlined,
                                                size: 15,
                                                color:
                                                    AppColors.backgroundColor,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      subtitle: Text(
                                        _fullProfileModel!.results!.role!,
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.black),
                                      ),
                                      leading: _fullProfileModel!
                                                  .results!.avatar ==
                                              "0"
                                          ? Container(
                                              color: Colors.grey,
                                              height: 60,
                                              width: 60,
                                              child: Center(
                                                child: Text(
                                                  '255x255',
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              height: 60,
                                              width: 60,
                                              child: Image.network(
                                                  _fullProfileModel!
                                                      .results!.avatar!),
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              'About',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 160,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                _fullProfileModel!.results!.about!,
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Container(
                      height: 400,
                      width: Get.width / 1.1,
                      child: _fullProfileModel != null
                          ? Container(
                              height: Get.height,
                              child: RefreshIndicator(
                                onRefresh: () {
                                  return Future.delayed(
                                    Duration(seconds: 1),
                                    () async {
                                      fetchFullProfile(id);
                                    },
                                  );
                                },
                                child: _fullProfileModel!.results!.jobs!.length ==
                                        0
                                    ? Container(
                                        height: 20,
                                        width: Get.width,
                                        color: Colors.transparent,
                                        child: Center(
                                            child: Text(
                                          "No Jobs Found",
                                          style: TextStyle(color: Colors.black),
                                        )),
                                      )
                                    : ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: false,
                                        itemCount: _fullProfileModel!
                                            .results!.jobs!.length,
                                        itemBuilder: (context, index) {
                                          favResult = _fullProfileModel!
                                              .results!.jobs![index].isFavourite;
                                          paid = _fullProfileModel!.results!
                                              .jobs![index].paymentstatus;
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
                                                      padding:
                                                          const EdgeInsets.all(
                                                              18.0),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                _fullProfileModel!
                                                                            .results!
                                                                            .jobs![
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
                                                              Expanded(
                                                                child: Text(
                                                                  _fullProfileModel!
                                                                      .results!
                                                                      .jobs![
                                                                          index]
                                                                      .employer!,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          Dimension
                                                                              .text_size_semi_medium),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  _fullProfileModel!
                                                                      .results!
                                                                      .jobs![
                                                                          index]
                                                                      .title!,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          Dimension
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
                                                                color: Colors
                                                                    .green,
                                                                size: Dimension
                                                                    .icon_size_medium,
                                                              ),
                                                              SizedBox(
                                                                width: 15.0,
                                                              ),
                                                              Text(
                                                                _fullProfileModel!
                                                                    .results!
                                                                    .jobs![index]
                                                                    .price!
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        Dimension
                                                                            .text_size_medium_large),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                FontAwesomeIcons
                                                                    .flag,
                                                                size: Dimension
                                                                    .icon_size_medium,
                                                              ),
                                                              SizedBox(
                                                                width: 15.0,
                                                              ),
                                                              Text(
                                                                _fullProfileModel!
                                                                    .results!
                                                                    .jobs![index]
                                                                    .location!,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        Dimension
                                                                            .text_size_medium_large),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.copy,
                                                                color:
                                                                    Colors.blue,
                                                                size: Dimension
                                                                    .icon_size_medium,
                                                              ),
                                                              SizedBox(
                                                                width: 15.0,
                                                              ),
                                                              Text(
                                                                _fullProfileModel!
                                                                    .results!
                                                                    .jobs![index]
                                                                    .type!,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        Dimension
                                                                            .text_size_medium_large),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .access_time_outlined,
                                                                color:
                                                                    Colors.red,
                                                                size: Dimension
                                                                    .icon_size_medium,
                                                              ),
                                                              SizedBox(
                                                                width: 15.0,
                                                              ),
                                                              Text(
                                                                _fullProfileModel!
                                                                    .results!
                                                                    .jobs![index]
                                                                    .duration!,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        Dimension
                                                                            .text_size_medium_large),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          userMap!["user_info"][
                                                                      "role_name"] ==
                                                                  "contractor"
                                                              ? GestureDetector(

                                                                  child: Text(
                                                                    "View Jobs",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                  onTap:
                                                                      () {
                                                                    //New
                                                                    //           String
                                                                    //           url =
                                                                    //               _fullProfileModel.results.jobs[index].jobUrl;
                                                                    //           setState(() {
                                                                    //             Get.toNamed(AppRoutes.JOBDETAILSPAGE, arguments: [
                                                                    //               "AlreadyPaid",
                                                                    //               url
                                                                    //             ]);
                                                                    //           });
                                                                    //New

                                                                    if (_fullProfileModel!
                                                                            .results!
                                                                            .jobs![index]
                                                                            .paymentstatus ==
                                                                        1) {
                                                                      String url = _fullProfileModel!
                                                                          .results!
                                                                          .jobs![
                                                                              index]
                                                                          .jobUrl!;
                                                                      setState(
                                                                          () {
                                                                        Get.toNamed(
                                                                            AppRoutes.JOBDETAILSPAGE,
                                                                            arguments: [
                                                                              "AlreadyPaid",
                                                                              url
                                                                            ]);
                                                                      });
                                                                    } else if (_fullProfileModel!
                                                                            .results!
                                                                            .jobs![index]
                                                                            .paymentstatus ==
                                                                        0) {
                                                                      var id = _fullProfileModel!
                                                                          .results!
                                                                          .jobs![
                                                                              index]
                                                                          .id;
                                                                      String slug = _fullProfileModel!
                                                                          .results!
                                                                          .jobs![
                                                                              index]
                                                                          .slug!;

                                                                      movetoDialog(
                                                                          id,
                                                                          slug);
                                                                    }
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
                                                    child: _fullProfileModel!
                                                                .results!
                                                                .jobs![index]
                                                                .isFeatured ==
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
                                                    left: Get.width / 1.2 - 12,
                                                    child: IconButton(
                                                      onPressed: () async {
                                                        savedType =
                                                            "saved_jobs";
                                                        await homeApiController
                                                            .repository
                                                            .postFavourite(
                                                                userMap!["user_info"]
                                                                    ["id"],
                                                                _fullProfileModel!
                                                                    .results!
                                                                    .jobs![index]
                                                                    .id,
                                                                savedType);
                                                        setState(
                                                          () {
                                                            _fullProfileModel!
                                                                    .results!
                                                                    .jobs![index]
                                                                    .isFavourite =
                                                                !_fullProfileModel!
                                                                    .results!
                                                                    .jobs![index]
                                                                    .isFavourite!;
                                                          },
                                                        );
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
                                                          color: AppColors
                                                              .backgroundColor,
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
                          : Center(child: Text(" ")),
                    )
                  ],
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
