import 'package:new_fixera/Controller/ContractorController.dart';
import 'package:new_fixera/Controller/ExportController.dart';
import 'package:new_fixera/Controller/SearchController.dart';
import 'package:new_fixera/Model/JobModel/JobDialogModel.dart';
import 'package:new_fixera/Views/Utilities/AppColors.dart';
import 'package:new_fixera/Views/Utilities/AppDimension.dart';
import 'package:new_fixera/Views/Utilities/AppUrl.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:new_fixera/Views/Widget/PrivatePublicDialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import '../../../main.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool? checkedNew;

  var checkCount = 0;
  int grpVal = 0;
  String? applyFilterurl;
  String? add;

  TextEditingController locationController = TextEditingController();
  var _controllervendor = TextEditingController();
  var _controllercontractor = TextEditingController();
  var _controllerBrowseJob = TextEditingController();
  List locationList =[];
  List skillList = [];
  List hourlyOrCategoriesList = [];
  List contracttorTypeOrProjectLengthsList = [];
  List languagesList =[];
  var isFavColors;
  var _id;
  var savedType;
  int? paid;
  var scrollController = ScrollController();

  bool selectAll = false;
  bool testCheck = false;

  bool isChecked = false;

  grpValFunc(value) {
    setState(() {
      print(value);
      print("****************");
      applyFilterurl = '';
      add = '';
      _controllervendor.clear();
      _controllercontractor.clear();
      _controllerBrowseJob.clear();
      locationController.clear();
      locationList.clear();
      skillList.clear();
      hourlyOrCategoriesList.clear();
      contracttorTypeOrProjectLengthsList.clear();
      languagesList.clear();
      searchController.list.clear();
      searchController.page.value = 0;
      grpVal = value;
    });
  }

  List<bool>? _isChecked;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllervendor.clear();
    _controllercontractor.clear();
    _controllerBrowseJob.clear();
    _isChecked = List<bool>.filled(
        contractorController
            .contractorList.value.results!.hourlyRates!.hourlyRatesKey.length,
        false);
  }

  final ContractorController contractorController =
      Get.put(ContractorController());
  final SearchController searchController = Get.put(SearchController());
  final MarketPlaceController marketPlaceController =
      Get.put(MarketPlaceController());
  final JobController jobController = Get.put(JobController());

  List checkAllItem = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text(
          "Start Your Search",
          style: TextStyle(
            color: AppColors.textColorBlack,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.0,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Radio(value: 0, groupValue: grpVal, onChanged: grpValFunc),
                  Text(
                    "Contractor",
                    style: TextStyle(
                      fontSize: Dimension.text_size_small,
                    ),
                  ),
                  Radio(
                    value: 1,
                    groupValue: grpVal,
                    onChanged: grpValFunc,
                  ),
                  Text(
                    "MarketPlace",
                    style: TextStyle(
                      fontSize: Dimension.text_size_small,
                    ),
                  ),
                  Radio(
                    value: 2,
                    groupValue: grpVal,
                    onChanged: grpValFunc,
                  ),
                  Text(
                    userMap!["user_info"]["role_name"] == "contractor"
                        ? "Browse Projects"
                        : "Browse Leads",
                    style: TextStyle(
                      fontSize: Dimension.text_size_small,
                    ),
                  ),
                  SizedBox(
                    width: 2.0,
                  ),
                ],
              ),
            ),
            grpVal == 0
                ? Container(
                    child: Column(
                      children: [
                        Divider(
                          height: 10.0,
                          color: Colors.grey,
                        ),
                        Container(
                          // margin: EdgeInsets.fromLTRB(28, 10, 28, 10),
                          height: 60,
                          child: TextField(
                            controller: _controllercontractor,
                            onChanged: (value) {
                              // searchBoxText = value.trim();
                            },
                            decoration: InputDecoration(
                              hintText: 'Type Keyword here',
                              hintStyle: TextStyle(
                                color: AppColors.textColorGrey,
                                fontSize: Dimension.text_size_small,
                              ),
                              fillColor: AppColors.backgroundColor,
                              filled: false,
                            ),
                          ),
                        ),
                        ExpansionTile(
                          maintainState: true,
                          title: Text("Skill"),
                          children: [
                            Container(
                              //height: 120,
                              child: Obx(
                                () {
                                  if (contractorController.isLoading.value)
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  else
                                    return ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: contractorController
                                          .contractorList
                                          .value
                                          .results!
                                          .skills!
                                          .length,
                                      itemBuilder: (context, index) {
                                        return CheckboxGroup(
                                          key: UniqueKey(),
                                          labels: [
                                            contractorController
                                                .contractorList
                                                .value
                                                .results!
                                                .skills![index]!
                                                .title
                                          ].toList(),
                                          onChange: (bool isChecked,
                                              String label, int inde) {
                                            if (isChecked) {
                                              skillList.add(contractorController
                                                  .contractorList
                                                  .value
                                                  .results!
                                                  .skills![index]
                                                  .slug);
                                              print(skillList);
                                            } else {
                                              skillList.remove(
                                                  contractorController
                                                      .contractorList
                                                      .value
                                                      .results!
                                                      .skills![index]
                                                      .slug);
                                              print(skillList);
                                            }
                                            print(
                                                "isChecked: $isChecked   label: $label  index: $inde");
                                          },
                                        );
                                      },
                                    );
                                },
                              ),
                            ),
                          ],
                        ),
                        ExpansionTile(
                          maintainState: true,
                          title: Text("Location"),
                          children: [
                            Container(
                              //height: 120,
                              child: Obx(
                                () {
                                  if (contractorController.isLoading.value)
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  else
                                    return ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: contractorController
                                          .contractorList
                                          .value
                                          .results!
                                          .locations!
                                          .length,
                                      itemBuilder: (context, index) {
                                        return CheckboxGroup(
                                          key: UniqueKey(),
                                          labels: [
                                            contractorController
                                                .contractorList
                                                .value
                                                .results!
                                                .locations![index]
                                                .title
                                          ].toList(),
                                          onChange: (bool isChecked,
                                              String label, int inde) {
                                            if (isChecked) {
                                              locationList.add(
                                                  contractorController
                                                      .contractorList
                                                      .value
                                                      .results!
                                                      .locations![index]
                                                      .slug);
                                              print(locationList);
                                            } else {
                                              locationList.remove(
                                                  contractorController
                                                      .contractorList
                                                      .value
                                                      .results!
                                                      .locations![index]
                                                      .slug);
                                              print(locationList);
                                            }
                                            print(
                                                "isChecked: $isChecked   label: $label  index: $inde");
                                          },
                                        );
                                      },
                                    );
                                },
                              ),
                            ),
                          ],
                        ),
                        // ExpansionTile(
                        //   maintainState: true,
                        //   title: Text("Hourly Rate"),
                        //   children: [
                        //     Container(
                        //       child: Obx(
                        //         () {
                        //           if (contractorController.isLoading.value)
                        //             return Center(
                        //               child: CircularProgressIndicator(),
                        //             );
                        //           else
                        //             return Column(
                        //               children: [
                        //                 Row(
                        //                   children: [
                        //                     SizedBox(width: 12),
                        //                     Checkbox(
                        //                       value: selectAll,
                        //                       onChanged: (bool newValue) {
                        //                         setState(() {
                        //                           selectAll = newValue;
                        //                           checkedNew = newValue;
                        //                           checkCount = 1;
                        //                           checkAllItem.add(
                        //                               // contractorController
                        //                               //     .contractorList
                        //                               //     .value
                        //                               //     .results
                        //                               //     .hourlyRates
                        //                               //     .hourlyRatesKey
                        //                               contractorController
                        //                                   .contractorList
                        //                                   .value
                        //                                   .results
                        //                                   .hourlyRates
                        //                                   .hourlyRatesValue);
                        //                           print(selectAll.toString() +
                        //                               "**********CHECKBOX**********");
                        //
                        //                           print(checkAllItem);
                        //                         });
                        //                       },
                        //                     ),
                        //                     Text("Select All"),
                        //                   ],
                        //                 ),
                        //                 ListView.builder(
                        //                   physics:
                        //                       NeverScrollableScrollPhysics(),
                        //                   shrinkWrap: true,
                        //                   itemCount: contractorController
                        //                       .contractorList
                        //                       .value
                        //                       .results
                        //                       .hourlyRates
                        //                       .hourlyRatesKey
                        //                       .length,
                        //                   itemBuilder: (context, index) {
                        //                     return CheckboxGroup(
                        //                       labels: [
                        //                         contractorController
                        //                             .contractorList
                        //                             .value
                        //                             .results
                        //                             .hourlyRates
                        //                             .hourlyRatesValue[index]
                        //                       ],
                        //                       // checked: [
                        //                       //   // if(checkCount==1)
                        //                       //   //   {
                        //                       //   //   checkAllItem;
                        //                       //   //   }
                        //                       //
                        //                       //   //want to add checkAllItem list here. first check
                        //                       //   //if checkCount==1 then checkAllItem
                        //                       //   //will be added here
                        //                       // ],
                        //                       onChange: (bool isChecked,
                        //                           String label, int inde) {
                        //                         checkedNew = isChecked;
                        //                         print("checkedNew");
                        //                         print(checkedNew);
                        //
                        //                         if (isChecked) {
                        //                           hourlyOrCategoriesList.add(
                        //                               contractorController
                        //                                       .contractorList
                        //                                       .value
                        //                                       .results
                        //                                       .hourlyRates
                        //                                       .hourlyRatesKey[
                        //                                   index]);
                        //                           print(
                        //                               hourlyOrCategoriesList);
                        //                         } else {
                        //                           hourlyOrCategoriesList.remove(
                        //                               contractorController
                        //                                       .contractorList
                        //                                       .value
                        //                                       .results
                        //                                       .hourlyRates
                        //                                       .hourlyRatesKey[
                        //                                   index]);
                        //                           print(
                        //                               hourlyOrCategoriesList);
                        //                         }
                        //                         print(
                        //                             "isChecked: $isChecked   label: $label  index: $inde");
                        //                       },
                        //                     );
                        //                   },
                        //                 ),
                        //                 // Checkbox(
                        //                 //   value: true,
                        //                 //   onChanged: (bool newValue) {
                        //                 //     setState(() {
                        //                 //       // checkedValue = newValue;
                        //                 //       // print(checkedValue.toString() +
                        //                 //       //     "**********CHECKBOX**********");
                        //                 //     });
                        //                 //   },
                        //                 // ),
                        //               ],
                        //             );
                        //         },
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        //****************
                        ExpansionTile(
                          maintainState: true,
                          title: Text("Hourly Rate"),
                          children: [
                            Container(
                              child: Obx(
                                () {
                                  if (contractorController.isLoading.value)
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  else
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(width: 12),
                                            Checkbox(
                                              value: selectAll,
                                              onChanged: (bool? newValue) {
                                                setState(() {
                                                  selectAll = newValue!;
                                                  testCheck = !testCheck;
                                                  _isChecked =
                                                      List<bool>.filled(
                                                          contractorController
                                                              .contractorList
                                                              .value
                                                              .results!
                                                              .hourlyRates!
                                                              .hourlyRatesKey
                                                              .length,
                                                          newValue);
                                                  print(selectAll.toString() +
                                                      "**********CHECKBOX**********");
                                                });
                                              },
                                            ),
                                            Text("Select All"),
                                          ],
                                        ),
                                        ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: contractorController
                                              .contractorList
                                              .value
                                              .results!
                                              .hourlyRates!
                                              .hourlyRatesKey!
                                              .length,
                                          itemBuilder: (context, index) {
                                            return Row(
                                              children: [
                                                SizedBox(width: 12),
                                                Checkbox(
                                                  value: _isChecked![index],
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      _isChecked![index] =
                                                          newValue!;
                                                    });
                                                    print("testCheck");
                                                    print(testCheck);

                                                    if (newValue == null) {
                                                      hourlyOrCategoriesList.add(
                                                          contractorController
                                                                  .contractorList
                                                                  .value
                                                                  .results!
                                                                  .hourlyRates!
                                                                  .hourlyRatesKey[
                                                              index]);
                                                      print(
                                                          hourlyOrCategoriesList);
                                                    } else {
                                                      hourlyOrCategoriesList.remove(
                                                          contractorController
                                                                  .contractorList
                                                                  .value
                                                                  .results!
                                                                  .hourlyRates!
                                                                  .hourlyRatesKey[
                                                              index]);
                                                      print(
                                                          hourlyOrCategoriesList);
                                                    }
                                                  },
                                                ),
                                                Text(contractorController
                                                    .contractorList
                                                    .value
                                                    .results!
                                                    .hourlyRates!
                                                    .hourlyRatesValue[index]),
                                              ],
                                            );

                                            // return CheckboxGroup(
                                            //   labels: [
                                            //     contractorController
                                            //         .contractorList
                                            //         .value
                                            //         .results
                                            //         .hourlyRates
                                            //         .hourlyRatesValue[index]
                                            //   ],
                                            //   // checked: [
                                            //   //   // if(checkCount==1)
                                            //   //   //   {
                                            //   //   //   checkAllItem;
                                            //   //   //   }
                                            //   //
                                            //   //   //want to add checkAllItem list here. first check
                                            //   //   //if checkCount==1 then checkAllItem
                                            //   //   //will be added here
                                            //   // ],
                                            //   onChange: (bool isChecked,
                                            //       String label, int inde) {
                                            //     checkedNew = isChecked;
                                            //     print("checkedNew");
                                            //     print(checkedNew);
                                            //
                                            //     if (isChecked) {
                                            //       hourlyOrCategoriesList.add(
                                            //           contractorController
                                            //               .contractorList
                                            //               .value
                                            //               .results
                                            //               .hourlyRates
                                            //               .hourlyRatesKey[
                                            //           index]);
                                            //       print(
                                            //           hourlyOrCategoriesList);
                                            //     } else {
                                            //       hourlyOrCategoriesList.remove(
                                            //           contractorController
                                            //               .contractorList
                                            //               .value
                                            //               .results
                                            //               .hourlyRates
                                            //               .hourlyRatesKey[
                                            //           index]);
                                            //       print(
                                            //           hourlyOrCategoriesList);
                                            //     }
                                            //     print(
                                            //         "isChecked: $isChecked   label: $label  index: $inde");
                                            //   },
                                            // );
                                          },
                                        ),
                                        // Checkbox(
                                        //   value: true,
                                        //   onChanged: (bool newValue) {
                                        //     setState(() {
                                        //       // checkedValue = newValue;
                                        //       // print(checkedValue.toString() +
                                        //       //     "**********CHECKBOX**********");
                                        //     });
                                        //   },
                                        // ),
                                      ],
                                    );
                                },
                              ),
                            ),
                          ],
                        ),
                        //****************
                        ExpansionTile(
                          maintainState: true,
                          title: Text("Contractor Type"),
                          children: [
                            Container(
                              //height: 120,
                              child: Obx(
                                () {
                                  if (contractorController.isLoading.value)
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  else
                                    return ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: contractorController
                                          .contractorList
                                          .value
                                          .results!
                                          .contractorType!
                                          .contractorTypeValue
                                          .length,
                                      itemBuilder: (context, index) {
                                        return CheckboxGroup(
                                          labels: [
                                            contractorController
                                                .contractorList
                                                .value
                                                .results!
                                                .contractorType!
                                                .contractorTypeValue[index]

                                            // contractorController
                                            //     .contractorList
                                            //     .value
                                            //     .results
                                            //     .contractorType
                                            //     .contractorTypeKey[index]
                                          ],
                                          onChange: (bool isChecked,
                                              String label, int inde) {
                                            if (isChecked) {
                                              contracttorTypeOrProjectLengthsList
                                                  .add(contractorController
                                                          .contractorList
                                                          .value
                                                          .results!
                                                          .contractorType!
                                                          .contractorTypeKey[
                                                      index]);
                                              print(
                                                  contracttorTypeOrProjectLengthsList);
                                            } else {
                                              contracttorTypeOrProjectLengthsList
                                                  .remove(contractorController
                                                          .contractorList
                                                          .value
                                                          .results!
                                                          .contractorType!
                                                          .contractorTypeKey[
                                                      index]);
                                              print(
                                                  contracttorTypeOrProjectLengthsList);
                                            }
                                            print(
                                                "isChecked: $isChecked   label: $label  index: $inde");
                                          },
                                        );
                                      },
                                    );
                                },
                              ),
                            ),
                          ],
                        ),
                        ExpansionTile(
                          maintainState: true,
                          title: Text("English Level"),
                          children: [
                            Container(
                              //height: 120,
                              child: Obx(
                                () {
                                  if (contractorController.isLoading.value)
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  else
                                    return ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: contractorController
                                          .contractorList
                                          .value
                                          .results!
                                          .englishLevel!
                                          .englishLevelKey!
                                          .length,
                                      itemBuilder: (context, index) {
                                        return CheckboxGroup(
                                          labels: [
                                            contractorController
                                                .contractorList
                                                .value
                                                .results!
                                                .englishLevel!
                                                .englishLevelValue![index]
                                          ],
                                          onChange: (bool isChecked,
                                              String label, int inde) {
                                            if (isChecked) {
                                              languagesList.add(
                                                  contractorController
                                                      .contractorList
                                                      .value
                                                      .results!
                                                      .englishLevel!
                                                      .englishLevelKey![index]);
                                              print(languagesList);
                                            } else {
                                              languagesList.remove(
                                                  contractorController
                                                      .contractorList
                                                      .value
                                                      .results!
                                                      .englishLevel!
                                                      .englishLevelKey![index]);
                                              print(languagesList);
                                            }
                                            print(
                                                "isChecked: $isChecked   label: $label  index: $inde");
                                          },
                                        );
                                      },
                                    );
                                },
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(

                              onTap: () {
                                print(locationList);
                                setState(
                                  () {
                                    print("apply filter");
                                    //print(searchBoxText);
                                    print(skillList);
                                    print(locationList);
                                    print(hourlyOrCategoriesList);
                                    print(contracttorTypeOrProjectLengthsList);
                                    print(languagesList);
                                    searchController.list.clear();
                                    //  dynamically generate Url When Location/skills/hourlyRate/contractorType/englishLevel add then this will be add dynamically and when searchbox add then it will be add in the link
                                    applyFilterurl = _controllercontractor.text.isEmpty
                                        ? AppUrl.searchUrl + "?type=contractor"
                                        : AppUrl.searchUrl +
                                            "?type=contractor&s=${_controllercontractor.text}";
                                    locationList.forEach(
                                      (element) {
                                        add = "&locations[]=$element";
                                        applyFilterurl = applyFilterurl! + add!;
                                      },
                                    );
                                    skillList.forEach(
                                      (element) {
                                        add = "&skills[]=$element";
                                        applyFilterurl = applyFilterurl! + add!;
                                      },
                                    );
                                    hourlyOrCategoriesList.forEach(
                                      (element) {
                                        add = "&hourly_rate[]=$element";
                                        applyFilterurl = applyFilterurl! + add!;
                                      },
                                    );
                                    contracttorTypeOrProjectLengthsList.forEach(
                                      (element) {
                                        add = "&freelaner_type[]=$element";
                                        applyFilterurl = applyFilterurl! + add!;
                                      },
                                    );
                                    languagesList.forEach(
                                      (element) {
                                        add = "&english_level[]=$element";
                                        applyFilterurl = applyFilterurl! + add!;
                                      },
                                    );

                                    print(applyFilterurl);
                                    searchController.page.value = 0;
                                    prefs!.setString("contractorSearchUrl", applyFilterurl!)!;
                                    searchController.fetchContractorSearch(applyFilterurl!);
                                  },
                                );

                                print("Apply Filter");
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  "Apply Filter",
                                  style: TextStyle(
                                    color: AppColors.backgroundColor,
                                    fontSize: Dimension.text_size_medium,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 380,
                          child: Obx(
                            () {
                              return Container(
                                height: 380,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: searchController.list.length == 0
                                          ? Container(
                                              child: searchController
                                                          .isData.value ==
                                                      false
                                                  ? Text("No Contractor Found")
                                                  : Text(""),
                                            )
                                          : ListView.builder(
                                              controller: searchController
                                                  .scrollControllerContractor,
                                              addAutomaticKeepAlives: true,
                                              shrinkWrap: false,
                                              scrollDirection: Axis.vertical,
                                              itemCount:
                                                  searchController.list.length,
                                              itemBuilder: (context, index) {
                                                isFavColors = searchController
                                                    .list[index].isFavourite;

                                                return Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Stack(
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      Positioned(
                                                        child: GestureDetector(
                                                          onTap: () async {
                                                            _id =
                                                                searchController
                                                                    .list[index]
                                                                    .id;

                                                            setState(() {
                                                              Get.toNamed(
                                                                  AppRoutes
                                                                      .CONTRACTORDETAILSPAGE,
                                                                  arguments:
                                                                      _id);
                                                            });
                                                            // _id =
                                                            //     contractorController
                                                            //         .list[
                                                            //             index]
                                                            //         .id;
                                                            //
                                                            // setState(() {
                                                            //   Get.toNamed(
                                                            //       AppRoutes
                                                            //           .CONTRACTORDETAILSPAGE,
                                                            //       arguments:
                                                            //           _id);
                                                            // });
                                                          },
                                                          child: Card(
                                                            color: Colors.white,
                                                            child: SizedBox(
                                                              height: 80,
                                                              child: ListTile(
                                                                title: Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Icon(
                                                                      searchController.list[index].verifyStatus ==
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
                                                                      width: 10,
                                                                    ),
                                                                    Text(
                                                                      searchController.list[index].name.toString().length > 12
                                                                          ? searchController.list[index].name.toString().substring(0, 11) +
                                                                              "..."
                                                                          : searchController
                                                                              .list[index]
                                                                              .name,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16),
                                                                    ),
                                                                  ],
                                                                ),
                                                                subtitle:
                                                                    Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      searchController
                                                                          .list[
                                                                              index]
                                                                          .tagline,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                    Text(
                                                                      "\$ " +
                                                                          searchController
                                                                              .list[index]
                                                                              .hourlyRate
                                                                              .toString() +
                                                                          " /hr |",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                leading:
                                                                    Container(
                                                                  height: 120,
                                                                  width: 60,
                                                                  child: searchController
                                                                              .list[
                                                                                  index]
                                                                              .avatar ==
                                                                          "0"
                                                                      ? Container(
                                                                          color:
                                                                              Colors.grey,
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              '255x255',
                                                                              style: TextStyle(fontSize: 8),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : Image.network(searchController
                                                                          .list[
                                                                              index]
                                                                          .avatar),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: Get.height / 30,
                                                        left: Get.width / 1.1 -
                                                            17,
                                                        child: IconButton(
                                                          onPressed: () async {
                                                            savedType =
                                                                "saved_freelancer";
                                                            await contractorController
                                                                .repository
                                                                .postFavourite(
                                                                    userMap!["user_info"]
                                                                        ["id"],
                                                                    searchController
                                                                        .list[
                                                                            index]
                                                                        .id,
                                                                    savedType);
                                                            setState(
                                                              () {
                                                                searchController
                                                                        .list[index]
                                                                        .isFavourite =
                                                                    !searchController
                                                                        .list[
                                                                            index]
                                                                        .isFavourite;
                                                              },
                                                            );
                                                          },
                                                          icon: CircleAvatar(
                                                            backgroundColor:
                                                                isFavColors ==
                                                                        true
                                                                    ? Colors.red
                                                                    : Colors
                                                                        .grey,
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
                                    ),
                                    Visibility(
                                      visible:
                                          searchController.isLoading2.value,
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
                        )
                      ],
                    ),
                  )
                : grpVal == 1
                    ? Container(
                        width: Get.width,
                        child: Column(
                          children: [
                            Divider(
                              height: 10.0,
                              color: Colors.grey,
                            ),
                            Container(
                              // margin: EdgeInsets.fromLTRB(28, 10, 28, 10),
                              height: 60,
                              child: TextField(
                                controller: _controllervendor,
                                decoration: InputDecoration(
                                  hintText: 'Type Keyword here',
                                  hintStyle: TextStyle(
                                    color: AppColors.textColorGrey,
                                    fontSize: Dimension.text_size_small,
                                  ),
                                  fillColor: AppColors.backgroundColor,
                                  filled: false,
                                ),
                              ),
                            ),
                            ExpansionTile(
                              maintainState: true,
                              title: Text("Location"),
                              children: [
                                Container(
                                  //height: 120,
                                  child: Obx(
                                    () {
                                      if (marketPlaceController.isLoading.value)
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      else
                                        return ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: marketPlaceController
                                              .marketPlaceList
                                              .value
                                              .results!
                                              .locations!
                                              .length,
                                          itemBuilder: (context, index) {
                                            return CheckboxGroup(
                                              labels: [
                                                marketPlaceController
                                                    .marketPlaceList
                                                    .value
                                                    .results!
                                                    .locations![index]
                                                    .title
                                              ].toList(),
                                              onChange: (bool isChecked,
                                                  String label, int inde) {
                                                if (isChecked) {
                                                  locationList.add(
                                                      marketPlaceController
                                                          .marketPlaceList
                                                          .value
                                                          .results!
                                                          .locations![index]
                                                          .slug);
                                                  print(locationList);
                                                } else {
                                                  locationList.remove(
                                                      marketPlaceController
                                                          .marketPlaceList
                                                          .value
                                                          .results!
                                                          .locations![index]
                                                          .slug);
                                                  print(locationList);
                                                }
                                                print(
                                                    "isChecked: $isChecked   label: $label  index: $inde");
                                              },
                                            );
                                          },
                                        );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(

                                  onTap: () {
                                    print(locationList);

                                    setState(
                                      () {
                                        searchController.list.clear();
                                        //dynamically generate Url When Location add then location will be add dynamically and when searchbox add then it will be add in the link
                                        applyFilterurl = _controllervendor.text.isEmpty
                                            ? AppUrl.searchUrl + "?type=vendor"
                                            : AppUrl.searchUrl +
                                                "?type=vendor&s=${_controllervendor.text}";
                                        locationList.forEach(
                                          (element) {
                                            add = "&Location[]=$element";
                                            applyFilterurl = applyFilterurl! + add!;
                                            print(applyFilterurl);
                                          },
                                        );
                                        searchController.page.value = 0;
                                        prefs!.setString(
                                            "marketPlaceSearchUrl", applyFilterurl!);
                                        searchController.fetchVendorSearch(applyFilterurl!);
                                      },
                                    );
                                    // print(searchBoxText);
                                    print("Apply Filter");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      "Apply Filter",
                                      style: TextStyle(
                                        color: AppColors.backgroundColor,
                                        fontSize: Dimension.text_size_medium,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Obx(
                              () {
                                return Container(
                                  height: 380,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: searchController.list.length == 0
                                            ? Container(
                                                child: searchController
                                                            .isData.value ==
                                                        false
                                                    ? Text("No Data Found")
                                                    : Text(""),
                                              )
                                            : ListView.builder(
                                                controller: searchController
                                                    .scrollControllerMarketPlace,
                                                itemCount: searchController
                                                    .list.length,
                                                itemBuilder: (context, index) {
                                                  isFavColors = searchController
                                                      .list[index].isFavourite;

                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: searchController.list[index].banner ==
                                                                            "0"
                                                                        ? Container(
                                                                            color:
                                                                                Colors.grey,
                                                                            height: 90.0,
                                                                            // width: Get.width / 1.1,
                                                                            child: Center(
                                                                                child: Image.asset(
                                                                              "images/fixera_logo.png",
                                                                              height: 60,
                                                                              width: 120,
                                                                            )))
                                                                        : CachedNetworkImage(
                                                                            fit:
                                                                                BoxFit.fill,
                                                                            height:
                                                                                90,
                                                                            imageUrl:
                                                                                searchController.list[index].banner.toString(),
                                                                            placeholder: (context, url) =>
                                                                                Align(),
                                                                            errorWidget: (context, url, error) =>
                                                                                Icon(Icons.error),
                                                                          ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Column(
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                            100.0,
                                                                        width:
                                                                            120.0,
                                                                        color: Colors
                                                                            .white,
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
                                                                            searchController.list[index].verifyStatus == true
                                                                                ? Icons.check_circle
                                                                                : Icons.check_circle_outline,
                                                                            color:
                                                                                Colors.green,
                                                                            size:
                                                                                Dimension.icon_size_medium,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                15.0,
                                                                          ),
                                                                          Container(
                                                                            width:
                                                                                200,
                                                                            child:
                                                                                Text(
                                                                              searchController.list[index].name,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: TextStyle(
                                                                                fontSize: Dimension.text_size_medium,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            20.0,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          GestureDetector(
                                                                            child:
                                                                                Text(
                                                                              "Open Jobs",
                                                                              style: TextStyle(color: Colors.blue),
                                                                            ),
                                                                            onTap:
                                                                                () async {
                                                                              _id = searchController.list[index].id;

                                                                              setState(
                                                                                () {
                                                                                  Get.toNamed(AppRoutes.OPENJOB, arguments: _id);
                                                                                },
                                                                              );
                                                                              //Get.toNamed(AppRoutes.JOB);
                                                                            },
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                15.0,
                                                                          ),
                                                                          Container(
                                                                            width:
                                                                                1,
                                                                            height:
                                                                                20.0,
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                15.0,
                                                                          ),
                                                                          GestureDetector(
                                                                            child:
                                                                                Text(
                                                                              "Full Profile",
                                                                              style: TextStyle(
                                                                                color: Colors.blue,
                                                                              ),
                                                                            ),
                                                                            onTap:
                                                                                () async {
                                                                              _id = searchController.list[index].id;

                                                                              setState(
                                                                                () {
                                                                                  Get.toNamed(AppRoutes.FULLPROFILEPAGE, arguments: _id);
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
                                                          child: searchController
                                                                      .list[
                                                                          index]
                                                                      .avatar ==
                                                                  "0"
                                                              ? Container(
                                                                  height: 90.0,
                                                                  width: 90.0,
                                                                  color: Colors
                                                                          .grey[
                                                                      200],
                                                                  child: Center(
                                                                    child: Text(
                                                                      "255 X 255",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            Dimension.text_size_small,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              : CachedNetworkImage(
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  height: 90,
                                                                  width: 90,
                                                                  imageUrl: searchController
                                                                      .list[
                                                                          index]
                                                                      .avatar
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
                                                        ),
                                                        Positioned(
                                                          top: Get.height / 5.5,
                                                          left: Get.width / 10,
                                                          child: IconButton(
                                                            onPressed:
                                                                () async {
                                                              savedType =
                                                                  "saved_employers";
                                                              await searchController
                                                                  .repository
                                                                  .postFavourite(
                                                                      userMap!["user_info"]
                                                                          [
                                                                          "id"],
                                                                      searchController
                                                                          .list[
                                                                              index]
                                                                          .id,
                                                                      savedType);
                                                              setState(
                                                                () {
                                                                  searchController
                                                                          .list[
                                                                              index]
                                                                          .isFavourite =
                                                                      !searchController
                                                                          .list[
                                                                              index]
                                                                          .isFavourite;
                                                                },
                                                              );
                                                            },
                                                            icon: CircleAvatar(
                                                              backgroundColor:
                                                                  isFavColors ==
                                                                          true
                                                                      ? AppColors
                                                                          .textColorRed
                                                                      : Colors
                                                                          .grey,
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
                                                }),
                                      ),
                                      Visibility(
                                        visible:
                                            searchController.isLoading1.value,
                                        child: Align(
                                          child: CupertinoActivityIndicator(),
                                          alignment: Alignment.bottomCenter,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      )
                    : Container(
                        child: Column(
                          children: [
                            Divider(
                              height: 10.0,
                              color: Colors.grey,
                            ),
                            Container(
                              // margin: EdgeInsets.fromLTRB(28, 10, 28, 10),
                              height: 60,
                              child: TextField(
                                controller: _controllerBrowseJob,
                                decoration: InputDecoration(
                                  hintText: 'Type Keyword here',
                                  hintStyle: TextStyle(
                                    color: AppColors.textColorGrey,
                                    fontSize: Dimension.text_size_small,
                                  ),
                                  fillColor: AppColors.backgroundColor,
                                  filled: false,
                                ),
                              ),
                            ),
                            ExpansionTile(
                              maintainState: true,
                              title: Text("Skill"),
                              children: [
                                Container(
                                  //height: 120,
                                  child: Obx(
                                    () {
                                      if (jobController.isLoading.value)
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      else
                                        return ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: jobController.jobList.value!
                                              .results!.skills!.length,
                                          itemBuilder: (context, index) {
                                            return CheckboxGroup(
                                              key: UniqueKey(),
                                              labels: [
                                                jobController.jobList.value
                                                    .results!.skills![index].title
                                              ].toList(),
                                              onChange: (bool isChecked,
                                                  String label, int inde) {
                                                if (isChecked) {
                                                  skillList.add(jobController
                                                      .jobList
                                                      .value
                                                      .results!
                                                      .skills![index]
                                                      .slug);
                                                  print(skillList);
                                                } else {
                                                  skillList.remove(jobController
                                                      .jobList
                                                      .value
                                                      .results!
                                                      .skills![index]
                                                      .slug);
                                                  print(skillList);
                                                }
                                                print(
                                                    "isChecked: $isChecked   label: $label  index: $inde");
                                              },
                                            );
                                          },
                                        );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            ExpansionTile(
                              maintainState: true,
                              title: Text("Location"),
                              children: [
                                Container(
                                  //height: 120,
                                  child: Obx(
                                    () {
                                      if (jobController.isLoading.value)
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      else
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: TextFormField(
                                            controller: locationController,
                                            // onEditingComplete: () {
                                            //   if (isChecked) {
                                            //     locationList.add(
                                            //         jobController
                                            //             .jobList
                                            //             .value
                                            //             .results
                                            //             .locations
                                            //             );
                                            //     print(locationList);
                                            //   } else {
                                            //     locationList.remove(
                                            //         jobController
                                            //             .jobList
                                            //             .value
                                            //             .results
                                            //             .locations);
                                            //     print(locationList);
                                            //   }
                                            // },
                                            decoration:
                                                InputDecoration.collapsed(
                                                    hintStyle: TextStyle(
                                                        color: Colors.black45,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 16),
                                                    hintText: "Postal Code"),
                                          ),
                                        );

                                      //   ListView.builder(
                                      //   physics: NeverScrollableScrollPhysics(),
                                      //   shrinkWrap: true,
                                      //   itemCount: jobController.jobList
                                      //       .value.results.locations.length,
                                      //   itemBuilder: (context, index) {
                                      //     return CheckboxGroup(
                                      //       key: UniqueKey(),
                                      //       labels: [
                                      //         jobController
                                      //             .jobList
                                      //             .value
                                      //             .results
                                      //             .locations[index]
                                      //             .title
                                      //       ].toList(),
                                      //       onChange: (bool isChecked,
                                      //           String label, int inde) {
                                      //         if (isChecked) {
                                      //           locationList.add(
                                      //               jobController
                                      //                   .jobList
                                      //                   .value
                                      //                   .results
                                      //                   .locations[index]
                                      //                   .slug);
                                      //           print(locationList);
                                      //         } else {
                                      //           locationList.remove(
                                      //               jobController
                                      //                   .jobList
                                      //                   .value
                                      //                   .results
                                      //                   .locations[index]
                                      //                   .slug);
                                      //           print(locationList);
                                      //         }
                                      //         print(
                                      //             "isChecked: $isChecked   label: $label  index: $inde");
                                      //       },
                                      //     );
                                      //   },
                                      // );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            ExpansionTile(
                              maintainState: true,
                              title: Text("Categories"),
                              children: [
                                Container(
                                  // height: 120,
                                  child: Obx(
                                    () {
                                      if (jobController.isLoading.value)
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      else
                                        return ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: jobController.jobList.value!
                                              .results!.categories!.length,
                                          itemBuilder: (context, index) {
                                            return CheckboxGroup(
                                              labels: [
                                                jobController
                                                            .jobList
                                                            .value
                                                            .results!
                                                            .categories![index]
                                                            .title!
                                                            .length <
                                                        22
                                                    ? jobController
                                                        .jobList
                                                        .value
                                                        .results!
                                                        .categories![index]
                                                        .title
                                                    : jobController
                                                            .jobList
                                                            .value
                                                            .results!
                                                            .categories![index]
                                                            .title!
                                                            .substring(0, 21) +
                                                        "..."
                                              ].toList(),
                                              onChange: (bool isChecked,
                                                  String label, int inde) {
                                                if (isChecked) {
                                                  hourlyOrCategoriesList.add(
                                                      jobController
                                                          .jobList
                                                          .value
                                                          .results!
                                                          .categories![index]
                                                          .slug);
                                                  print(hourlyOrCategoriesList);
                                                } else {
                                                  hourlyOrCategoriesList.remove(
                                                      jobController
                                                          .jobList
                                                          .value
                                                          .results!
                                                          .categories![index]
                                                          .slug);
                                                  print(hourlyOrCategoriesList);
                                                }
                                                print(
                                                    "isChecked: $isChecked   label: $label  index: $inde");
                                              },
                                            );
                                          },
                                        );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            ExpansionTile(
                              maintainState: true,
                              title: Text("Project Lengths"),
                              children: [
                                Container(
                                  //height: 120,
                                  child: Obx(
                                    () {
                                      if (jobController.isLoading.value)
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      else
                                        return ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: jobController
                                              .jobList
                                              .value
                                              .results!
                                              .projectLength!
                                              .projectLengthsKey!
                                              .length,
                                          itemBuilder: (context, index) {
                                            return CheckboxGroup(
                                              labels: [
                                                jobController
                                                    .jobList
                                                    .value
                                                    .results!
                                                    .projectLength!
                                                    .projectLengthsValue![index]
                                              ],
                                              onChange: (bool isChecked,
                                                  String label, int inde) {
                                                if (isChecked) {
                                                  contracttorTypeOrProjectLengthsList
                                                      .add(jobController
                                                              .jobList
                                                              .value
                                                              .results!
                                                              .projectLength!
                                                              .projectLengthsKey![
                                                          index]);
                                                  print(
                                                      contracttorTypeOrProjectLengthsList);
                                                } else {
                                                  contracttorTypeOrProjectLengthsList
                                                      .remove(jobController
                                                              .jobList
                                                              .value
                                                              .results!
                                                              .projectLength!
                                                              .projectLengthsKey![
                                                          index]);
                                                  print(
                                                      contracttorTypeOrProjectLengthsList);
                                                }
                                                print(
                                                    "isChecked: $isChecked   label: $label  index: $inde");
                                              },
                                            );
                                          },
                                        );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            ExpansionTile(
                              maintainState: true,
                              title: Text("Languages"),
                              children: [
                                Container(
                                  //height: 120,
                                  child: Obx(
                                    () {
                                      if (jobController.isLoading.value)
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      else
                                        return ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: jobController.jobList.value
                                              .results!.languages!.length,
                                          itemBuilder: (context, index) {
                                            return CheckboxGroup(
                                              labels: [
                                                jobController
                                                    .jobList
                                                    .value
                                                    .results!
                                                    .languages![index]
                                                    .title
                                              ].toList(),
                                              onChange: (bool isChecked,
                                                  String label, int inde) {
                                                if (isChecked) {
                                                  languagesList.add(
                                                      jobController
                                                          .jobList
                                                          .value
                                                          .results!
                                                          .languages![index]
                                                          .slug);
                                                  print(languagesList);
                                                } else {
                                                  languagesList.remove(
                                                      jobController
                                                          .jobList
                                                          .value
                                                          .results!
                                                          .languages![index]
                                                          .slug);
                                                  print(languagesList);
                                                }
                                                print(
                                                    "isChecked: $isChecked   label: $label  index: $inde");
                                              },
                                            );
                                          },
                                        );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(


                                  ///TODO CHANGE BLUE
                                  onTap: () {
                                    print(locationList);
                                    setState(
                                      () {
                                        print("URl: " + AppUrl.searchUrl);
                                        print("URl2: " +
                                            AppUrl.searchUrl +
                                            "?type=job&s=${_controllerBrowseJob.text}&postal_code=${locationController.text}");
                                        print("apply filter");
                                        //print(searchBoxText);
                                        print(skillList);
                                        print(locationList);
                                        print(hourlyOrCategoriesList);
                                        print(
                                            contracttorTypeOrProjectLengthsList);
                                        print(languagesList);
                                        searchController.list.clear();
                                        //  dynamically generate Url When Location/skills/hourlyRate/contractorType/englishLevel add then this will be add dynamically and when searchbox add then it will be add in the link
                                        applyFilterurl = _controllerBrowseJob.text.isEmpty
                                            ? AppUrl.searchUrl + "?type=job"
                                            : AppUrl.searchUrl +
                                                "?type=job&s=${_controllerBrowseJob.text}&postal_code=${locationController.text}";
                                        locationList.forEach(
                                          (element) {
                                            add = "&locations[]=$element";
                                            //add = "&postal_code=$element";
                                            applyFilterurl = applyFilterurl! + add!;
                                          },
                                        );
                                        skillList.forEach(
                                          (element) {
                                            add = "&skills[]=$element";
                                            applyFilterurl = applyFilterurl! + add!;
                                          },
                                        );
                                        hourlyOrCategoriesList.forEach(
                                          (element) {
                                            add = "&category[]=$element";
                                            applyFilterurl = applyFilterurl! + add!;
                                          },
                                        );
                                        contracttorTypeOrProjectLengthsList
                                            .forEach(
                                          (element) {
                                            add = "&project_lengths[]=$element";
                                            applyFilterurl = applyFilterurl! + add!;
                                          },
                                        );
                                        languagesList.forEach(
                                          (element) {
                                            add = "&languages[]=$element";
                                            applyFilterurl = applyFilterurl! + add!;
                                          },
                                        );

                                        print(applyFilterurl);
                                        searchController.page.value = 0;
                                        prefs!.setString("jobPageUrl", applyFilterurl!);
                                        searchController.fetchJobSearch(applyFilterurl!);
                                      },
                                    );

                                    print("Apply Filter");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      "Apply Filter",
                                      style: TextStyle(
                                        color: AppColors.backgroundColor,
                                        fontSize: Dimension.text_size_medium,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Obx(
                              () {
                                return Container(
                                  height: 380,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: searchController.list.length == 0
                                            ? Container(
                                                child: searchController
                                                            .isData.value ==
                                                        false
                                                    ? Text("No Data Found")
                                                    : Text(""),
                                              )
                                            : ListView.builder(
                                                controller: searchController
                                                    .scrollControllerjobs,
                                                addAutomaticKeepAlives: true,
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: false,
                                                itemCount: searchController
                                                    .list.length,
                                                itemBuilder: (context, index) {
                                                  isFavColors = searchController
                                                      .list[index].isFavourite;
                                                  paid = searchController
                                                      .list[index]
                                                      .paymentStatus;

                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(18.0),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                      searchController.list[index].verifyStatus ==
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
                                                                      width:
                                                                          15.0,
                                                                    ),
                                                                    Text(
                                                                      searchController
                                                                          .list[
                                                                              index]
                                                                          .title,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              Dimension.text_size_semi_medium),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      searchController
                                                                          .list[
                                                                              index]
                                                                          .employer,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              Dimension.text_size_large),
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
                                                                      width:
                                                                          15.0,
                                                                    ),
                                                                    Text(
                                                                      searchController
                                                                          .list[
                                                                              index]
                                                                          .price
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              Dimension.text_size_medium_large),
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
                                                                      width:
                                                                          15.0,
                                                                    ),
                                                                    Text(
                                                                      searchController
                                                                          .list[
                                                                              index]
                                                                          .location,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              Dimension.text_size_medium_large),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .copy,
                                                                      color: Colors
                                                                          .blue,
                                                                      size: Dimension
                                                                          .icon_size_medium,
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          15.0,
                                                                    ),
                                                                    Text(
                                                                      searchController
                                                                          .list[
                                                                              index]
                                                                          .type,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              Dimension.text_size_medium_large),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .access_time_outlined,
                                                                      color: Colors
                                                                          .red,
                                                                      size: Dimension
                                                                          .icon_size_medium,
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          15.0,
                                                                    ),
                                                                    Text(
                                                                      searchController
                                                                          .list[
                                                                              index]
                                                                          .duration,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              Dimension.text_size_medium_large),
                                                                    ),
                                                                  ],
                                                                ),
                                                                userMap!["user_info"]
                                                                            [
                                                                            "role_name"] ==
                                                                        "contractor"
                                                                    ? GestureDetector(

                                                                        child:
                                                                            Text(
                                                                          "View Jobs",
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.w700,
                                                                              color: Colors.white),
                                                                        ),
                                                                        onTap:
                                                                            () {
                                                                          if (searchController.list[index].paymentStatus ==
                                                                              1) {
                                                                            String
                                                                                url =
                                                                                searchController.list[index].jobUrl;
                                                                            setState(
                                                                              () {
                                                                                Get.toNamed(
                                                                                  AppRoutes.JOBDETAILSPAGE,
                                                                                  arguments: [
                                                                                    "AlreadyPaid",
                                                                                    url
                                                                                  ],
                                                                                );
                                                                              },
                                                                            );
                                                                          } else if (searchController.list[index].paymentStatus ==
                                                                              0) {
                                                                            var id =
                                                                                searchController.list[index].id;
                                                                            String
                                                                                slug =
                                                                                searchController.list[index].slug;

                                                                            movetoDialog(id,
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
                                                          child: Image.asset(
                                                            'images/premium.jpg',
                                                            height: 22,
                                                            width: 22,
                                                          ),
                                                        ),
                                                        Positioned(
                                                          top: Get.height / 10,
                                                          left:
                                                              Get.width / 1.1 -
                                                                  8,
                                                          child: IconButton(
                                                            onPressed:
                                                                () async {
                                                              savedType =
                                                                  "saved_jobs";
                                                              await jobController
                                                                  .repository
                                                                  .postFavourite(
                                                                      userMap!["user_info"]
                                                                          [
                                                                          "id"],
                                                                      searchController
                                                                          .list[
                                                                              index]
                                                                          .id,
                                                                      savedType);
                                                              setState(
                                                                () {
                                                                  searchController
                                                                          .list[
                                                                              index]
                                                                          .isFavourite =
                                                                      !searchController
                                                                          .list[
                                                                              index]
                                                                          .isFavourite;
                                                                },
                                                              );
                                                            },
                                                            icon: CircleAvatar(
                                                              backgroundColor:
                                                                  isFavColors ==
                                                                          true
                                                                      ? Colors
                                                                          .red
                                                                      : Colors
                                                                          .grey,
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
                                      ),
                                      Visibility(
                                        visible:
                                            searchController.isLoadign3.value,
                                        child: Align(
                                          child: CupertinoActivityIndicator(),
                                          alignment: Alignment.bottomCenter,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
          ],
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
        await marketPlaceController.repository.postJobDialog(jobId);
    jobController.jobDialogModel.value = jobDialogModel;
    jobController.update();
  }
}
