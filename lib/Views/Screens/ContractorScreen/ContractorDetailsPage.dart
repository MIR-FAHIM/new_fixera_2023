import 'package:new_fixera/Controller/ContractorController.dart';
import 'package:new_fixera/Model/ContractorModel/ContractorDetailsModel.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:new_fixera/Views/Widget/ExportWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class ContratorDetailsPage extends StatefulWidget {
  @override
  _ContratorDetailsPageState createState() => _ContratorDetailsPageState();
}

class _ContratorDetailsPageState extends State<ContratorDetailsPage> {
  ContractorDetailsModel? _contractorDetailsModel;
  final ContractorController? contractorController = Get.find();
  var _id;

  double? ratingCount;
  bool dataFetchingError = false;

  @override
  void initState() {
    super.initState();
    _id = Get.arguments;
    fetchContractor(_id);
    // ratingCount = double.parse(_contractorDetailsModel
    //     .results.rating);
  }

  fetchContractor(id) async {
    ContractorDetailsModel contractorDetailsModel =
        await contractorController!.repository!.postContactorDetailsRepo(id);

    print("********++++++++++++************+++++++++++++++");
    print(contractorDetailsModel);
    print("********++++++++++++************+++++++++++++++");
    if (contractorDetailsModel == null) {
      setState(() {
        dataFetchingError = true;
      });
    }
    setState(() {
      _contractorDetailsModel = contractorDetailsModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          title: Text("Contractor Details"),
        ),
        body: dataFetchingError
            ? Center(
                child: Text("Could not fetch data"),
              )
            : _contractorDetailsModel == null
                ? Align(
                    child: LinearProgressIndicator(),
                    alignment: Alignment.topCenter,
                  )
                : Container(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            //overflow: Overflow.visible,
                        clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                  child: Container(
                                width: Get.width,
                                height: 170,
                                //child: Text("Banner"),
                                child:
                                    //widget.con.results.banner=="0"
                                    _contractorDetailsModel!.results!.banner ==
                                            "0"
                                        ? Container(
                                            color: Colors.grey,
                                          )
                                        : Image.network(
                                            //widget.con.results.banner
                                            _contractorDetailsModel!
                                                .results!.banner!,
                                          ),
                              )),
                              Positioned(
                                top: 110,
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
                                          //height: 80,
                                          child: ListTile(
                                            title: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  _contractorDetailsModel!
                                                              .results!
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
                                                Text( "",
                                                  // _contractorDetailsModel!
                                                  //             .results!.name
                                                  //             .toString()
                                                  //             .length >
                                                  //         15
                                                  //     ? _contractorDetailsModel!
                                                  //             .results!.name!
                                                  //             .substring(
                                                  //                 0, 14) +
                                                  //         "..."
                                                  //     : _contractorDetailsModel!
                                                  //         .results!.name,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ],
                                            ),
                                            subtitle: Column(
                                              children: [
                                                Text(
                                                  _contractorDetailsModel!
                                                      .results!.tagline!,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                ),
                                                // Text(
                                                //   _contractorDetailsModel
                                                //       .results.rating,
                                                //   overflow: TextOverflow.ellipsis,
                                                //   style: TextStyle(
                                                //       fontSize: 14,
                                                //       color: Colors.black),
                                                // ),
                                                RatingBar.builder(
                                                  ignoreGestures: true,
                                                  itemSize: 25,
                                                  initialRating: double.parse(
                                                              _contractorDetailsModel!
                                                                  .results!
                                                                  .rating!) ==
                                                          null
                                                      ? 0
                                                      : double.parse(
                                                          _contractorDetailsModel!
                                                              .results!.rating!),
                                                  minRating: 0,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  //itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                                  itemBuilder: (context, _) =>
                                                      Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (double value) {  },
                                                  // onRatingUpdate: (rating) {
                                                  //   print(rating);
                                                  // },
                                                ),
                                              ],
                                            ),
                                            leading: Container(
                                              //height: 60,
                                              width: 60,
                                              child: _contractorDetailsModel!
                                                          .results!.avatar ==
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
                                                      _contractorDetailsModel!
                                                          .results!.avatar!),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 260,
                                        width: 320,
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 50,
                                              color: Colors.grey[100],
                                              child: Card(
                                                color: Colors.grey[100],
                                                child: ListTile(
                                                  title: Text(
                                                    'Hourly Rate',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  trailing: Text(
                                                      _contractorDetailsModel!
                                                          .results!.hourlyRate
                                                          .toString()),
                                                ),
                                              ),
                                            ),

                                            Container(
                                              height: 50,
                                              color: Colors.grey[100],
                                              child: Card(
                                                color: Colors.grey[100],
                                                child: ListTile(
                                                  title: Text(
                                                    'Location',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  trailing: Text(
                                                      _contractorDetailsModel!
                                                          .results!.location!),
                                                ),
                                              ),
                                            ),
                                            //    Divider(
                                            //  thickness: 1.5,
                                            //   ),
                                            Container(
                                              height: 50,
                                              color: Colors.grey[100],
                                              child: Card(
                                                color: Colors.grey[100],
                                                child: ListTile(
                                                  title: Text(
                                                    'Feedback',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  trailing: Text(
                                                      _contractorDetailsModel!
                                                          .results!.feedback!
                                                          .toString()),
                                                ),
                                              ),
                                            ),
                                            //    Divider(
                                            //  thickness: 1.5,
                                            //   ),
                                            Container(
                                              height: 50,
                                              color: Colors.grey[100],
                                              child: Card(
                                                color: Colors.grey[100],
                                                child: ListTile(
                                                  title: Text(
                                                    'Category',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  trailing: Text(
                                                      _contractorDetailsModel!
                                                          .results!.category!),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 50,
                                              color: Colors.grey[100],
                                              child: Card(
                                                color: Colors.grey[100],
                                                child: ListTile(
                                                  title: Text(
                                                    'Member Since',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  trailing: Text(
                                                      _contractorDetailsModel!
                                                          .results!.since!),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 300,
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
                                )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                                child: Text(
                              _contractorDetailsModel!.results!.about!,
                              textAlign: TextAlign.justify,
                            )),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    child: Text(
                                  'Project Status',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 100,
                                width: 150,
                                color: Colors.grey[100],
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        _contractorDetailsModel!
                                            .results!.ongoingJobs!
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.green, fontSize: 16),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Center(
                                      child: Text(
                                        'Ongoing Project',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 100,
                                width: 150,
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        _contractorDetailsModel!
                                            .results!.completedJobs!
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.green, fontSize: 14),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Center(
                                      child: Text(
                                        'Completed Project',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 100,
                                width: 150,
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        _contractorDetailsModel!
                                            .results!.canceledJobs!
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.green, fontSize: 16),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Center(
                                      child: Text(
                                        'Canceled Project',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 100,
                                width: 150,
                                color: Colors.grey[100],
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        _contractorDetailsModel!.results!.earning!
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.green, fontSize: 16),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Center(
                                      child: Text(
                                        'Total Earnings',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    child: Text(
                                  'My Skills',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 80,
                            child: _contractorDetailsModel!
                                        .results!.skills!.length! >
                                    0
                                ? ListView.builder(
                                    itemCount: _contractorDetailsModel!
                                        .results!.skills!.length!,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                child: Text(
                                              _contractorDetailsModel!
                                                  .results!.skills![index],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                          ],
                                        ),
                                      );
                                    },
                                  )
                                : Text("No Skills Found"),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    child: Text(
                                  'Awards & Certifications',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            height: 110,
                            //width: Get.width/1.02,
                            child: _contractorDetailsModel!
                                        .results!.awards!.length >
                                    0
                                ? ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _contractorDetailsModel!
                                        .results!.awards!.length,
                                    itemBuilder: (context, index) {
                                      String awardImageUrl =
                                          "${_contractorDetailsModel!.results!.awardImagePath}/" +
                                              "${_contractorDetailsModel!.results!.awards![index].awardHiddenImage}";

                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Card(
                                            elevation: 4,
                                            color: Colors.white,
                                            child: Container(
                                              height: 80,
                                              width: Get.width / 1.4,
                                              child: ListTile(
                                                title: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .baseline,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        _contractorDetailsModel!
                                                            .results!
                                                            .awards![index]
                                                            .awardTitle!,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                subtitle: Text(
                                                  _contractorDetailsModel!
                                                      .results!
                                                      .awards![index]
                                                      .awardDate!,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                ),
                                                leading: Container(
                                                    height: 60,
                                                    width: 60,
                                                    child: _contractorDetailsModel!
                                                                .results!
                                                                .awards![index]
                                                                .awardHiddenImage ==
                                                            "0"
                                                        ? Container(
                                                            child: Center(
                                                              child: Text(
                                                                '255x255',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        8),
                                                              ),
                                                            ),
                                                          )
                                                        : Image.network(
                                                            awardImageUrl)
                                                    //Image.network(_contractorDetailsModel.results.projectImagePath+_contractorDetailsModel.results.projects[index].projectHiddenImage),
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                : Center(
                                    child: Text(
                                        "No Awards & Certifications Found"),
                                  ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    child: Text(
                                  'Crafted Projects',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            height: 100,
                            child: _contractorDetailsModel!
                                        .results!.projects!.length >
                                    0
                                ? ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _contractorDetailsModel!
                                        .results!.projects!.length,
                                    itemBuilder: (context, index) {
                                      String craftedImageUrl =
                                          "${_contractorDetailsModel!.results!.projectImagePath}/" +
                                              "${_contractorDetailsModel!.results!.projects![index].projectHiddenImage}";
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Card(
                                            elevation: 4,
                                            color: Colors.white,
                                            child: Container(
                                              height: 80,
                                              width: Get.width / 1.4,
                                              child: ListTile(
                                                title: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .baseline,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: [
                                                    Expanded(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          launchURL(
                                                              _contractorDetailsModel!
                                                                  .results!
                                                                  .projects![
                                                                      index]
                                                                  .projectUrl);
                                                        },
                                                        child: Text(
                                                          _contractorDetailsModel!
                                                              .results!
                                                              .projects![index]
                                                              .projectUrl!,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors
                                                                  .blue[900]),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                subtitle: Text(
                                                  _contractorDetailsModel!
                                                      .results!
                                                      .projects![index]
                                                      .projectTitle!,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                ),
                                                leading: Container(
                                                    height: 60,
                                                    width: 60,
                                                    child: _contractorDetailsModel!
                                                                .results!
                                                                .projects![index]
                                                                .projectHiddenImage ==
                                                            "0"
                                                        ? Container(
                                                            child: Center(
                                                              child: Text(
                                                                '255x255',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        8),
                                                              ),
                                                            ),
                                                          )
                                                        : Image.network(
                                                            craftedImageUrl)
                                                    //Image.network(_contractorDetailsModel.results.projectImagePath+_contractorDetailsModel.results.projects[index].projectHiddenImage),
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                : Center(
                                    child: Text("No Crafted Projects Found"),
                                  ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    child: Text(
                                  'Education',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            height: 220,
                            child: _contractorDetailsModel!
                                        .results!.educations!.length >
                                    0
                                ? ListView.builder(
                                    itemCount: _contractorDetailsModel!
                                        .results!.educations!.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                _contractorDetailsModel!
                                                    .results!
                                                    .educations![index]
                                                    .degreeTitle!,
                                                style: TextStyle(
                                                    //overflow: TextOverflow.clip,
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.home,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      _contractorDetailsModel!
                                                          .results!
                                                          .educations![index]
                                                          .instituteTitle!,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.event,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "${_contractorDetailsModel!.results!.educations![index].startDate}" +
                                                        " - " +
                                                        "${_contractorDetailsModel!.results!.educations![index].endDate}",
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                  _contractorDetailsModel!
                                                      .results!
                                                      .educations![index]
                                                      .description!,
                                                  textAlign: TextAlign.justify,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  )),
                                              SizedBox(
                                                height: 16,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : Center(
                                    child: Text("No Education Data Found"),
                                  ),
                          ),
                          SizedBox(
                            height: 16,
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    child: Text(
                                  'Experiences',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            height: 220,
                            width: Get.width,
                            child: _contractorDetailsModel!
                                        .results!.experiences!.length >
                                    0
                                ? ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _contractorDetailsModel!
                                        .results!.experiences!.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Card(
                                            elevation: 4,
                                            color: Colors.white,
                                            child: Container(
                                              height: 210,
                                              width: Get.width / 1.1,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        _contractorDetailsModel!
                                                            .results!
                                                            .experiences![index]
                                                            .jobTitle!,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.home,
                                                            color: Colors.grey,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            _contractorDetailsModel!
                                                                .results!
                                                                .experiences![
                                                                    index]
                                                                .companyTitle!,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.event,
                                                            color: Colors.grey,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            "${_contractorDetailsModel!.results!.experiences![index].startDate}" +
                                                                " - " +
                                                                "${_contractorDetailsModel!.results!.experiences![index].endDate}",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text(
                                                          _contractorDetailsModel!
                                                              .results!
                                                              .experiences![
                                                                  index]
                                                              .description!,
                                                          textAlign:
                                                              TextAlign.justify,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  )
                                : Center(
                                    child: Text("No Experiences Found"),
                                  ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          //  Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 20),
                          //   child: Row(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Container(
                          //           child: Text(
                          //         'Client Feedback',
                          //         style: TextStyle(
                          //             color: Colors.black,
                          //             fontSize: 18,
                          //             fontWeight: FontWeight.w700),
                          //       )),
                          //     ],
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 16,
                          // ),
                          //   Container(
                          //   height: 130,
                          //   width: Get.width/1.09,
                          //   child: ListView.builder(
                          //     scrollDirection: Axis.horizontal,
                          //     itemCount: _contractorDetailsModel.results.feedbackLists.length,
                          //     itemBuilder: (context,index){
                          //       return Card(
                          //               child: Padding(
                          //                 padding: const EdgeInsets.all(15.0),
                          //                 child: Column(
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.center,
                          //                   children: [
                          //                     Row(
                          //                       children: [
                          //                         Icon(
                          //                          _contractorDetailsModel.results.feedbackLists[index].verifyStatus==
                          //                                   true
                          //                               ? Icons.check_circle
                          //                               : Icons
                          //                                   .check_circle_outline,
                          //                           color: Colors.green,
                          //                           size: Dimension
                          //                               .icon_size_medium,
                          //                         ),
                          //                         SizedBox(
                          //                           width: 15.0,
                          //                         ),
                          //                         Expanded(
                          //                           child: Text(
                          //                          _contractorDetailsModel.results.feedbackLists[index].jobTitle,
                          //                             overflow: TextOverflow
                          //                                 .ellipsis,
                          //                             style: TextStyle(
                          //                                 fontSize: Dimension
                          //                                     .text_size_semi_medium),
                          //                           ),
                          //                         ),
                          //                       ],
                          //                     ),
                          //                     Row(
                          //                       children: [
                          //                         Text(
                          //                            _contractorDetailsModel.results.feedbackLists[index].clientName,
                          //                           style: TextStyle(
                          //                               fontSize: Dimension
                          //                                   .text_size_extra_large),
                          //                         ),
                          //                       ],
                          //                     ),
                          //                     Row(
                          //                       children: [
                          //                         Icon(
                          //                           FontAwesomeIcons
                          //                               .dollarSign,
                          //                           color: Colors.green,
                          //                           size: Dimension
                          //                               .icon_size_medium,
                          //                         ),
                          //                         SizedBox(
                          //                           width: 15.0,
                          //                         ),
                          //                         Text(
                          //                         _contractorDetailsModel.results.feedbackLists[index].rating
                          //                               .toString(),
                          //                           style: TextStyle(
                          //                               fontSize: Dimension
                          //                                   .text_size_medium_large),
                          //                         ),
                          //                       ],
                          //                     ),
                          //                     Row(
                          //                       children: [
                          //                         Icon(
                          //                           FontAwesomeIcons.flag,
                          //                           size: Dimension
                          //                               .icon_size_medium,
                          //                         ),
                          //                         SizedBox(
                          //                           width: 15.0,
                          //                         ),
                          //                         Text(
                          //                           _contractorDetailsModel.results.feedbackLists[index].location,
                          //                           style: TextStyle(
                          //                               fontSize: Dimension
                          //                                   .text_size_medium_large),
                          //                         ),
                          //                       ],
                          //                     ),
                          //                     Row(
                          //                       children: [
                          //                         Icon(
                          //                           Icons.copy,
                          //                           color: Colors.blue,
                          //                           size: Dimension
                          //                               .icon_size_medium,
                          //                         ),
                          //                         SizedBox(
                          //                           width: 15.0,
                          //                         ),
                          //                         Text(
                          //                            _contractorDetailsModel.results.feedbackLists[index].jobType,
                          //                           style: TextStyle(
                          //                               fontSize: Dimension
                          //                                   .text_size_medium_large),
                          //                         ),
                          //                       ],
                          //                     ),
                          //                     Row(
                          //                       children: [
                          //                         Icon(
                          //                           Icons
                          //                               .access_time_outlined,
                          //                           color: Colors.red,
                          //                           size: Dimension
                          //                               .icon_size_medium,
                          //                         ),
                          //                         SizedBox(
                          //                           width: 15.0,
                          //                         ),
                          //                         Text(
                          //                          _contractorDetailsModel.results.feedbackLists[index].feedback,
                          //                           style: TextStyle(
                          //                               fontSize: Dimension
                          //                                   .text_size_medium_large),
                          //                         ),
                          //                       ],
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ),
                          //             );
                          //     },

                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  )
        // : Align(
        //     child: LinearProgressIndicator(),
        //     alignment: Alignment.topCenter,
        //   )
        //     :
        // Container(
        //         child: SingleChildScrollView(
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.center,
        //             children: [
        //               Stack(
        //                 overflow: Overflow.visible,
        //                 children: [
        //                   Positioned(
        //                       child: Container(
        //                     width: Get.width,
        //                     height: 170,
        //                     child: Container(
        //                       color: Colors.grey,
        //                     ),
        //                     // child: _contractorDetailsModel.results.banner ==
        //                     //         "0"
        //                     //     ? Container(
        //                     //         color: Colors.grey,
        //                     //       )
        //                     //     : Image.network(
        //                     //         _contractorDetailsModel.results.banner,
        //                     //       ),
        //                   )),
        //                   Positioned(
        //                     top: 110,
        //                     left: 20,
        //                     right: 20,
        //                     child: Container(
        //                       color: Colors.white,
        //                       child: Column(
        //                         children: [
        //                           Card(
        //                             elevation: 0,
        //                             color: Colors.white,
        //                             child: SizedBox(
        //                               height: 80,
        //                               child: ListTile(
        //                                 title: Row(
        //                                   crossAxisAlignment:
        //                                       CrossAxisAlignment.start,
        //                                   children: [
        //                                     Icon(
        //                                       Icons
        //                                           .check_circle_outline,
        //                                       // _contractorDetailsModel.results
        //                                       //             .verifyStatus ==
        //                                       //         true
        //                                       //     ? Icons.check_circle
        //                                       //     : Icons
        //                                       //         .check_circle_outline,
        //                                       color: Colors.green,
        //                                       size:
        //                                           Dimension.icon_size_medium,
        //                                     ),
        //                                     SizedBox(
        //                                       width: 10,
        //                                     ),
        //                                     Text(
        //                                       // _contractorDetailsModel
        //                                       //             .results.name.length == 0
        //                                       //     ? "No Data Found"
        //                                       //     : _contractorDetailsModel
        //                                       //         .results.name,
        //                                       //"No Data Found",
        //
        //                                         _contractorDetailsModel
        //                                                  .results.name,
        //                                       style: TextStyle(fontSize: 16),
        //                                     ),
        //                                   ],
        //                                 ),
        //                                 subtitle: Text(
        //                                   // _contractorDetailsModel
        //                                   //     .results.tagline.length  ==0 ?"":
        //                                   // _contractorDetailsModel
        //                                   //     .results.tagline,
        //                                   "No Data Found",
        //
        //                                   // contractorController
        //                                   //     .list[0].name,
        //                                   overflow: TextOverflow.ellipsis,
        //                                   style: TextStyle(
        //                                       fontSize: 14,
        //                                       color: Colors.black),
        //                                 ),
        //                                 leading: Container(
        //                                   height: 60,
        //                                   width: 60,
        //                                   child: Container(
        //                                     color: Colors.grey,
        //                                     child: Center(
        //                                       child: Text(
        //                                         '255x255',
        //                                         style: TextStyle(
        //                                             fontSize: 8),
        //                                       ),
        //                                     ),
        //                                   ),
        //                                   // child: _contractorDetailsModel
        //                                   //             .results.avatar ==
        //                                   //         "0"
        //                                   //     ? Container(
        //                                   //         color: Colors.grey,
        //                                   //         child: Center(
        //                                   //           child: Text(
        //                                   //             '255x255',
        //                                   //             style: TextStyle(
        //                                   //                 fontSize: 8),
        //                                   //           ),
        //                                   //         ),
        //                                   //       )
        //                                   //     : Image.network(
        //                                   //         _contractorDetailsModel
        //                                   //             .results.avatar),
        //                                 ),
        //                               ),
        //                             ),
        //                           ),
        //                           Container(
        //                             height: 260,
        //                             width: 320,
        //                             child: Column(
        //                               children: [
        //                                 Container(
        //                                   height: 50,
        //                                   color: Colors.grey[100],
        //                                   child: Card(
        //                                     color: Colors.grey[100],
        //                                     child: ListTile(
        //                                       title: Text(
        //                                         'Hourly Rate',
        //                                         style: TextStyle(
        //                                             fontSize: 14,
        //                                             fontWeight:
        //                                                 FontWeight.bold),
        //                                       ),
        //                                       trailing: Text("No Data Found"
        //                                           // _contractorDetailsModel
        //                                           //     .results.hourlyRate.toString() == "0"?"No Data Found":
        //                                           // _contractorDetailsModel
        //                                           //     .results.hourlyRate
        //                                           //     .toString()
        //                                           ),
        //                                     ),
        //                                   ),
        //                                 ),
        //
        //                                 Container(
        //                                   height: 50,
        //                                   color: Colors.grey[100],
        //                                   child: Card(
        //                                     color: Colors.grey[100],
        //                                     child: ListTile(
        //                                       title: Text(
        //                                         'Location',
        //                                         style: TextStyle(
        //                                             fontSize: 14,
        //                                             fontWeight:
        //                                                 FontWeight.bold),
        //                                       ),
        //                                       trailing: Text("No Data Found"
        //                                           // _contractorDetailsModel
        //                                           //     .results.location==null?"":
        //                                           // _contractorDetailsModel
        //                                           //     .results.location
        //                                           ),
        //                                     ),
        //                                   ),
        //                                 ),
        //                                 //    Divider(
        //                                 //  thickness: 1.5,
        //                                 //   ),
        //                                 Container(
        //                                   height: 50,
        //                                   color: Colors.grey[100],
        //                                   child: Card(
        //                                     color: Colors.grey[100],
        //                                     child: ListTile(
        //                                       title: Text(
        //                                         'Feedback',
        //                                         style: TextStyle(
        //                                             fontSize: 14,
        //                                             fontWeight:
        //                                                 FontWeight.bold),
        //                                       ),
        //                                       trailing: Text("No Data Found"
        //                                           // _contractorDetailsModel
        //                                           //     .results.feedback==null?"":
        //                                           // _contractorDetailsModel
        //                                           //     .results.feedback
        //                                           //     .toString()
        //                                           ),
        //                                     ),
        //                                   ),
        //                                 ),
        //                                 //    Divider(
        //                                 //  thickness: 1.5,
        //                                 //   ),
        //                                 Container(
        //                                   height: 50,
        //                                   color: Colors.grey[100],
        //                                   child: Card(
        //                                     color: Colors.grey[100],
        //                                     child: ListTile(
        //                                       title: Text(
        //                                         'Member Since',
        //                                         style: TextStyle(
        //                                             fontSize: 14,
        //                                             fontWeight:
        //                                                 FontWeight.w600),
        //                                       ),
        //                                       trailing: Text("No Data Found"
        //                                           // _contractorDetailsModel
        //                                           //     .results.since==null?"":
        //                                           // _contractorDetailsModel
        //                                           //     .results.since
        //                                           ),
        //                                     ),
        //                                   ),
        //                                 ),
        //                               ],
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   )
        //                 ],
        //               ),
        //               SizedBox(
        //                 height: 240,
        //               ),
        //               Padding(
        //                 padding: const EdgeInsets.symmetric(horizontal: 20),
        //                 child: Row(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Container(
        //                         child: Text(
        //                       'About',
        //                       style: TextStyle(
        //                           color: Colors.black,
        //                           fontSize: 18,
        //                           fontWeight: FontWeight.w700),
        //                     )),
        //                   ],
        //                 ),
        //               ),
        //               SizedBox(
        //                 height: 16,
        //               ),
        //               Padding(
        //                 padding: const EdgeInsets.symmetric(horizontal: 16),
        //                 child: Container(
        //                   child: Text(
        //                     "No Data Found",
        //                     // _contractorDetailsModel.results.about == null
        //                     //     ? ""
        //                     //     : _contractorDetailsModel.results.about,
        //                     textAlign: TextAlign.justify,
        //                   ),
        //                 ),
        //               ),
        //               SizedBox(
        //                 height: 16,
        //               ),
        //               Padding(
        //                 padding: const EdgeInsets.symmetric(horizontal: 20),
        //                 child: Row(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Container(
        //                         child: Text(
        //                       'Project Status',
        //                       style: TextStyle(
        //                           color: Colors.black,
        //                           fontSize: 18,
        //                           fontWeight: FontWeight.w700),
        //                     )),
        //                   ],
        //                 ),
        //               ),
        //               SizedBox(
        //                 height: 20,
        //               ),
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   Container(
        //                     height: 100,
        //                     width: 150,
        //                     color: Colors.grey[100],
        //                     child: Column(
        //                       mainAxisAlignment: MainAxisAlignment.center,
        //                       children: [
        //                         Center(
        //                           child: Text(
        //                             "No Data Found",
        //                             // _contractorDetailsModel
        //                             //             .results.ongoingJobs ==
        //                             //         null
        //                             //     ? ""
        //                             //     : _contractorDetailsModel
        //                             //         .results.ongoingJobs
        //                             //         .toString(),
        //                             style: TextStyle(
        //                                 color: Colors.green, fontSize: 16),
        //                           ),
        //                         ),
        //                         SizedBox(
        //                           height: 5,
        //                         ),
        //                         Center(
        //                           child: Text(
        //                             'Ongoing Project',
        //                             style: TextStyle(
        //                                 color: Colors.black, fontSize: 14),
        //                           ),
        //                         )
        //                       ],
        //                     ),
        //                   ),
        //                   Container(
        //                     height: 100,
        //                     width: 150,
        //                     color: Colors.white,
        //                     child: Column(
        //                       mainAxisAlignment: MainAxisAlignment.center,
        //                       children: [
        //                         Center(
        //                           child: Text(
        //                             "No Data Found",
        //                             // _contractorDetailsModel
        //                             //             .results.completedJobs ==
        //                             //         null
        //                             //     ? ""
        //                             //     : _contractorDetailsModel
        //                             //         .results.completedJobs
        //                             //         .toString(),
        //                             style: TextStyle(
        //                                 color: Colors.green, fontSize: 14),
        //                           ),
        //                         ),
        //                         SizedBox(
        //                           height: 5,
        //                         ),
        //                         Center(
        //                           child: Text(
        //                             'Completed Project',
        //                             style: TextStyle(
        //                                 color: Colors.black, fontSize: 14),
        //                           ),
        //                         )
        //                       ],
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   Container(
        //                     height: 100,
        //                     width: 150,
        //                     color: Colors.white,
        //                     child: Column(
        //                       mainAxisAlignment: MainAxisAlignment.center,
        //                       children: [
        //                         Center(
        //                           child: Text(
        //                             "No Data Found",
        //                             // _contractorDetailsModel
        //                             //             .results.canceledJobs ==
        //                             //         null
        //                             //     ? ""
        //                             //     : _contractorDetailsModel
        //                             //         .results.canceledJobs
        //                             //         .toString(),
        //                             style: TextStyle(
        //                                 color: Colors.green, fontSize: 16),
        //                           ),
        //                         ),
        //                         SizedBox(
        //                           height: 5,
        //                         ),
        //                         Center(
        //                           child: Text(
        //                             'Canceled Project',
        //                             style: TextStyle(
        //                                 color: Colors.black, fontSize: 14),
        //                           ),
        //                         )
        //                       ],
        //                     ),
        //                   ),
        //                   Container(
        //                     height: 100,
        //                     width: 150,
        //                     color: Colors.grey[100],
        //                     child: Column(
        //                       mainAxisAlignment: MainAxisAlignment.center,
        //                       children: [
        //                         Center(
        //                           child: Text(
        //                             "No Data Found",
        //                             // _contractorDetailsModel.results.earning ==
        //                             //         null
        //                             //     ? ""
        //                             //     : _contractorDetailsModel
        //                             //         .results.earning
        //                             //         .toString(),
        //                             style: TextStyle(
        //                                 color: Colors.green, fontSize: 16),
        //                           ),
        //                         ),
        //                         SizedBox(
        //                           height: 5,
        //                         ),
        //                         Center(
        //                           child: Text(
        //                             'Total Earnings',
        //                             style: TextStyle(
        //                                 color: Colors.black, fontSize: 14),
        //                           ),
        //                         )
        //                       ],
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //               SizedBox(
        //                 height: 20,
        //               ),
        //               Padding(
        //                 padding: const EdgeInsets.symmetric(horizontal: 20),
        //                 child: Row(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Container(
        //                         child: Text(
        //                       'My Skills',
        //                       style: TextStyle(
        //                           color: Colors.black,
        //                           fontSize: 18,
        //                           fontWeight: FontWeight.w700),
        //                     )),
        //                   ],
        //                 ),
        //               ),
        //               SizedBox(
        //                 height: 10,
        //               ),
        //               Container(
        //                 height: 80,
        //                 child: Text("No Skills Found"),
        //                 // child: _contractorDetailsModel.results.skills.length >
        //                 //         0
        //                 //     ? ListView.builder(
        //                 //         itemCount: _contractorDetailsModel
        //                 //             .results.skills.length,
        //                 //         itemBuilder: (context, index) {
        //                 //           return Padding(
        //                 //             padding: const EdgeInsets.symmetric(
        //                 //                 horizontal: 20),
        //                 //             child: Row(
        //                 //               crossAxisAlignment:
        //                 //                   CrossAxisAlignment.start,
        //                 //               children: [
        //                 //                 Container(
        //                 //                     child: Text(
        //                 //                   _contractorDetailsModel
        //                 //                       .results.skills[index],
        //                 //                   style: TextStyle(
        //                 //                       color: Colors.black,
        //                 //                       fontSize: 16,
        //                 //                       fontWeight: FontWeight.w500),
        //                 //                 )),
        //                 //               ],
        //                 //             ),
        //                 //           );
        //                 //         },
        //                 //       )
        //                 //     : Text("No Skills Found"),
        //               ),
        //               SizedBox(
        //                 height: 16,
        //               ),
        //               Padding(
        //                 padding: const EdgeInsets.symmetric(horizontal: 20),
        //                 child: Row(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Container(
        //                         child: Text(
        //                       'Awards & Certifications ',
        //                       style: TextStyle(
        //                           color: Colors.black,
        //                           fontSize: 18,
        //                           fontWeight: FontWeight.w700),
        //                     )),
        //                   ],
        //                 ),
        //               ),
        //               SizedBox(
        //                 height: 16,
        //               ),
        //               Container(
        //                 height: 110,
        //                 //width: Get.width/1.02,
        //                 child: Text("No Data Found"),
        //                 // child: _contractorDetailsModel.results.awards.length >
        //                 //         0
        //                 //     ? ListView.builder(
        //                 //         scrollDirection: Axis.horizontal,
        //                 //         itemCount: _contractorDetailsModel
        //                 //             .results.awards.length,
        //                 //         itemBuilder: (context, index) {
        //                 //           String awardImageUrl =
        //                 //               "${_contractorDetailsModel.results.awardImagePath}/" +
        //                 //                   "${_contractorDetailsModel.results.awards[index].awardHiddenImage}";
        //                 //
        //                 //           return Column(
        //                 //             crossAxisAlignment:
        //                 //                 CrossAxisAlignment.center,
        //                 //             children: [
        //                 //               Card(
        //                 //                 elevation: 4,
        //                 //                 color: Colors.white,
        //                 //                 child: Container(
        //                 //                   height: 80,
        //                 //                   width: Get.width / 1.4,
        //                 //                   child: ListTile(
        //                 //                     title: Row(
        //                 //                       crossAxisAlignment:
        //                 //                           CrossAxisAlignment.baseline,
        //                 //                       children: [
        //                 //                         Expanded(
        //                 //                           child: Text(
        //                 //                             _contractorDetailsModel
        //                 //                                 .results
        //                 //                                 .awards[index]
        //                 //                                 .awardTitle,
        //                 //                             overflow:
        //                 //                                 TextOverflow.ellipsis,
        //                 //                             style: TextStyle(
        //                 //                                 fontSize: 14,
        //                 //                                 color: Colors.grey),
        //                 //                           ),
        //                 //                         ),
        //                 //                       ],
        //                 //                     ),
        //                 //                     subtitle: Text(
        //                 //                       _contractorDetailsModel.results
        //                 //                           .awards[index].awardDate,
        //                 //                       style: TextStyle(
        //                 //                           fontSize: 14,
        //                 //                           color: Colors.black),
        //                 //                     ),
        //                 //                     leading: Container(
        //                 //                         height: 60,
        //                 //                         width: 60,
        //                 //                         child: _contractorDetailsModel
        //                 //                                     .results
        //                 //                                     .awards[index]
        //                 //                                     .awardHiddenImage ==
        //                 //                                 "0"
        //                 //                             ? Container(
        //                 //                                 child: Center(
        //                 //                                   child: Text(
        //                 //                                     '255x255',
        //                 //                                     style: TextStyle(
        //                 //                                         fontSize: 8),
        //                 //                                   ),
        //                 //                                 ),
        //                 //                               )
        //                 //                             : Image.network(
        //                 //                                 awardImageUrl)
        //                 //                         //Image.network(_contractorDetailsModel.results.projectImagePath+_contractorDetailsModel.results.projects[index].projectHiddenImage),
        //                 //                         ),
        //                 //                   ),
        //                 //                 ),
        //                 //               ),
        //                 //             ],
        //                 //           );
        //                 //         },
        //                 //       )
        //                 //     : Center(
        //                 //         //child: LinearProgressIndicator(),
        //                 //         child: Text("No Data Found"),
        //                 //       ),
        //               ),
        //
        //               Padding(
        //                 padding: const EdgeInsets.symmetric(horizontal: 20),
        //                 child: Row(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Container(
        //                         child: Text(
        //                       'Crafted Projects',
        //                       style: TextStyle(
        //                           color: Colors.black,
        //                           fontSize: 18,
        //                           fontWeight: FontWeight.w700),
        //                     )),
        //                   ],
        //                 ),
        //               ),
        //               SizedBox(
        //                 height: 16,
        //               ),
        //               Container(
        //                 height: 100,
        //                 child: Text("No Data Found"),
        //                 // child: _contractorDetailsModel
        //                 //             .results.projects.length >
        //                 //         0
        //                 //     ? ListView.builder(
        //                 //         scrollDirection: Axis.horizontal,
        //                 //         itemCount: _contractorDetailsModel
        //                 //             .results.projects.length,
        //                 //         itemBuilder: (context, index) {
        //                 //           String craftedImageUrl =
        //                 //               "${_contractorDetailsModel.results.projectImagePath}/" +
        //                 //                   "${_contractorDetailsModel.results.projects[index].projectHiddenImage}";
        //                 //           return Column(
        //                 //             crossAxisAlignment:
        //                 //                 CrossAxisAlignment.center,
        //                 //             children: [
        //                 //               Card(
        //                 //                 elevation: 4,
        //                 //                 color: Colors.white,
        //                 //                 child: Container(
        //                 //                   height: 80,
        //                 //                   width: Get.width / 1.4,
        //                 //                   child: ListTile(
        //                 //                     title: Row(
        //                 //                       crossAxisAlignment:
        //                 //                           CrossAxisAlignment.baseline,
        //                 //                       children: [
        //                 //                         Expanded(
        //                 //                           child: GestureDetector(
        //                 //                             onTap: () {
        //                 //                               launchURL(
        //                 //                                   _contractorDetailsModel
        //                 //                                       .results
        //                 //                                       .projects[index]
        //                 //                                       .projectUrl);
        //                 //                             },
        //                 //                             child: Text(
        //                 //                               _contractorDetailsModel
        //                 //                                   .results
        //                 //                                   .projects[index]
        //                 //                                   .projectUrl,
        //                 //                               overflow: TextOverflow
        //                 //                                   .ellipsis,
        //                 //                               style: TextStyle(
        //                 //                                   fontSize: 14,
        //                 //                                   color: Colors
        //                 //                                       .blue[900]),
        //                 //                             ),
        //                 //                           ),
        //                 //                         ),
        //                 //                       ],
        //                 //                     ),
        //                 //                     subtitle: Text(
        //                 //                       _contractorDetailsModel
        //                 //                           .results
        //                 //                           .projects[index]
        //                 //                           .projectTitle,
        //                 //                       style: TextStyle(
        //                 //                           fontSize: 14,
        //                 //                           color: Colors.black),
        //                 //                     ),
        //                 //                     leading: Container(
        //                 //                         height: 60,
        //                 //                         width: 60,
        //                 //                         child: _contractorDetailsModel
        //                 //                                     .results
        //                 //                                     .projects[index]
        //                 //                                     .projectHiddenImage ==
        //                 //                                 "0"
        //                 //                             ? Container(
        //                 //                                 child: Center(
        //                 //                                   child: Text(
        //                 //                                     '255x255',
        //                 //                                     style: TextStyle(
        //                 //                                         fontSize: 8),
        //                 //                                   ),
        //                 //                                 ),
        //                 //                               )
        //                 //                             : Image.network(
        //                 //                                 craftedImageUrl)
        //                 //                         //Image.network(_contractorDetailsModel.results.projectImagePath+_contractorDetailsModel.results.projects[index].projectHiddenImage),
        //                 //                         ),
        //                 //                   ),
        //                 //                 ),
        //                 //               ),
        //                 //             ],
        //                 //           );
        //                 //         },
        //                 //       )
        //                 //     : Center(
        //                 //         //child: LinearProgressIndicator(),
        //                 //         child: Text("No Data Found"),
        //                 //       ),
        //               ),
        //
        //               Padding(
        //                 padding: const EdgeInsets.symmetric(horizontal: 20),
        //                 child: Row(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Container(
        //                         child: Text(
        //                       'Education',
        //                       style: TextStyle(
        //                           color: Colors.black,
        //                           fontSize: 18,
        //                           fontWeight: FontWeight.w700),
        //                     )),
        //                   ],
        //                 ),
        //               ),
        //               SizedBox(
        //                 height: 16,
        //               ),
        //               Container(
        //                 height: 220,
        //                 child: ListView.builder(
        //                   itemCount: 0,
        //                   // itemCount: _contractorDetailsModel
        //                   //     .results.educations.length,
        //                   itemBuilder: (context, index) {
        //                     return Padding(
        //                       padding:
        //                           const EdgeInsets.symmetric(horizontal: 16),
        //                       child: SingleChildScrollView(
        //                         child: Column(
        //                           crossAxisAlignment:
        //                               CrossAxisAlignment.start,
        //                           children: [
        //                             Text(
        //                               "No Data Found",
        //                               // _contractorDetailsModel.results
        //                               //     .educations[index].degreeTitle,
        //                               style: TextStyle(
        //                                   color: Colors.black,
        //                                   fontSize: 16,
        //                                   fontWeight: FontWeight.normal),
        //                             ),
        //                             Row(
        //                               children: [
        //                                 Icon(
        //                                   Icons.home,
        //                                   color: Colors.grey,
        //                                 ),
        //                                 SizedBox(
        //                                   width: 5,
        //                                 ),
        //                                 Text(
        //                                   "No Data Found",
        //                                   // _contractorDetailsModel
        //                                   //     .results
        //                                   //     .educations[index]
        //                                   //     .instituteTitle,
        //                                   style:
        //                                       TextStyle(color: Colors.grey),
        //                                 )
        //                               ],
        //                             ),
        //                             Row(
        //                               children: [
        //                                 Icon(
        //                                   Icons.event,
        //                                   color: Colors.grey,
        //                                 ),
        //                                 SizedBox(
        //                                   width: 5,
        //                                 ),
        //                                 Text(
        //                                   "No Data Found",
        //                                   // "${_contractorDetailsModel.results.educations[index].startDate}" +
        //                                   //     " - " +
        //                                   //     "${_contractorDetailsModel.results.educations[index].endDate}",
        //                                   style:
        //                                       TextStyle(color: Colors.grey),
        //                                 )
        //                               ],
        //                             ),
        //                             SizedBox(
        //                               height: 8,
        //                             ),
        //                             Text(
        //                                 "No Data Found",
        //                                 // _contractorDetailsModel.results
        //                                 //     .educations[index].description,
        //                                 textAlign: TextAlign.justify,
        //                                 style: TextStyle(
        //                                   color: Colors.black,
        //                                 )),
        //                             SizedBox(
        //                               height: 16,
        //                             ),
        //                           ],
        //                         ),
        //                       ),
        //                     );
        //                   },
        //                 ),
        //               ),
        //               SizedBox(
        //                 height: 16,
        //               ),
        //
        //               Padding(
        //                 padding: const EdgeInsets.symmetric(horizontal: 20),
        //                 child: Row(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Container(
        //                         child: Text(
        //                       'Experiences',
        //                       style: TextStyle(
        //                           color: Colors.black,
        //                           fontSize: 18,
        //                           fontWeight: FontWeight.w700),
        //                     )),
        //                   ],
        //                 ),
        //               ),
        //               SizedBox(
        //                 height: 16,
        //               ),
        //               Container(
        //                 height: 220,
        //                 width: Get.width,
        //                 child: ListView.builder(
        //                   scrollDirection: Axis.horizontal,
        //                   itemCount: 0,
        //                   // itemCount: _contractorDetailsModel
        //                   //     .results.experiences.length,
        //                   itemBuilder: (context, index) {
        //                     return Column(
        //                       crossAxisAlignment: CrossAxisAlignment.center,
        //                       children: [
        //                         Card(
        //                           elevation: 4,
        //                           color: Colors.white,
        //                           child: Container(
        //                             height: 210,
        //                             width: Get.width / 1.1,
        //                             child: Padding(
        //                               padding: const EdgeInsets.all(16.0),
        //                               child: SingleChildScrollView(
        //                                 child: Column(
        //                                   crossAxisAlignment:
        //                                       CrossAxisAlignment.start,
        //                                   children: [
        //                                     Text(
        //                                       "No Data Found",
        //                                       // _contractorDetailsModel
        //                                       //     .results
        //                                       //     .experiences[index]
        //                                       //     .jobTitle,
        //                                       style: TextStyle(
        //                                           color: Colors.black,
        //                                           fontSize: 16,
        //                                           fontWeight:
        //                                               FontWeight.normal),
        //                                     ),
        //                                     Row(
        //                                       children: [
        //                                         Icon(
        //                                           Icons.home,
        //                                           color: Colors.grey,
        //                                         ),
        //                                         SizedBox(
        //                                           width: 5,
        //                                         ),
        //                                         Text(
        //                                           "No Data Found",
        //                                           // _contractorDetailsModel
        //                                           //     .results
        //                                           //     .experiences[index]
        //                                           //     .companyTitle,
        //                                           style: TextStyle(
        //                                               color: Colors.grey),
        //                                         )
        //                                       ],
        //                                     ),
        //                                     Row(
        //                                       children: [
        //                                         Icon(
        //                                           Icons.event,
        //                                           color: Colors.grey,
        //                                         ),
        //                                         SizedBox(
        //                                           width: 5,
        //                                         ),
        //                                         Text(
        //                                           "No Data Found",
        //                                           // "${_contractorDetailsModel.results.experiences[index].startDate}" +
        //                                           //     " - " +
        //                                           //     "${_contractorDetailsModel.results.experiences[index].endDate}",
        //                                           style: TextStyle(
        //                                               color: Colors.grey),
        //                                         )
        //                                       ],
        //                                     ),
        //                                     SizedBox(
        //                                       height: 8,
        //                                     ),
        //                                     Text(
        //                                         "No Data Found",
        //                                         // _contractorDetailsModel
        //                                         //     .results
        //                                         //     .experiences[index]
        //                                         //     .description,
        //                                         textAlign: TextAlign.justify,
        //                                         style: TextStyle(
        //                                           color: Colors.black,
        //                                         ))
        //                                   ],
        //                                 ),
        //                               ),
        //                             ),
        //                           ),
        //                         )
        //                       ],
        //                     );
        //                   },
        //                 ),
        //               ),
        //               SizedBox(
        //                 height: 16,
        //               ),
        //               //  Padding(
        //               //   padding: const EdgeInsets.symmetric(horizontal: 20),
        //               //   child: Row(
        //               //     crossAxisAlignment: CrossAxisAlignment.start,
        //               //     children: [
        //               //       Container(
        //               //           child: Text(
        //               //         'Client Feedback',
        //               //         style: TextStyle(
        //               //             color: Colors.black,
        //               //             fontSize: 18,
        //               //             fontWeight: FontWeight.w700),
        //               //       )),
        //               //     ],
        //               //   ),
        //               // ),
        //               // SizedBox(
        //               //   height: 16,
        //               // ),
        //               //   Container(
        //               //   height: 130,
        //               //   width: Get.width/1.09,
        //               //   child: ListView.builder(
        //               //     scrollDirection: Axis.horizontal,
        //               //     itemCount: _contractorDetailsModel.results.feedbackLists.length,
        //               //     itemBuilder: (context,index){
        //               //       return Card(
        //               //               child: Padding(
        //               //                 padding: const EdgeInsets.all(15.0),
        //               //                 child: Column(
        //               //                   mainAxisAlignment:
        //               //                       MainAxisAlignment.center,
        //               //                   children: [
        //               //                     Row(
        //               //                       children: [
        //               //                         Icon(
        //               //                          _contractorDetailsModel.results.feedbackLists[index].verifyStatus==
        //               //                                   true
        //               //                               ? Icons.check_circle
        //               //                               : Icons
        //               //                                   .check_circle_outline,
        //               //                           color: Colors.green,
        //               //                           size: Dimension
        //               //                               .icon_size_medium,
        //               //                         ),
        //               //                         SizedBox(
        //               //                           width: 15.0,
        //               //                         ),
        //               //                         Expanded(
        //               //                           child: Text(
        //               //                          _contractorDetailsModel.results.feedbackLists[index].jobTitle,
        //               //                             overflow: TextOverflow
        //               //                                 .ellipsis,
        //               //                             style: TextStyle(
        //               //                                 fontSize: Dimension
        //               //                                     .text_size_semi_medium),
        //               //                           ),
        //               //                         ),
        //               //                       ],
        //               //                     ),
        //               //                     Row(
        //               //                       children: [
        //               //                         Text(
        //               //                            _contractorDetailsModel.results.feedbackLists[index].clientName,
        //               //                           style: TextStyle(
        //               //                               fontSize: Dimension
        //               //                                   .text_size_extra_large),
        //               //                         ),
        //               //                       ],
        //               //                     ),
        //               //                     Row(
        //               //                       children: [
        //               //                         Icon(
        //               //                           FontAwesomeIcons
        //               //                               .dollarSign,
        //               //                           color: Colors.green,
        //               //                           size: Dimension
        //               //                               .icon_size_medium,
        //               //                         ),
        //               //                         SizedBox(
        //               //                           width: 15.0,
        //               //                         ),
        //               //                         Text(
        //               //                         _contractorDetailsModel.results.feedbackLists[index].rating
        //               //                               .toString(),
        //               //                           style: TextStyle(
        //               //                               fontSize: Dimension
        //               //                                   .text_size_medium_large),
        //               //                         ),
        //               //                       ],
        //               //                     ),
        //               //                     Row(
        //               //                       children: [
        //               //                         Icon(
        //               //                           FontAwesomeIcons.flag,
        //               //                           size: Dimension
        //               //                               .icon_size_medium,
        //               //                         ),
        //               //                         SizedBox(
        //               //                           width: 15.0,
        //               //                         ),
        //               //                         Text(
        //               //                           _contractorDetailsModel.results.feedbackLists[index].location,
        //               //                           style: TextStyle(
        //               //                               fontSize: Dimension
        //               //                                   .text_size_medium_large),
        //               //                         ),
        //               //                       ],
        //               //                     ),
        //               //                     Row(
        //               //                       children: [
        //               //                         Icon(
        //               //                           Icons.copy,
        //               //                           color: Colors.blue,
        //               //                           size: Dimension
        //               //                               .icon_size_medium,
        //               //                         ),
        //               //                         SizedBox(
        //               //                           width: 15.0,
        //               //                         ),
        //               //                         Text(
        //               //                            _contractorDetailsModel.results.feedbackLists[index].jobType,
        //               //                           style: TextStyle(
        //               //                               fontSize: Dimension
        //               //                                   .text_size_medium_large),
        //               //                         ),
        //               //                       ],
        //               //                     ),
        //               //                     Row(
        //               //                       children: [
        //               //                         Icon(
        //               //                           Icons
        //               //                               .access_time_outlined,
        //               //                           color: Colors.red,
        //               //                           size: Dimension
        //               //                               .icon_size_medium,
        //               //                         ),
        //               //                         SizedBox(
        //               //                           width: 15.0,
        //               //                         ),
        //               //                         Text(
        //               //                          _contractorDetailsModel.results.feedbackLists[index].feedback,
        //               //                           style: TextStyle(
        //               //                               fontSize: Dimension
        //               //                                   .text_size_medium_large),
        //               //                         ),
        //               //                       ],
        //               //                     ),
        //               //                   ],
        //               //                 ),
        //               //               ),
        //               //             );
        //               //     },
        //
        //               //   ),
        //               // ),
        //             ],
        //           ),
        //         ),
        //       )),
        );
  }
}
