import 'dart:convert';
import 'package:new_fixera/Controller/ContractorController.dart';
import 'package:new_fixera/Model/PostAJobAndLeadModel/PostAjobAndLead.dart';
import 'package:new_fixera/SharedPreferance/shared_preferance.dart';
import 'package:new_fixera/Views/Screens/BottomNavigationScreen/BottomNavigationPage.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:new_fixera/Views/Widget/address_search.dart';
import 'package:new_fixera/Views/Widget/place_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:new_fixera/Views/Widget/NormalAppBar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:new_fixera/Controller/PostAJobController.dart';
import 'package:new_fixera/Controller/PostALeadController.dart';
import 'package:new_fixera/main.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import "package:get/get.dart" hide MultipartFile, Response, FormData;
import 'package:async/async.dart';
import "package:path/path.dart";

class PostAJobAndLead extends StatefulWidget {
  PostAJobAndLead({Key? key}) : super(key: key);

  @override
  _PostAJobAndLeadState createState() => _PostAJobAndLeadState();
}

class _PostAJobAndLeadState extends State<PostAJobAndLead> {
  List imageFiles = [];

 // GlobalKey<HtmlEditorState> htmlEditor = GlobalKey();

  @override
  Future<void> fileAppDialouge(context, title, message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Text(message),
          ),
          actions: <Widget>[
            Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                TextButton(
                  child: Text(
                    "Camera",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    //getImageFromCamera();
                  },
                ),
                TextButton(
                  child: Text(
                    "Gallery",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    filePick();
                  },
                ),
              ]),
              TextButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ]),
          ],
        );
      },
    );
  }

  //dynamic view attribute
  var customPriceType;
  var projectDuration;
  var freelancerLevel;
  var mesurement;
  var locations;
  TextEditingController _jobTitle = TextEditingController();
  TextEditingController _customPriceValue = TextEditingController();
  TextEditingController _measurementValue = TextEditingController();

  // TextEditingController _projectCost = TextEditingController();
  TextEditingController _projectDetails = TextEditingController();
  TextEditingController postalCode = TextEditingController();
  final addresss = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  String? convertedDateTimeStart;
  String? convertedDateTimeEnd;
  final ContractorController contractorController =
      Get.put(ContractorController());
  final PostAJobController postAJobController = Get.find<PostAJobController>();
  final PostALeadController postALeadController =
      Get.find<PostALeadController>();
  List categoryList = [];

  //List subCategoryList = List();
  List languageList = [];
  List skillList = [];
  bool isFeatured = false;
  bool isStatus = false;
  bool isAttachements = false;
  List<PlatformFile> filepick = [];
  List<String> fileShow = [];
  File? singlefile;
  int visible = 0;
  bool _isLabour = false;

  bool _isMaterial = false;

  ///addtional Lead Atrribute
  TextEditingController _credits = TextEditingController();
  TextEditingController _squares = TextEditingController();
  TextEditingController _leadContactName = TextEditingController();
  TextEditingController _leadContactNumber = TextEditingController();
  TextEditingController _leadContactEmail = TextEditingController();
  DateTime? setDateAndTime;
  String? convertedSetDateAndTime;
  var leadExpiration;
  var haveInsurance;
  var isThereIsuranceCom;
  var numberofStories;
  var ageOfRoofs;
  var typeOfRoofs;
  var propertyType;
  var projectCostMul;
  PostAJobAndLeadModel? _postAJobAndLeadModel;
  bool? _submitData;

  var loaderStatus;

  void displayMessageProject(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          AlertDialog dialog = AlertDialog(
            content: Text(
              "Please Select at least one Project Type",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            actions: [
              GestureDetector(
                child: Text("Ok"),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
          return dialog;
        });
  }

  void displayMessageLead(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          AlertDialog dialog = AlertDialog(
            content: const Text(
              "Please Select at least one Lead Type",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            actions: [
              GestureDetector(
                child: Text("Ok"),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
          return dialog;
        });
  }

  ////new text editing controllers
  TextEditingController nameControllerNew = TextEditingController();
  TextEditingController phoneControllerNew = TextEditingController();
  TextEditingController addressControllerNew = TextEditingController();
  TextEditingController projectTitleControllerNew = TextEditingController();
  TextEditingController customPriceTypeControllerNew = TextEditingController();
  TextEditingController projectDurationControllerNew = TextEditingController();
  TextEditingController measurementControllerNew = TextEditingController();
  TextEditingController constuctionLevelControllerNew = TextEditingController();
  TextEditingController priceValueControllerNew = TextEditingController();
  TextEditingController measurementValueControllerNew = TextEditingController();
  TextEditingController startDateControllerNew = TextEditingController();
  TextEditingController endDateControllerNew = TextEditingController();
  TextEditingController projectCostControllerNew = TextEditingController();
  TextEditingController biddingPricePublicControllerNew =
      TextEditingController();
  TextEditingController biddingPricePrivateControllerNew =
      TextEditingController();
  TextEditingController projectCategoryControllerNew = TextEditingController();
  TextEditingController languageControllerNew = TextEditingController();
  String projectDetailController = "";
  TextEditingController locationControllerNew = TextEditingController();
  TextEditingController postalCodeControllerNew = TextEditingController();
  TextEditingController yourAddressCodeControllerNew = TextEditingController();
  bool isSwitchedFeature = false;
  bool isSwitchedAttachments = false;
  List<File> selectedFileList = [];

  @override
  void dispose() {
    addresss.dispose();
    super.dispose();
  }

  @override
  void initState() {
    loaderStatus = false;
    nameControllerNew.text =
        "${userMap!["user_info"]['first_name']} ${userMap!["user_info"]['last_name']}";
    phoneControllerNew.text = "${userMap!["user_info"]['phone']}";
    super.initState();
  }

  int customPriceInialVal = 0;
  int measurementValInialVal = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  userMap!["user_info"]["role_name"] == "contractor" ? Text("Post a project") : Text("Post a Lead"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            userMap!["user_info"]["role_name"] == "contractor"
                ? contractorJobView(context)
                : vendorJobView(context),
            // Container(
            //         child: SingleChildScrollView(
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: [
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 24),
            //                 child: Row(
            //                   children: [
            //                     Container(
            //                       color: Color(0xffA0C828),
            //                       height: 60,
            //                       width: 3,
            //                     ),
            //                     SizedBox(
            //                       width: 10,
            //                     ),
            //                     Text(
            //                       "Lead Type",
            //                       style: TextStyle(
            //                           color: Colors.black,
            //                           fontWeight: FontWeight.bold,
            //                           fontSize: Dimension.text_size_medium),
            //                     )
            //                   ],
            //                 ),
            //               ),
            //               Row(
            //                 children: [
            //                   SizedBox(
            //                     width: 30,
            //                   ),
            //                   Row(
            //                     children: [
            //                       Checkbox(
            //                           value: _isLabour,
            //                           onChanged: (v) {
            //                             setState(() {
            //                               _isLabour = !_isLabour;
            //                             });
            //                           }),
            //                       Text("Labor"),
            //                     ],
            //                   ),
            //                   Row(
            //                     children: [
            //                       Checkbox(
            //                           value: _isMaterial,
            //                           onChanged: (v) {
            //                             setState(() {
            //                               _isMaterial = !_isMaterial;
            //                             });
            //                           }),
            //                       Text("Material"),
            //                     ],
            //                   ),
            //                 ],
            //               ),
            //               SizedBox(height: 20),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 24),
            //                 child: Row(
            //                   children: [
            //                     Container(
            //                       color: Color(0xffA0C828),
            //                       height: 60,
            //                       width: 3,
            //                     ),
            //                     SizedBox(
            //                       width: 10,
            //                     ),
            //                     Text(
            //                       "Project Categories",
            //                       style: TextStyle(
            //                           color: Colors.black,
            //                           fontWeight: FontWeight.bold,
            //                           fontSize: Dimension.text_size_medium),
            //                     )
            //                   ],
            //                 ),
            //               ),
            //               SizedBox(height: 16),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 24),
            //                 child: Container(
            //                     decoration: BoxDecoration(
            //                         border: Border.all(
            //                             color: Colors.grey, width: 1)),
            //                     child: ListTile(
            //                       title: categoryList.length == null
            //                           ? Text(
            //                               "Categories",
            //                               style: TextStyle(fontSize: 14),
            //                             )
            //                           : Text(categoryList.length.toString() +
            //                               " Selected"),
            //                       trailing: IconButton(
            //                         onPressed: () {
            //                           showDialog(
            //                             barrierDismissible: false,
            //                             context: context,
            //                             builder: (context) {
            //                               return ButtonBarTheme(
            //                                   data: ButtonBarThemeData(
            //                                       alignment:
            //                                           MainAxisAlignment.center),
            //                                   child: AlertDialog(
            //                                     actions: [
            //                                       Column(
            //                                         mainAxisAlignment:
            //                                             MainAxisAlignment
            //                                                 .center,
            //                                         children: [
            //                                           Container(
            //                                             height: Get.height / 2,
            //                                             width: Get.width,
            //                                             child: Obx(() {
            //                                               if (postALeadController
            //                                                   .isLoading.value)
            //                                                 return Center(
            //                                                   child:
            //                                                       CircularProgressIndicator(),
            //                                                 );
            //                                               else
            //                                                 return ListView
            //                                                     .builder(
            //                                                         itemCount: postALeadController
            //                                                             .postALeadList
            //                                                             .value
            //                                                             .results
            //                                                             .categories
            //                                                             .keys
            //                                                             .length,
            //                                                         itemBuilder:
            //                                                             (context,
            //                                                                 index) {
            //                                                           List maptoListCategories = postALeadController
            //                                                               .postALeadList
            //                                                               .value
            //                                                               .results
            //                                                               .categories
            //                                                               .values
            //                                                               .toList();
            //                                                           List maptoListCategoriesKeys = postALeadController
            //                                                               .postALeadList
            //                                                               .value
            //                                                               .results
            //                                                               .categories
            //                                                               .keys
            //                                                               .toList();
            //                                                           return CheckboxGroup(
            //                                                             labelStyle:
            //                                                                 TextStyle(fontSize: 11),
            //                                                             labels: [
            //                                                               maptoListCategories[
            //                                                                   index]
            //                                                             ],
            //                                                             onChange: (bool isChecked,
            //                                                                 String
            //                                                                     label,
            //                                                                 int inde) {
            //                                                               if (isChecked) {
            //                                                                 categoryList.add(maptoListCategoriesKeys[index]);
            //                                                                 print(categoryList);
            //                                                               } else {
            //                                                                 categoryList.remove(maptoListCategoriesKeys[index]);
            //                                                                 print(categoryList);
            //                                                               }
            //                                                               print(
            //                                                                   "isChecked: $isChecked   label: $label  index: $inde");
            //                                                             },
            //                                                           );
            //                                                         });
            //                                             }),
            //                                           ),
            //                                           Container(
            //                                             width: Get.width / 1.2,
            //                                             child: Row(
            //                                               //mainAxisSize: MainAxisSize.max,
            //                                               mainAxisAlignment:
            //                                                   MainAxisAlignment
            //                                                       .center,
            //                                               crossAxisAlignment:
            //                                                   CrossAxisAlignment
            //                                                       .center,
            //                                               children: <Widget>[
            //                                                 Container(
            //                                                   width:
            //                                                       Get.width / 3,
            //                                                   child:
            //                                                       GestureDetector(
            //                                                     child: new Text(
            //                                                       'Cancel',
            //                                                       style: TextStyle(
            //                                                           color: Colors
            //                                                               .white),
            //                                                     ),
            //                                                     color: Color(
            //                                                         0xFF121A21),
            //                                                     shape:
            //                                                         new RoundedRectangleBorder(
            //                                                       borderRadius:
            //                                                           new BorderRadius
            //                                                                   .circular(
            //                                                               30.0),
            //                                                     ),
            //                                                     onPressed: () {
            //                                                       categoryList
            //                                                           .clear();
            //                                                       setState(
            //                                                           () {});
            //                                                       Get.back();
            //                                                     },
            //                                                   ),
            //                                                 ),
            //                                                 SizedBox(
            //                                                     width:
            //                                                         Get.width *
            //                                                             0.02),
            //                                                 Container(
            //                                                   width:
            //                                                       Get.width / 3,
            //                                                   child:
            //                                                       GestureDetector(
            //                                                     child: new Text(
            //                                                       'Save',
            //                                                       style: TextStyle(
            //                                                           color: Colors
            //                                                               .white),
            //                                                     ),
            //                                                     color: Color(
            //                                                         0xFF121A21),
            //                                                     shape:
            //                                                         new RoundedRectangleBorder(
            //                                                       borderRadius:
            //                                                           new BorderRadius
            //                                                                   .circular(
            //                                                               30.0),
            //                                                     ),
            //                                                     onPressed: () {
            //                                                       print(
            //                                                           categoryList);
            //                                                       setState(
            //                                                           () {});
            //                                                       Get.back();
            //                                                     },
            //                                                   ),
            //                                                 ),
            //                                               ],
            //                                             ),
            //                                           )
            //                                         ],
            //                                       ),
            //                                     ],
            //                                   ));
            //                             },
            //                           );
            //                         },
            //                         icon: Icon(Icons.arrow_drop_down),
            //                       ),
            //                     )),
            //               ),
            //               SizedBox(height: 16),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 24),
            //                 child: Row(
            //                   children: [
            //                     Container(
            //                       color: Color(0xffA0C828),
            //                       height: 60,
            //                       width: 3,
            //                     ),
            //                     SizedBox(
            //                       width: 10,
            //                     ),
            //                     Text(
            //                       "Lead Description",
            //                       style: TextStyle(
            //                           color: Colors.black,
            //                           fontWeight: FontWeight.bold,
            //                           fontSize: Dimension.text_size_medium),
            //                     )
            //                   ],
            //                 ),
            //               ),
            //               SizedBox(height: 16),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 24),
            //                 child: TextField(
            //                   controller: _jobTitle,
            //                   autofocus: false,
            //                   focusNode: FocusNode(),
            //                   decoration: InputDecoration(
            //                       hintText: 'Lead Title',
            //                       border: OutlineInputBorder()),
            //                 ),
            //               ),
            //               SizedBox(height: 16),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 24),
            //                 child: Container(
            //                   padding: EdgeInsets.all(6),
            //                   decoration: BoxDecoration(
            //                       border:
            //                           Border.all(color: Colors.grey, width: 1)),
            //                   child: DropdownButton(
            //                     isExpanded: true,
            //                     hint: Text(
            //                       "Select Custom Price",
            //                       style: TextStyle(fontSize: 14),
            //                     ),
            //                     underline: SizedBox(),
            //                     items: postALeadController.postALeadList.value
            //                         .results.priceType.values
            //                         .map((values) {
            //                       return DropdownMenuItem(
            //                         value: values,
            //                         child: Padding(
            //                           padding: const EdgeInsets.only(
            //                               left: 8.0, right: 8.0),
            //                           child: Text(
            //                             values,
            //                             style: TextStyle(),
            //                           ),
            //                         ),
            //                       );
            //                     }).toList(),
            //                     value: customPriceType,
            //                     onChanged: (valueSelectedByUser) {
            //                       setState(() {
            //                         customPriceType = valueSelectedByUser;
            //                         print(customPriceType);
            //                       });
            //                     },
            //                   ),
            //                 ),
            //               ),
            //               SizedBox(height: 16),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 24),
            //                 child: TextField(
            //                   autofocus: false,
            //                   focusNode: FocusNode(),
            //                   keyboardType: TextInputType.number,
            //                   controller: _customPriceValue,
            //                   decoration: InputDecoration(
            //                       hintText: 'Custom Price Value',
            //                       border: OutlineInputBorder()),
            //                 ),
            //               ),
            //               SizedBox(height: 16),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 24),
            //                 child: Container(
            //                   padding: EdgeInsets.all(6),
            //                   decoration: BoxDecoration(
            //                       border:
            //                           Border.all(color: Colors.grey, width: 1)),
            //                   child: DropdownButton(
            //                     isExpanded: true,
            //                     hint: Text(
            //                       "Select Lead Duration",
            //                       style: TextStyle(fontSize: 14),
            //                     ),
            //                     items: postALeadController.postALeadList.value
            //                         .results.projectDuration.keys
            //                         .map((values) {
            //                       return DropdownMenuItem(
            //                         value: values,
            //                         child: Padding(
            //                           padding: const EdgeInsets.only(
            //                               left: 8.0, right: 8.0),
            //                           child: Text(
            //                             postALeadController.postALeadList.value
            //                                 .results.projectDuration[values],
            //                             style: TextStyle(),
            //                           ),
            //                         ),
            //                       );
            //                     }).toList(),
            //                     value: projectDuration,
            //                     underline: SizedBox(),
            //                     onChanged: (valueSelectedByUser) {
            //                       setState(() {
            //                         projectDuration = valueSelectedByUser;
            //                         print(projectDuration);
            //                       });
            //                     },
            //                   ),
            //                 ),
            //               ),
            //               SizedBox(height: 16),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 24),
            //                 child: Container(
            //                   padding: EdgeInsets.all(6),
            //                   decoration: BoxDecoration(
            //                       border:
            //                           Border.all(color: Colors.grey, width: 1)),
            //                   child: DropdownButton(
            //                     isExpanded: true,
            //                     hint: Text(
            //                       "Select Construction Level",
            //                       style: TextStyle(fontSize: 14),
            //                     ),
            //                     items: postALeadController.postALeadList.value
            //                         .results.freelancerLevel.keys
            //                         .map((values) {
            //                       return DropdownMenuItem(
            //                         value: values,
            //                         child: Padding(
            //                           padding: const EdgeInsets.only(
            //                               left: 8.0, right: 8.0),
            //                           child: Text(
            //                             postALeadController.postALeadList.value
            //                                 .results.freelancerLevel[values],
            //                             style: TextStyle(),
            //                           ),
            //                         ),
            //                       );
            //                     }).toList(),
            //                     value: freelancerLevel,
            //                     underline: SizedBox(),
            //                     onChanged: (valueSelectedByUser) {
            //                       setState(() {
            //                         freelancerLevel = valueSelectedByUser;
            //                         print(freelancerLevel);
            //                       });
            //                     },
            //                   ),
            //                 ),
            //               ),
            //               SizedBox(height: 16),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 24),
            //                 child: Container(
            //                   padding: EdgeInsets.all(6),
            //                   decoration: BoxDecoration(
            //                       border:
            //                           Border.all(color: Colors.grey, width: 1)),
            //                   child: DropdownButton(
            //                     isExpanded: true,
            //                     hint: Text(
            //                       "Select Measurement",
            //                       style: TextStyle(fontSize: 14),
            //                     ),
            //                     items: postALeadController.postALeadList.value
            //                         .results.measurement.keys
            //                         .map((values) {
            //                       return DropdownMenuItem(
            //                         value: values,
            //                         child: Padding(
            //                           padding: const EdgeInsets.only(
            //                               left: 8.0, right: 8.0),
            //                           child: Text(
            //                             postALeadController.postALeadList.value
            //                                 .results.measurement[values],
            //                             style: TextStyle(),
            //                           ),
            //                         ),
            //                       );
            //                     }).toList(),
            //                     value: mesurement,
            //                     underline: SizedBox(),
            //                     onChanged: (valueSelectedByUser) {
            //                       setState(() {
            //                         mesurement = valueSelectedByUser;
            //                         print(mesurement);
            //                       });
            //                     },
            //                   ),
            //                 ),
            //               ),
            //               SizedBox(height: 16),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 24),
            //                 child: TextField(
            //                   autofocus: false,
            //                   focusNode: FocusNode(),
            //                   controller: _measurementValue,
            //                   keyboardType: TextInputType.number,
            //                   onChanged: (value) {
            //                     setState(() {
            //                       projectCostMul = int.parse(_squares.text) *
            //                           int.parse(value);
            //                       FocusScope.of(context).nextFocus();
            //                       print(projectCostMul);
            //                     });
            //                   },
            //                   decoration: InputDecoration(
            //                       hintText: 'Measurement Value',
            //                       border: OutlineInputBorder()),
            //                 ),
            //               ),
            //               SizedBox(height: 16),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 24),
            //                 child: GestureDetector(
            //                   onTap: () {
            //                     showDatePicker(
            //                             context: context,
            //                             initialDate: _startDate == null
            //                                 ? DateTime.now()
            //                                 : _startDate,
            //                             firstDate: DateTime(2021),
            //                             lastDate: DateTime(2030))
            //                         .then((date) {
            //                       setState(() {
            //                         _startDate = date;
            //                         convertedDateTimeStart =
            //                             "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
            //                       });
            //                     });
            //                   },
            //                   child: Container(
            //                       decoration: BoxDecoration(
            //                           border: Border.all(
            //                               color: Colors.grey, width: 1)),
            //                       child: ListTile(
            //                         title: convertedDateTimeStart == null
            //                             ? Text(
            //                                 "Please Select Your Start Date",
            //                                 style: TextStyle(fontSize: 14),
            //                               )
            //                             : Text(
            //                                 convertedDateTimeStart.toString()),
            //                         trailing: IconButton(
            //                           onPressed: () {
            //                             showDatePicker(
            //                                     context: context,
            //                                     initialDate: _startDate == null
            //                                         ? DateTime.now()
            //                                         : _startDate,
            //                                     firstDate: DateTime(2021),
            //                                     lastDate: DateTime(2030))
            //                                 .then((date) {
            //                               setState(() {
            //                                 _startDate = date;
            //                                 convertedDateTimeStart =
            //                                     "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
            //                               });
            //                             });
            //                           },
            //                           icon: Icon(Icons.date_range),
            //                         ),
            //                       )),
            //                 ),
            //               ),
            //               SizedBox(height: 16),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 24),
            //                 child: GestureDetector(
            //                   onTap: () {
            //                     showDatePicker(
            //                             context: context,
            //                             initialDate: _endDate == null
            //                                 ? DateTime.now()
            //                                 : _endDate,
            //                             firstDate: DateTime(2021),
            //                             lastDate: DateTime(2030))
            //                         .then((date) {
            //                       setState(() {
            //                         _endDate = date;
            //                         convertedDateTimeEnd =
            //                             "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
            //                       });
            //                     });
            //                   },
            //                   child: Container(
            //                       decoration: BoxDecoration(
            //                           border: Border.all(
            //                               color: Colors.grey, width: 1)),
            //                       child: ListTile(
            //                         title: convertedDateTimeEnd == null
            //                             ? Text(
            //                                 "Please Select Your End Date",
            //                                 style: TextStyle(fontSize: 14),
            //                               )
            //                             : Text(convertedDateTimeEnd.toString()),
            //                         trailing: IconButton(
            //                           onPressed: () {
            //                             showDatePicker(
            //                                     context: context,
            //                                     initialDate: _endDate == null
            //                                         ? DateTime.now()
            //                                         : _endDate,
            //                                     firstDate: DateTime(2021),
            //                                     lastDate: DateTime(2030))
            //                                 .then((date) {
            //                               setState(() {
            //                                 _endDate = date;
            //                                 convertedDateTimeEnd =
            //                                     "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
            //                               });
            //                             });
            //                           },
            //                           icon: Icon(Icons.date_range),
            //                         ),
            //                       )),
            //                 ),
            //               ),
            //               SizedBox(height: 16),
            //               Container(
            //                 child: Column(
            //                   children: [
            //                     Padding(
            //                       padding: const EdgeInsets.symmetric(
            //                           horizontal: 24),
            //                       child: Row(
            //                         children: [
            //                           Container(
            //                             color: Color(0xffA0C828),
            //                             height: 60,
            //                             width: 3,
            //                           ),
            //                           SizedBox(
            //                             width: 10,
            //                           ),
            //                           Column(
            //                             crossAxisAlignment:
            //                                 CrossAxisAlignment.start,
            //                             children: [
            //                               Text(
            //                                 "Additional Lead Details",
            //                                 style: TextStyle(
            //                                     color: Colors.black,
            //                                     fontWeight: FontWeight.bold,
            //                                     fontSize:
            //                                         Dimension.text_size_small),
            //                               ),
            //                               Text(
            //                                 "(Optional)",
            //                                 style: TextStyle(
            //                                     color: Colors.black,
            //                                     fontWeight: FontWeight.bold,
            //                                     fontSize:
            //                                         Dimension.text_size_small),
            //                               ),
            //                             ],
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                     SizedBox(height: 16),
            //                     Padding(
            //                       padding: const EdgeInsets.symmetric(
            //                           horizontal: 24),
            //                       child: Container(
            //                         padding: EdgeInsets.all(6),
            //                         decoration: BoxDecoration(
            //                             border: Border.all(
            //                                 color: Colors.grey, width: 1)),
            //                         child: DropdownButton(
            //                           isExpanded: true,
            //                           hint: Text(
            //                             "Select Lead Expiration",
            //                             style: TextStyle(fontSize: 14),
            //                           ),
            //                           items: postALeadController.postALeadList
            //                               .value.results.leadExpiration.keys
            //                               .map((values) {
            //                             return DropdownMenuItem(
            //                               value: values,
            //                               child: Padding(
            //                                 padding: const EdgeInsets.only(
            //                                     left: 8.0, right: 8.0),
            //                                 child: Text(
            //                                   values,
            //                                   style: TextStyle(),
            //                                 ),
            //                               ),
            //                             );
            //                           }).toList(),
            //                           value: leadExpiration,
            //                           underline: SizedBox(),
            //                           onChanged: (valueSelectedByUser) {
            //                             setState(() {
            //                               leadExpiration = valueSelectedByUser;
            //                               print(leadExpiration);
            //                             });
            //                           },
            //                         ),
            //                       ),
            //                     ),
            //                     SizedBox(height: 16),
            //                     Padding(
            //                       padding: const EdgeInsets.symmetric(
            //                           horizontal: 24),
            //                       child: TextField(
            //                         autofocus: false,
            //                         focusNode: FocusNode(),
            //                         keyboardType: TextInputType.number,
            //                         controller: _credits,
            //                         decoration: InputDecoration(
            //                             hintText:
            //                                 'How many Credits e.g. \$1 dollar = 1 Credit',
            //                             border: OutlineInputBorder()),
            //                       ),
            //                     ),
            //                     SizedBox(height: 16),
            //                     Padding(
            //                       padding: const EdgeInsets.symmetric(
            //                           horizontal: 24),
            //                       child: Container(
            //                         padding: EdgeInsets.all(6),
            //                         decoration: BoxDecoration(
            //                             border: Border.all(
            //                                 color: Colors.grey, width: 1)),
            //                         child: DropdownButton(
            //                           isExpanded: true,
            //                           hint: Text(
            //                             "Do They Have Insurance",
            //                             style: TextStyle(fontSize: 14),
            //                           ),
            //                           items: postALeadController.postALeadList
            //                               .value.results.leadInsurance.keys
            //                               .map((values) {
            //                             return DropdownMenuItem(
            //                               value: values,
            //                               child: Padding(
            //                                 padding: const EdgeInsets.only(
            //                                     left: 8.0, right: 8.0),
            //                                 child: Text(
            //                                   values,
            //                                   style: TextStyle(),
            //                                 ),
            //                               ),
            //                             );
            //                           }).toList(),
            //                           value: haveInsurance,
            //                           underline: SizedBox(),
            //                           onChanged: (valueSelectedByUser) {
            //                             setState(() {
            //                               haveInsurance = valueSelectedByUser;
            //                               print(haveInsurance);
            //                             });
            //                           },
            //                         ),
            //                       ),
            //                     ),
            //                     SizedBox(height: 16),
            //                     Padding(
            //                       padding: const EdgeInsets.symmetric(
            //                           horizontal: 24),
            //                       child: Container(
            //                         padding: EdgeInsets.all(6),
            //                         decoration: BoxDecoration(
            //                             border: Border.all(
            //                                 color: Colors.grey, width: 1)),
            //                         child: DropdownButton(
            //                           isExpanded: true,
            //                           hint: Text(
            //                             "Who Is There Insurance Company",
            //                             style: TextStyle(fontSize: 14),
            //                           ),
            //                           items: postALeadController.postALeadList
            //                               .value.results.insuranceCompany.keys
            //                               .map((values) {
            //                             return DropdownMenuItem(
            //                               value: values,
            //                               child: Padding(
            //                                 padding: const EdgeInsets.only(
            //                                     left: 8.0, right: 8.0),
            //                                 child: Text(
            //                                   values.toString(),
            //                                   style: TextStyle(),
            //                                 ),
            //                               ),
            //                             );
            //                           }).toList(),
            //                           value: isThereIsuranceCom,
            //                           underline: SizedBox(),
            //                           onChanged: (valueSelectedByUser) {
            //                             setState(() {
            //                               isThereIsuranceCom =
            //                                   valueSelectedByUser;
            //                               print(isThereIsuranceCom);
            //                             });
            //                           },
            //                         ),
            //                       ),
            //                     ),
            //                     SizedBox(height: 16),
            //                     Padding(
            //                       padding: const EdgeInsets.symmetric(
            //                           horizontal: 24),
            //                       child: TextField(
            //                         autofocus: false,
            //                         focusNode: FocusNode(),
            //                         keyboardType: TextInputType.number,
            //                         controller: _squares,
            //                         onChanged: (value) {
            //                           setState(() {
            //                             projectCostMul = int.parse(_measurementValue
            //                                     .text) /* *
            //                                 int.parse(value)*/
            //                                 ;
            //                             print(projectCostMul);
            //                             // FocusScope.of(context).nextFocus();
            //                           });
            //                         },
            //                         decoration: InputDecoration(
            //                             hintText: 'How Many Squares',
            //                             border: OutlineInputBorder()),
            //                       ),
            //                     ),
            //                     SizedBox(height: 16),
            //                     Padding(
            //                       padding: const EdgeInsets.symmetric(
            //                           horizontal: 24),
            //                       child: Container(
            //                         padding: EdgeInsets.all(6),
            //                         decoration: BoxDecoration(
            //                             border: Border.all(
            //                                 color: Colors.grey, width: 1)),
            //                         child: DropdownButton(
            //                           isExpanded: true,
            //                           hint: Text(
            //                             "Number of Stories",
            //                             style: TextStyle(fontSize: 14),
            //                           ),
            //                           items: postALeadController.postALeadList
            //                               .value.results.noOfStories
            //                               .map((values) {
            //                             return DropdownMenuItem(
            //                               value: values,
            //                               child: Padding(
            //                                 padding: const EdgeInsets.only(
            //                                     left: 8.0, right: 8.0),
            //                                 child: Text(
            //                                   values.toString(),
            //                                   style: TextStyle(),
            //                                 ),
            //                               ),
            //                             );
            //                           }).toList(),
            //                           value: numberofStories,
            //                           underline: SizedBox(),
            //                           onChanged: (valueSelectedByUser) {
            //                             setState(() {
            //                               numberofStories = valueSelectedByUser;
            //                               print(numberofStories);
            //                             });
            //                           },
            //                         ),
            //                       ),
            //                     ),
            //                     SizedBox(height: 16),
            //                     Padding(
            //                       padding: const EdgeInsets.symmetric(
            //                           horizontal: 24),
            //                       child: Container(
            //                         padding: EdgeInsets.all(6),
            //                         decoration: BoxDecoration(
            //                             border: Border.all(
            //                                 color: Colors.grey, width: 1)),
            //                         child: DropdownButton(
            //                           isExpanded: true,
            //                           hint: Text(
            //                             "Age of Roof",
            //                             style: TextStyle(fontSize: 14),
            //                           ),
            //                           items: postALeadController
            //                               .postALeadList.value.results.ageOfRoof
            //                               .map((values) {
            //                             return DropdownMenuItem(
            //                               value: values,
            //                               child: Padding(
            //                                 padding: const EdgeInsets.only(
            //                                     left: 8.0, right: 8.0),
            //                                 child: Text(
            //                                   values,
            //                                   style: TextStyle(),
            //                                 ),
            //                               ),
            //                             );
            //                           }).toList(),
            //                           value: ageOfRoofs,
            //                           underline: SizedBox(),
            //                           onChanged: (valueSelectedByUser) {
            //                             setState(() {
            //                               ageOfRoofs = valueSelectedByUser;
            //                               print(ageOfRoofs);
            //                             });
            //                           },
            //                         ),
            //                       ),
            //                     ),
            //                     SizedBox(height: 16),
            //                     Padding(
            //                       padding: const EdgeInsets.symmetric(
            //                           horizontal: 24),
            //                       child: Container(
            //                         padding: EdgeInsets.all(6),
            //                         decoration: BoxDecoration(
            //                             border: Border.all(
            //                                 color: Colors.grey, width: 1)),
            //                         child: DropdownButton(
            //                           isExpanded: true,
            //                           hint: Text(
            //                             "Type of Roof",
            //                             style: TextStyle(fontSize: 14),
            //                           ),
            //                           items: postALeadController.postALeadList
            //                               .value.results.typeOfRoof.keys
            //                               .map((values) {
            //                             return DropdownMenuItem(
            //                               value: values,
            //                               child: Padding(
            //                                 padding: const EdgeInsets.only(
            //                                     left: 8.0, right: 8.0),
            //                                 child: Text(
            //                                   postALeadController
            //                                       .postALeadList
            //                                       .value
            //                                       .results
            //                                       .typeOfRoof[values]
            //                                       .toString(),
            //                                   style: TextStyle(),
            //                                 ),
            //                               ),
            //                             );
            //                           }).toList(),
            //                           value: typeOfRoofs,
            //                           underline: SizedBox(),
            //                           onChanged: (valueSelectedByUser) {
            //                             setState(() {
            //                               typeOfRoofs = valueSelectedByUser;
            //                               print(typeOfRoofs);
            //                             });
            //                           },
            //                         ),
            //                       ),
            //                     ),
            //                     SizedBox(height: 16),
            //                     Padding(
            //                       padding: const EdgeInsets.symmetric(
            //                           horizontal: 24),
            //                       child: Container(
            //                         padding: EdgeInsets.all(6),
            //                         decoration: BoxDecoration(
            //                             border: Border.all(
            //                                 color: Colors.grey, width: 1)),
            //                         child: DropdownButton(
            //                           isExpanded: true,
            //                           hint: Text(
            //                             "Property Type",
            //                             style: TextStyle(fontSize: 14),
            //                           ),
            //                           items: postALeadController.postALeadList
            //                               .value.results.propertyType.keys
            //                               .map((values) {
            //                             return DropdownMenuItem(
            //                               value: values,
            //                               child: Padding(
            //                                 padding: const EdgeInsets.only(
            //                                     left: 8.0, right: 8.0),
            //                                 child: Text(
            //                                   postALeadController
            //                                       .postALeadList
            //                                       .value
            //                                       .results
            //                                       .propertyType[values]
            //                                       .toString(),
            //                                   style: TextStyle(),
            //                                 ),
            //                               ),
            //                             );
            //                           }).toList(),
            //                           value: propertyType,
            //                           underline: SizedBox(),
            //                           onChanged: (valueSelectedByUser) {
            //                             setState(() {
            //                               propertyType = valueSelectedByUser;
            //                               print(propertyType);
            //                             });
            //                           },
            //                         ),
            //                       ),
            //                     ),
            //                     SizedBox(height: 16),
            //                     Padding(
            //                       padding: const EdgeInsets.symmetric(
            //                           horizontal: 24),
            //                       child: TextField(
            //                         autofocus: false,
            //                         focusNode: FocusNode(),
            //                         controller: _leadContactName,
            //                         decoration: InputDecoration(
            //                             hintText: 'Lead Contact Name',
            //                             border: OutlineInputBorder()),
            //                       ),
            //                     ),
            //                     SizedBox(height: 16),
            //                     Padding(
            //                       padding: const EdgeInsets.symmetric(
            //                           horizontal: 24),
            //                       child: TextField(
            //                         autofocus: false,
            //                         focusNode: FocusNode(),
            //                         controller: _leadContactNumber,
            //                         decoration: InputDecoration(
            //                             hintText: 'Lead Contact Phone Number',
            //                             border: OutlineInputBorder()),
            //                       ),
            //                     ),
            //                     SizedBox(height: 16),
            //                     Padding(
            //                       padding: const EdgeInsets.symmetric(
            //                           horizontal: 24),
            //                       child: TextField(
            //                         autofocus: false,
            //                         focusNode: FocusNode(),
            //                         controller: _leadContactEmail,
            //                         decoration: InputDecoration(
            //                             hintText: 'Lead Contact Email',
            //                             border: OutlineInputBorder()),
            //                       ),
            //                     ),
            //                     SizedBox(height: 16),
            //                     Padding(
            //                       padding: const EdgeInsets.symmetric(
            //                           horizontal: 24),
            //                       child: GestureDetector(
            //                         onTap: () {
            //                           showDatePicker(
            //                                   context: context,
            //                                   initialDate:
            //                                       setDateAndTime == null
            //                                           ? DateTime.now()
            //                                           : setDateAndTime,
            //                                   firstDate: DateTime(2021),
            //                                   lastDate: DateTime(2030))
            //                               .then((date) {
            //                             setState(() {
            //                               setDateAndTime = date;
            //                               convertedSetDateAndTime =
            //                                   "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
            //                             });
            //                           });
            //                         },
            //                         child: Container(
            //                             decoration: BoxDecoration(
            //                                 border: Border.all(
            //                                     color: Colors.grey, width: 1)),
            //                             child: ListTile(
            //                               title: convertedSetDateAndTime == null
            //                                   ? Text(
            //                                       "Set Date and Time",
            //                                       style:
            //                                           TextStyle(fontSize: 14),
            //                                     )
            //                                   : Text(convertedSetDateAndTime
            //                                       .toString()),
            //                               trailing: IconButton(
            //                                 onPressed: () {
            //                                   showDatePicker(
            //                                           context: context,
            //                                           initialDate:
            //                                               setDateAndTime == null
            //                                                   ? DateTime.now()
            //                                                   : setDateAndTime,
            //                                           firstDate: DateTime(2021),
            //                                           lastDate: DateTime(2030))
            //                                       .then((date) {
            //                                     setState(() {
            //                                       setDateAndTime = date;
            //                                       convertedSetDateAndTime =
            //                                           "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
            //                                     });
            //                                   });
            //                                 },
            //                                 icon: Icon(Icons.date_range),
            //                               ),
            //                             )),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               SizedBox(height: 16),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 24),
            //                 child: Row(
            //                   children: [
            //                     Container(
            //                       color: Color(0xffA0C828),
            //                       height: 60,
            //                       width: 3,
            //                     ),
            //                     SizedBox(
            //                       width: 10,
            //                     ),
            //                     Text(
            //                       "Project Cost",
            //                       style: TextStyle(
            //                           color: Colors.black,
            //                           fontWeight: FontWeight.bold,
            //                           fontSize: Dimension.text_size_medium),
            //                     )
            //                   ],
            //                 ),
            //               ),
            //               SizedBox(height: 16),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 24),
            //                 child: TextField(
            //                   //controller: _projectCostVendor,
            //                   keyboardType: TextInputType.number,
            //                   autofocus: false,
            //                   focusNode: FocusNode(),
            //                   onChanged: (value) {
            //                     projectCostMul = value.toString();
            //
            //                     print("Project Cost is ${projectCostMul}");
            //                   },
            //                   decoration: InputDecoration(
            //                       hintText: 'Project Cost',
            //                       border: OutlineInputBorder()),
            //                 ),
            //               ),
            //               SizedBox(height: 16),
            //               // Padding(
            //               //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //               //   child: Row(
            //               //     children: [
            //               //       Container(
            //               //         color: Color(0xffA0C828),
            //               //         height: 60,
            //               //         width: 3,
            //               //       ),
            //               //       SizedBox(
            //               //         width: 10,
            //               //       ),
            //               //       Text(
            //               //         "Project Categories",
            //               //         style: TextStyle(
            //               //             color: Colors.black,
            //               //             fontWeight: FontWeight.bold,
            //               //             fontSize: Dimension.text_size_medium),
            //               //       )
            //               //     ],
            //               //   ),
            //               // ),
            //               // SizedBox(height: 16),
            //               // Padding(
            //               //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //               //   child: Container(
            //               //       decoration: BoxDecoration(
            //               //           border: Border.all(color: Colors.grey, width: 1)),
            //               //       child: ListTile(
            //               //         title: categoryList.length == null
            //               //             ? Text(
            //               //                 "Categories",
            //               //                 style: TextStyle(fontSize: 14),
            //               //               )
            //               //             : Text(categoryList.length.toString() +
            //               //                 " Selected"),
            //               //         trailing: IconButton(
            //               //           onPressed: () {
            //               //             showDialog(
            //               //               barrierDismissible: false,
            //               //               context: context,
            //               //               builder: (context) {
            //               //                 return ButtonBarTheme(
            //               //                     data: ButtonBarThemeData(
            //               //                         alignment:
            //               //                             MainAxisAlignment.center),
            //               //                     child: AlertDialog(
            //               //                       actions: [
            //               //                         Column(
            //               //                           mainAxisAlignment:
            //               //                               MainAxisAlignment.center,
            //               //                           children: [
            //               //                             Container(
            //               //                               height: Get.height / 2,
            //               //                               width: Get.width,
            //               //                               child: Obx(() {
            //               //                                 if (postALeadController
            //               //                                     .isLoading.value)
            //               //                                   return Center(
            //               //                                     child:
            //               //                                         CircularProgressIndicator(),
            //               //                                   );
            //               //                                 else
            //               //                                   return ListView.builder(
            //               //                                       itemCount:
            //               //                                           postALeadController
            //               //                                               .postALeadList
            //               //                                               .value
            //               //                                               .results
            //               //                                               .categories
            //               //                                               .keys
            //               //                                               .length,
            //               //                                       itemBuilder:
            //               //                                           (context, index) {
            //               //                                         List
            //               //                                             maptoListCategories =
            //               //                                             postALeadController
            //               //                                                 .postALeadList
            //               //                                                 .value
            //               //                                                 .results
            //               //                                                 .categories
            //               //                                                 .values
            //               //                                                 .toList();
            //               //                                         List
            //               //                                             maptoListCategoriesKeys =
            //               //                                             postALeadController
            //               //                                                 .postALeadList
            //               //                                                 .value
            //               //                                                 .results
            //               //                                                 .categories
            //               //                                                 .keys
            //               //                                                 .toList();
            //               //                                         return CheckboxGroup(
            //               //                                           labelStyle:
            //               //                                               TextStyle(
            //               //                                                   fontSize:
            //               //                                                       11),
            //               //                                           labels: [
            //               //                                             maptoListCategories[
            //               //                                                 index]
            //               //                                           ],
            //               //                                           onChange: (bool
            //               //                                                   isChecked,
            //               //                                               String label,
            //               //                                               int inde) {
            //               //                                             if (isChecked) {
            //               //                                               categoryList.add(
            //               //                                                   maptoListCategoriesKeys[
            //               //                                                       index]);
            //               //                                               print(
            //               //                                                   categoryList);
            //               //                                             } else {
            //               //                                               categoryList.remove(
            //               //                                                   maptoListCategoriesKeys[
            //               //                                                       index]);
            //               //                                               print(
            //               //                                                   categoryList);
            //               //                                             }
            //               //                                             print(
            //               //                                                 "isChecked: $isChecked   label: $label  index: $inde");
            //               //                                           },
            //               //                                         );
            //               //                                       });
            //               //                               }),
            //               //                             ),
            //               //                             Container(
            //               //                               width: Get.width / 1.2,
            //               //                               child: Row(
            //               //                                 //mainAxisSize: MainAxisSize.max,
            //               //                                 mainAxisAlignment:
            //               //                                     MainAxisAlignment
            //               //                                         .center,
            //               //                                 crossAxisAlignment:
            //               //                                     CrossAxisAlignment
            //               //                                         .center,
            //               //                                 children: <Widget>[
            //               //                                   Container(
            //               //                                     width: Get.width / 3,
            //               //                                     child: GestureDetector(
            //               //                                       child: new Text(
            //               //                                         'Cancel',
            //               //                                         style: TextStyle(
            //               //                                             color: Colors
            //               //                                                 .white),
            //               //                                       ),
            //               //                                       color:
            //               //                                           Color(0xFF121A21),
            //               //                                       shape:
            //               //                                           new RoundedRectangleBorder(
            //               //                                         borderRadius:
            //               //                                             new BorderRadius
            //               //                                                     .circular(
            //               //                                                 30.0),
            //               //                                       ),
            //               //                                       onPressed: () {
            //               //                                         categoryList
            //               //                                             .clear();
            //               //                                         setState(() {});
            //               //                                         Get.back();
            //               //                                       },
            //               //                                     ),
            //               //                                   ),
            //               //                                   SizedBox(
            //               //                                       width:
            //               //                                           Get.width * 0.02),
            //               //                                   Container(
            //               //                                     width: Get.width / 3,
            //               //                                     child: GestureDetector(
            //               //                                       child: new Text(
            //               //                                         'Save',
            //               //                                         style: TextStyle(
            //               //                                             color: Colors
            //               //                                                 .white),
            //               //                                       ),
            //               //                                       color:
            //               //                                           Color(0xFF121A21),
            //               //                                       shape:
            //               //                                           new RoundedRectangleBorder(
            //               //                                         borderRadius:
            //               //                                             new BorderRadius
            //               //                                                     .circular(
            //               //                                                 30.0),
            //               //                                       ),
            //               //                                       onPressed: () {
            //               //                                         print(categoryList);
            //               //                                         setState(() {});
            //               //                                         Get.back();
            //               //                                       },
            //               //                                     ),
            //               //                                   ),
            //               //                                 ],
            //               //                               ),
            //               //                             )
            //               //                           ],
            //               //                         ),
            //               //                       ],
            //               //                     ));
            //               //               },
            //               //             );
            //               //           },
            //               //           icon: Icon(Icons.arrow_drop_down),
            //               //         ),
            //               //       )),
            //               // ),
            //               // SizedBox(height: 16),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 24),
            //                 child: Row(
            //                   children: [
            //                     Container(
            //                       color: Color(0xffA0C828),
            //                       height: 60,
            //                       width: 3,
            //                     ),
            //                     SizedBox(
            //                       width: 10,
            //                     ),
            //                     Text(
            //                       "Languages",
            //                       style: TextStyle(
            //                           color: Colors.black,
            //                           fontWeight: FontWeight.bold,
            //                           fontSize: Dimension.text_size_medium),
            //                     )
            //                   ],
            //                 ),
            //               ),
            //               SizedBox(height: 16),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 24),
            //                 child: Container(
            //                     decoration: BoxDecoration(
            //                         border: Border.all(
            //                             color: Colors.grey, width: 1)),
            //                     child: ListTile(
            //                       title: languageList.length == null
            //                           ? Text(
            //                               "Categories",
            //                               style: TextStyle(fontSize: 14),
            //                             )
            //                           : Text(languageList.length.toString() +
            //                               " Selected"),
            //                       trailing: IconButton(
            //                         onPressed: () {
            //                           showDialog(
            //                             barrierDismissible: false,
            //                             context: context,
            //                             builder: (context) {
            //                               return ButtonBarTheme(
            //                                   data: ButtonBarThemeData(
            //                                       alignment:
            //                                           MainAxisAlignment.center),
            //                                   child: AlertDialog(
            //                                     actions: [
            //                                       Column(
            //                                         mainAxisAlignment:
            //                                             MainAxisAlignment
            //                                                 .center,
            //                                         children: [
            //                                           Container(
            //                                             height: Get.height / 4,
            //                                             width: Get.width,
            //                                             child: Obx(() {
            //                                               if (postALeadController
            //                                                   .isLoading.value)
            //                                                 return Center(
            //                                                   child:
            //                                                       CircularProgressIndicator(),
            //                                                 );
            //                                               else
            //                                                 return ListView
            //                                                     .builder(
            //                                                         itemCount: postALeadController
            //                                                             .postALeadList
            //                                                             .value
            //                                                             .results
            //                                                             .languages
            //                                                             .keys
            //                                                             .length,
            //                                                         itemBuilder:
            //                                                             (context,
            //                                                                 index) {
            //                                                           List maptoListLanguages = postALeadController
            //                                                               .postALeadList
            //                                                               .value
            //                                                               .results
            //                                                               .languages
            //                                                               .values
            //                                                               .toList();
            //                                                           List maptoListLanguagesKeys = postALeadController
            //                                                               .postALeadList
            //                                                               .value
            //                                                               .results
            //                                                               .languages
            //                                                               .keys
            //                                                               .toList();
            //                                                           return CheckboxGroup(
            //                                                             labelStyle:
            //                                                                 TextStyle(fontSize: 11),
            //                                                             labels: [
            //                                                               maptoListLanguages[
            //                                                                   index]
            //                                                             ],
            //                                                             onChange: (bool isChecked,
            //                                                                 String
            //                                                                     label,
            //                                                                 int inde) {
            //                                                               if (isChecked) {
            //                                                                 languageList.add(maptoListLanguagesKeys[index]);
            //                                                                 print(languageList);
            //                                                               } else {
            //                                                                 languageList.remove(maptoListLanguagesKeys[index]);
            //                                                                 print(languageList);
            //                                                               }
            //                                                               print(
            //                                                                   "isChecked: $isChecked   label: $label  index: $inde");
            //                                                             },
            //                                                           );
            //                                                         });
            //                                             }),
            //                                           ),
            //                                           Container(
            //                                             width: Get.width / 1.2,
            //                                             child: Row(
            //                                               //mainAxisSize: MainAxisSize.max,
            //                                               mainAxisAlignment:
            //                                                   MainAxisAlignment
            //                                                       .center,
            //                                               crossAxisAlignment:
            //                                                   CrossAxisAlignment
            //                                                       .center,
            //                                               children: <Widget>[
            //                                                 Container(
            //                                                   width:
            //                                                       Get.width / 3,
            //                                                   child:
            //                                                       GestureDetector(
            //                                                     child: new Text(
            //                                                       'Cancel',
            //                                                       style: TextStyle(
            //                                                           color: Colors
            //                                                               .white),
            //                                                     ),
            //                                                     color: Color(
            //                                                         0xFF121A21),
            //                                                     shape:
            //                                                         new RoundedRectangleBorder(
            //                                                       borderRadius:
            //                                                           new BorderRadius
            //                                                                   .circular(
            //                                                               30.0),
            //                                                     ),
            //                                                     onPressed: () {
            //                                                       languageList
            //                                                           .clear();
            //                                                       setState(
            //                                                           () {});
            //                                                       Get.back();
            //                                                     },
            //                                                   ),
            //                                                 ),
            //                                                 SizedBox(
            //                                                     width:
            //                                                         Get.width *
            //                                                             0.02),
            //                                                 Container(
            //                                                   width:
            //                                                       Get.width / 3,
            //                                                   child:
            //                                                       GestureDetector(
            //                                                     child: new Text(
            //                                                       'Save',
            //                                                       style: TextStyle(
            //                                                           color: Colors
            //                                                               .white),
            //                                                     ),
            //                                                     color: Color(
            //                                                         0xFF121A21),
            //                                                     shape:
            //                                                         new RoundedRectangleBorder(
            //                                                       borderRadius:
            //                                                           new BorderRadius
            //                                                                   .circular(
            //                                                               30.0),
            //                                                     ),
            //                                                     onPressed: () {
            //                                                       print(
            //                                                           languageList);
            //                                                       setState(
            //                                                           () {});
            //                                                       Get.back();
            //                                                     },
            //                                                   ),
            //                                                 ),
            //                                               ],
            //                                             ),
            //                                           )
            //                                         ],
            //                                       ),
            //                                     ],
            //                                   ));
            //                             },
            //                           );
            //                         },
            //                         icon: Icon(Icons.arrow_drop_down),
            //                       ),
            //                     )),
            //               ),
            //               SizedBox(height: 16),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 24),
            //                 child: Row(
            //                   children: [
            //                     Container(
            //                       color: Color(0xffA0C828),
            //                       height: 60,
            //                       width: 3,
            //                     ),
            //                     SizedBox(
            //                       width: 10,
            //                     ),
            //                     Text(
            //                       "Project Details",
            //                       style: TextStyle(
            //                           color: Colors.black,
            //                           fontWeight: FontWeight.bold,
            //                           fontSize: Dimension.text_size_medium),
            //                     )
            //                   ],
            //                 ),
            //               ),
            //               SizedBox(height: 16),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 24),
            //                 child: TextField(
            //                   autofocus: false,
            //                   focusNode: FocusNode(),
            //                   controller: _projectDetails,
            //                   maxLines: 5,
            //                   decoration: InputDecoration(
            //                       hintText: 'Write Your Project Details',
            //                       border: OutlineInputBorder()),
            //                 ),
            //               ),
            //               SizedBox(height: 16),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 24),
            //                 child: Row(
            //                   children: [
            //                     Container(
            //                       color: Color(0xffA0C828),
            //                       height: 60,
            //                       width: 3,
            //                     ),
            //                     SizedBox(
            //                       width: 10,
            //                     ),
            //                     Text(
            //                       "Skills Required",
            //                       style: TextStyle(
            //                           color: Colors.black,
            //                           fontWeight: FontWeight.bold,
            //                           fontSize: Dimension.text_size_medium),
            //                     )
            //                   ],
            //                 ),
            //               ),
            //               SizedBox(height: 16),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 24),
            //                 child: Container(
            //                     decoration: BoxDecoration(
            //                         border: Border.all(
            //                             color: Colors.grey, width: 1)),
            //                     child: ListTile(
            //                       title: skillList.length == null
            //                           ? Text("Categories")
            //                           : Text(skillList.length.toString() +
            //                               " Selected"),
            //                       trailing: IconButton(
            //                         onPressed: () {
            //                           showDialog(
            //                             barrierDismissible: false,
            //                             context: context,
            //                             builder: (context) {
            //                               return ButtonBarTheme(
            //                                   data: ButtonBarThemeData(
            //                                       alignment:
            //                                           MainAxisAlignment.center),
            //                                   child: AlertDialog(
            //                                     actions: [
            //                                       Column(
            //                                         mainAxisAlignment:
            //                                             MainAxisAlignment
            //                                                 .center,
            //                                         children: [
            //                                           Container(
            //                                             height: Get.height / 3,
            //                                             width: Get.width,
            //                                             child: Obx(() {
            //                                               if (postALeadController
            //                                                   .isLoading.value)
            //                                                 return Center(
            //                                                   child:
            //                                                       CircularProgressIndicator(),
            //                                                 );
            //                                               else
            //                                                 return ListView
            //                                                     .builder(
            //                                                         itemCount: postALeadController
            //                                                             .postALeadList
            //                                                             .value
            //                                                             .results
            //                                                             .skills
            //                                                             .keys
            //                                                             .length,
            //                                                         itemBuilder:
            //                                                             (context,
            //                                                                 index) {
            //                                                           List maptoListSkills = postALeadController
            //                                                               .postALeadList
            //                                                               .value
            //                                                               .results
            //                                                               .skills
            //                                                               .values
            //                                                               .toList();
            //                                                           List maptoListSkillsKeys = postALeadController
            //                                                               .postALeadList
            //                                                               .value
            //                                                               .results
            //                                                               .skills
            //                                                               .keys
            //                                                               .toList();
            //                                                           return CheckboxGroup(
            //                                                             labelStyle:
            //                                                                 TextStyle(fontSize: 11),
            //                                                             labels: [
            //                                                               maptoListSkills[
            //                                                                   index]
            //                                                             ],
            //                                                             onChange: (bool isChecked,
            //                                                                 String
            //                                                                     label,
            //                                                                 int inde) {
            //                                                               if (isChecked) {
            //                                                                 skillList.add(maptoListSkillsKeys[index]);
            //                                                                 print(skillList);
            //                                                               } else {
            //                                                                 skillList.remove(maptoListSkills[index]);
            //                                                                 print(skillList);
            //                                                               }
            //                                                               print(
            //                                                                   "isChecked: $isChecked   label: $label  index: $inde");
            //                                                             },
            //                                                           );
            //                                                         });
            //                                             }),
            //                                           ),
            //                                           Container(
            //                                             width: Get.width / 1.2,
            //                                             child: Row(
            //                                               //mainAxisSize: MainAxisSize.max,
            //                                               mainAxisAlignment:
            //                                                   MainAxisAlignment
            //                                                       .center,
            //                                               crossAxisAlignment:
            //                                                   CrossAxisAlignment
            //                                                       .center,
            //                                               children: <Widget>[
            //                                                 Container(
            //                                                   width:
            //                                                       Get.width / 3,
            //                                                   child:
            //                                                       GestureDetector(
            //                                                     child: new Text(
            //                                                       'Cancel',
            //                                                       style: TextStyle(
            //                                                           color: Colors
            //                                                               .white),
            //                                                     ),
            //                                                     color: Color(
            //                                                         0xFF121A21),
            //                                                     shape:
            //                                                         new RoundedRectangleBorder(
            //                                                       borderRadius:
            //                                                           new BorderRadius
            //                                                                   .circular(
            //                                                               30.0),
            //                                                     ),
            //                                                     onPressed: () {
            //                                                       skillList
            //                                                           .clear();
            //                                                       setState(
            //                                                           () {});
            //                                                       Get.back();
            //                                                     },
            //                                                   ),
            //                                                 ),
            //                                                 SizedBox(
            //                                                     width:
            //                                                         Get.width *
            //                                                             0.02),
            //                                                 Container(
            //                                                   width:
            //                                                       Get.width / 3,
            //                                                   child:
            //                                                       GestureDetector(
            //                                                     child: new Text(
            //                                                       'Save',
            //                                                       style: TextStyle(
            //                                                           color: Colors
            //                                                               .white),
            //                                                     ),
            //                                                     color: Color(
            //                                                         0xFF121A21),
            //                                                     shape:
            //                                                         new RoundedRectangleBorder(
            //                                                       borderRadius:
            //                                                           new BorderRadius
            //                                                                   .circular(
            //                                                               30.0),
            //                                                     ),
            //                                                     onPressed: () {
            //                                                       print(
            //                                                           skillList);
            //                                                       setState(
            //                                                           () {});
            //                                                       Get.back();
            //                                                     },
            //                                                   ),
            //                                                 ),
            //                                               ],
            //                                             ),
            //                                           )
            //                                         ],
            //                                       ),
            //                                     ],
            //                                   ));
            //                             },
            //                           );
            //                         },
            //                         icon: Icon(Icons.arrow_drop_down),
            //                       ),
            //                     )),
            //               ),
            //               SizedBox(height: 16),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 24),
            //                 child: Row(
            //                   children: [
            //                     Container(
            //                       color: Color(0xffA0C828),
            //                       height: 60,
            //                       width: 3,
            //                     ),
            //                     SizedBox(
            //                       width: 10,
            //                     ),
            //                     Text(
            //                       "Your Location",
            //                       style: TextStyle(
            //                           color: Colors.black,
            //                           fontWeight: FontWeight.bold,
            //                           fontSize: Dimension.text_size_medium),
            //                     )
            //                   ],
            //                 ),
            //               ),
            //               SizedBox(height: 16),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 24),
            //                 child: Container(
            //                   padding: EdgeInsets.all(6),
            //                   decoration: BoxDecoration(
            //                       border:
            //                           Border.all(color: Colors.grey, width: 1)),
            //                   child: DropdownButton(
            //                     isExpanded: true,
            //                     hint: Text(
            //                       "Your Location",
            //                       style: TextStyle(fontSize: 14),
            //                     ),
            //                     items: postALeadController
            //                         .postALeadList.value.results.locations.keys
            //                         .map((values) {
            //                       return DropdownMenuItem(
            //                         value: values,
            //                         child: Padding(
            //                           padding: const EdgeInsets.only(
            //                               left: 8.0, right: 8.0),
            //                           child: Text(
            //                             postALeadController.postALeadList.value
            //                                 .results.locations[values],
            //                             style: TextStyle(),
            //                           ),
            //                         ),
            //                       );
            //                     }).toList(),
            //                     value: locations,
            //                     underline: SizedBox(),
            //                     onChanged: (valueSelectedByUser) {
            //                       setState(() {
            //                         locations = valueSelectedByUser;
            //                         print(locations);
            //                       });
            //                     },
            //                   ),
            //                 ),
            //               ),
            //               SizedBox(height: 8),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 24),
            //                 child: TextField(
            //                   autofocus: false,
            //                   focusNode: FocusNode(),
            //                   controller: postalCode,
            //                   decoration: InputDecoration(
            //                       hintText: 'Enter Postal Code',
            //                       border: OutlineInputBorder()),
            //                 ),
            //               ),
            //               SizedBox(height: 8),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 24),
            //                 child: TextField(
            //                   autofocus: false,
            //                   focusNode: FocusNode(),
            //                   controller: addresss,
            //                   decoration: InputDecoration(
            //                       //  prefixIcon: Icon(Icons.search, color: Colors.black,),
            //                       hintText: 'Your Address',
            //                       border: OutlineInputBorder()),
            //                   onTap: () async {
            //                     print("Search Result");
            //                     final sessionToken = Uuid().v4();
            //                     final Suggestion result = await showSearch(
            //                         context: context,
            //                         delegate: AddressSearch(sessionToken));
            //                     if (result != null) {
            //                       setState(() {
            //                         addresss.text = result.description;
            //                       });
            //                     } else {
            //                       setState(() {
            //                         addresss.text = SharedPref.location;
            //                       });
            //                     }
            //                   },
            //                 ),
            //               ),
            //               SizedBox(height: 8),
            //               Padding(
            //                 padding: const EdgeInsets.only(left: 24, right: 24),
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     Text("Featured",
            //                         style: TextStyle(
            //                             color: Colors.black,
            //                             fontWeight: FontWeight.bold,
            //                             fontSize: Dimension.text_size_medium)),
            //                     Container(
            //                       child: Switch(
            //                         value: isFeatured,
            //                         onChanged: (value) {
            //                           setState(() {
            //                             isFeatured = value;
            //                             print(isFeatured);
            //                           });
            //                         },
            //                         activeTrackColor: Color(0xff2ECC71),
            //                         activeColor: Color(0xff2ECC71),
            //                       ),
            //                     )
            //                   ],
            //                 ),
            //               ),
            //               SizedBox(height: 8),
            //               Padding(
            //                 padding: const EdgeInsets.only(left: 24, right: 24),
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     Text("Status",
            //                         style: TextStyle(
            //                             color: Colors.black,
            //                             fontWeight: FontWeight.bold,
            //                             fontSize: Dimension.text_size_medium)),
            //                     Container(
            //                       child: Switch(
            //                         value: isStatus,
            //                         onChanged: (value) {
            //                           setState(() {
            //                             isStatus = value;
            //                             print(isStatus);
            //                           });
            //                         },
            //                         activeTrackColor: Color(0xff2ECC71),
            //                         activeColor: Color(0xff2ECC71),
            //                       ),
            //                     )
            //                   ],
            //                 ),
            //               ),
            //               SizedBox(height: 8),
            //               Padding(
            //                 padding: const EdgeInsets.only(left: 24, right: 24),
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     Text("Attachments",
            //                         style: TextStyle(
            //                             color: Colors.black,
            //                             fontWeight: FontWeight.bold,
            //                             fontSize: Dimension.text_size_medium)),
            //                     Container(
            //                       child: Switch(
            //                         value: isAttachements,
            //                         onChanged: (value) {
            //                           setState(() {
            //                             isAttachements = value;
            //                             print(isAttachements);
            //                           });
            //                         },
            //                         activeTrackColor: Color(0xff2ECC71),
            //                         activeColor: Color(0xff2ECC71),
            //                       ),
            //                     )
            //                   ],
            //                 ),
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 24),
            //                 child: Row(
            //                   children: [
            //                     Container(
            //                       color: Color(0xffA0C828),
            //                       height: 60,
            //                       width: 3,
            //                     ),
            //                     SizedBox(
            //                       width: 10,
            //                     ),
            //                     Text(
            //                       "Your Attachments",
            //                       style: TextStyle(
            //                           color: Colors.black,
            //                           fontWeight: FontWeight.bold,
            //                           fontSize: Dimension.text_size_medium),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               SizedBox(height: 16),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 22),
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.start,
            //                   children: [
            //                     GestureDetector(
            //                         onPressed: () async {
            //                           //VENDOR
            //                           _isLabour == false && _isMaterial == false
            //                               ? displayMessageLead(context)
            //                               : isStatus == false
            //                                   ? Fluttertoast.showToast(
            //                                       //msg: "${resp["results"]}",
            //                                       msg:
            //                                           "Status Should Be Enabled",
            //                                       toastLength:
            //                                           Toast.LENGTH_LONG,
            //                                       gravity: ToastGravity.BOTTOM,
            //                                       timeInSecForIosWeb: 1,
            //                                       backgroundColor: Colors.green,
            //                                       textColor: Colors.white,
            //                                       fontSize: 14.0)
            //                                   //: saveAndUpdateLead();
            //                                   : Upload(context);
            //                         },
            //                         color: Colors.blue,
            //                         child: visible == 0
            //                             ? loaderStatus == false
            //                                 ? Text(
            //                                     '   Post   ',
            //                                     style: TextStyle(
            //                                       color: Colors.white,
            //                                       fontSize:
            //                                           Dimension.text_size_small,
            //                                     ),
            //                                   )
            //                                 : CircularProgressIndicator(
            //                                     color: Colors.white,
            //                                   )
            //                             : Center(
            //                                 child: Container(
            //                                     height: 30,
            //                                     width: 30,
            //                                     child:
            //                                         CircularProgressIndicator()),
            //                               )),
            //                     SizedBox(width: 20),
            //                     GestureDetector(
            //                       onPressed: () {
            //                         //  Alerts.rateAppDialouge(context, "Select Your File", "");
            //                         filePick();
            //                         // fileAppDialouge(context, "Select your file", "");
            //                       },
            //                       color: Color(0xff2ECC71),
            //                       child: Text(
            //                         'Select File',
            //                         style: TextStyle(
            //                           color: Colors.white,
            //                           fontSize: Dimension.text_size_small,
            //                         ),
            //                       ),
            //                     ),
            //                     SizedBox(
            //                       width: 8,
            //                     ),
            //                     Text(
            //                       "*File Size\n5 Mb max",
            //                       style:
            //                           TextStyle(fontSize: 8, color: Colors.red),
            //                     )
            //                   ],
            //                 ),
            //               ),
            //               Container(
            //                 height: 80,
            //                 width: Get.width / 1,
            //                 child: ListView.builder(
            //                   shrinkWrap: false,
            //                   itemCount: selectedFileList.length,
            //                   itemBuilder: (context, index) {
            //                     return Stack(
            //                       children: [
            //                         Padding(
            //                           padding: const EdgeInsets.only(
            //                               top: 16, bottom: 0, right: 16),
            //                           child: Container(
            //                             child: Row(
            //                               mainAxisAlignment:
            //                                   MainAxisAlignment.center,
            //                               children: [
            //                                 Icon(Icons.file_upload),
            //                                 Center(
            //                                   child: Container(
            //                                     width: MediaQuery.of(context)
            //                                             .size
            //                                             .width *
            //                                         0.8,
            //                                     child: Text(
            //                                       selectedFileList[index]
            //                                           .path
            //                                           .split("/")
            //                                           .last,
            //                                       style:
            //                                           TextStyle(fontSize: 10),
            //                                       //overflow: TextOverflow.ellipsis,
            //                                     ),
            //                                   ),
            //                                 ),
            //                                 // Text(
            //                                 //   selectedFileList[index]
            //                                 //       .path
            //                                 //       .split("/")
            //                                 //       .last,
            //                                 //   style: TextStyle(fontSize: 10),
            //                                 //   overflow: TextOverflow.ellipsis,
            //                                 // ),
            //                               ],
            //                             ),
            //                           ),
            //                         ),
            //                         Positioned(
            //                           top: 4,
            //                           right: 10,
            //                           child: InkWell(
            //                             onTap: () {
            //                               setState(() {
            //                                 selectedFileList.remove(
            //                                     selectedFileList[index]);
            //                                 //selectedFileList.remove(index);
            //                                 // filepick.removeAt(index);
            //                                 // fileShow.removeAt(index);
            //                               });
            //                             },
            //                             child: CircleAvatar(
            //                               radius: 12,
            //                               backgroundColor: Colors.red,
            //                               child: Icon(
            //                                 Icons.delete,
            //                                 color: Colors.black,
            //                                 size: 16,
            //                               ),
            //                             ),
            //                           ),
            //                         )
            //                       ],
            //                     );
            //                   },
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),

            loaderStatus == true
                ? Align(
                    child: LinearProgressIndicator(),
                    alignment: Alignment.topCenter,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  File? _image;
  final imagePicker = ImagePicker();

  // Future getImageFromCamera() async {
  //   final image = await imagePicker.pickImage(source: ImageSource.camera);
  //   setState(() {
  //     _image = File(image.path);
  //   });
  // }

  void filePick() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result!.files!.length != 0) {
      setState(() {
        selectedFileList.add(File(result!.files!.single!.path!));
      });
    }

    //**
    // if (result != null) {
    //   print("results");
    //   filepick = result.files.toList();
    //   //  files = result.paths.map((path) => File(path)).toList();
    //   filepick.forEach((files) {
    //     setState(() {
    //       if (files.size < 5000000) {
    //         selectedFileList.add(File(files.path));
    //         fileShow.add(files.name);
    //         //singlefile =File(files.path);
    //         print(File(files.path));
    //       } else {
    //         Get.snackbar("File Size", "File Size is more than 5 MB",
    //             snackPosition: SnackPosition.BOTTOM,
    //             backgroundColor: Colors.redAccent);
    //       }
    //     });
    //   });
    //   print("first check" + selectedFileList.toString());
    // } else {
    //   // User canceled the picker
    // }
    //**
  }

  Future<void> _selectPickImage() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFiles.add(imageFile);
      print("$imageFile");
    });
  }

  // Future<Response> postRequestDio() async {
  //   print("PRESS DIO");
  //   String postAjobDynamicUrl = "";
  //   String add = "";
  //
  //   String addCategory = "";
  //   String addLanguage = "";
  //   String addSkills = "";
  //
  //   List _projectTipe = [];
  //
  //   String isLabourNew = "";
  //   String isMaterialNew = "";
  //
  //   var isNewLabourNew;
  //   var isNewMaterialNew;
  //
  //   if (_isLabour) {
  //     _projectTipe.add(1);
  //
  //     isNewLabourNew = "1";
  //     isLabourNew = "&project_hire_type[]=1";
  //   } else {
  //     isNewLabourNew = "";
  //     isLabourNew = "";
  //   }
  //   if (_isMaterial) {
  //     _projectTipe.add(2);
  //     isNewMaterialNew = "2";
  //     isMaterialNew = "&project_hire_type[]=2";
  //   } else {
  //     isNewMaterialNew = "";
  //     isMaterialNew = "";
  //   }
  //
  //   var newleadExpiration =
  //       leadExpiration == null ? "" : leadExpiration.toString();
  //   var newhaveInsurance =
  //       haveInsurance == null ? "" : haveInsurance.toString();
  //   var newisThereIsuranceCom =
  //       isThereIsuranceCom == null ? "" : isThereIsuranceCom.toString();
  //   var newnumberofStories =
  //       numberofStories == null ? "" : numberofStories.toString();
  //   var newageOfRoofs = ageOfRoofs == null ? "" : ageOfRoofs.toString();
  //   var newtypeOfRoofs = typeOfRoofs == null ? "" : typeOfRoofs.toString();
  //   var newpropertyType = propertyType == null ? "" : propertyType.toString();
  //   var newsetDateAndTime = convertedSetDateAndTime == null
  //       ? ""
  //       : convertedSetDateAndTime.toString();
  //
  //   print("https://www.fix-era.com/api/v1/post-job?title=${_jobTitle.text}" +
  //       "&custom_price_type=$customPriceType" +
  //       "&custom_price_value=${_customPriceValue.text}" +
  //       "&job_duration=$projectDuration" +
  //       "&freelancer_type=$freelancerLevel" +
  //       "&measurement_type=$mesurement" +
  //       "&measurement_value=${_measurementValue.text}" +
  //       "&project_start_date=$convertedDateTimeStart" +
  //       "&project_end_date=$convertedDateTimeEnd" +
  //       "&lead_expiration= $newleadExpiration" +
  //       "&lead_price=${_credits.text}" +
  //       "&insurance_status=$newhaveInsurance" +
  //       "&insurance_company=$newisThereIsuranceCom" +
  //       "&square_size=${_squares.text}" +
  //       "&no_stories=$newnumberofStories" +
  //       "&age_of_roof=$newageOfRoofs" +
  //       "&roof_type=$newtypeOfRoofs" +
  //       "&property_type=$newpropertyType" +
  //       "&lead_contact_name=${_leadContactName.text}" +
  //       "&lead_contact_phone=${_leadContactNumber.text}" +
  //       "&lead_contact_email=${_leadContactEmail.text}" +
  //       "&expiry_of_lead=$newsetDateAndTime" +
  //       "&project_cost=${projectCostMul}" +
  //       "&description=${_projectDetails.text}" +
  //       "&locations=$locations" +
  //       "&postal_code=${postalCode.text}" +
  //       "&address=${addresss.text}" +
  //       "&is_featured=${isFeatured.toString()}" +
  //       "&project_status=${isStatus.toString()}" +
  //       "&show_attachments=${isAttachements.toString()}" +
  //       isLabourNew +
  //       isMaterialNew);
  //
  //   postAjobDynamicUrl = "https://www.fix-era.com/api/v1/post-job";
  //
  //   setState(() {
  //     categoryList.forEach((singleValue) {
  //       addCategory = "$singleValue";
  //     });
  //
  //     languageList.forEach((singleValue) {
  //       addLanguage = "$singleValue";
  //     });
  //     skillList.forEach((singleValue) {
  //       addSkills = "$singleValue";
  //     });
  //   });
  //   Map<String, String> body = {
  //     'title': _jobTitle.text,
  //     'custom_price_type': customPriceType,
  //     'custom_price_value': _customPriceValue.text,
  //     'job_duration': projectDuration,
  //     'freelancer_type': freelancerLevel,
  //     'measurement_type': mesurement,
  //     'measurement_value': _measurementValue.text,
  //     'project_start_date': convertedDateTimeStart,
  //     'project_end_date': convertedDateTimeEnd,
  //     'lead_expiration': newleadExpiration,
  //     'lead_price': _credits.text,
  //     'insurance_status': newhaveInsurance,
  //     'insurance_company': newisThereIsuranceCom,
  //     'square_size': _squares.text,
  //     'no_stories': newnumberofStories,
  //     'age_of_roof': newageOfRoofs,
  //     'roof_type': newtypeOfRoofs,
  //     'property_type': newpropertyType,
  //     'lead_contact_name': _leadContactName.text,
  //     'lead_contact_phone': _leadContactNumber.text,
  //     'lead_contact_email': _leadContactEmail.text,
  //     'expiry_of_lead': newsetDateAndTime,
  //     'project_cost': projectCostMul,
  //     'description': _projectDetails.text,
  //     'locations': locations,
  //     'postal_code': postalCode.text,
  //     'address': addresss.text,
  //     'is_featured': isFeatured.toString(),
  //     'project_status': isStatus.toString(),
  //     'show_attachments': isAttachements.toString(),
  //     'project_hire_type[]': isNewLabourNew + isNewMaterialNew,
  //     'categories[]': addCategory.toString(),
  //     'languages[]': addLanguage,
  //     'skills[][id]': addSkills.toString(),
  //   };
  //
  //   header2() => {
  //         'X-Requested-With': 'XMLHttpRequest',
  //         'Authorization': '$tokenType $token',
  //         'Accept': 'application/json',
  //       };
  //
  //   List<File> fileList;
  //   fileList = selectedFileList;
  //
  //   print("Images++++++++++++++++++++");
  //   print(fileList);
  //   print("Images++++++++++++++++++++");
  //   Dio dio = Dio();
  //   var formData = FormData();
  //   for (var file in fileList) {
  //     formData.files.addAll([
  //       MapEntry("attachments[]", await MultipartFile.fromFile(file.path)),
  //     ]);
  //   }
  //   formData.fields.addAll(body.entries);
  //   var response;
  //
  //   if (_jobTitle.text != "") {
  //     response = await dio
  //         .post(postAjobDynamicUrl,
  //             data: formData, options: Options(headers: header2()))
  //         .then((value) {
  //       print(value.statusCode);
  //     });
  //
  //     print(response.statusCode);
  //   } else {
  //     Fluttertoast.showToast(
  //         msg: "Job Title Is Empty",
  //         toastLength: Toast.LENGTH_LONG,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.green,
  //         textColor: Colors.white,
  //         fontSize: 14.0);
  //   }
  //
  //   Map<String, dynamic> resp = await response.data;
  //   var messageToast = "${((resp)["results"]["message"])}".toString();
  //   print("${((resp)["results"]["message"])}");
  //
  //   print(response.statusCode);
  //   // try {
  //   if (response.statusCode == 200) {
  //     print("MAMA RESPONSE");
  //     // print("+=+++++="+response.toString());
  //     //Map<String, dynamic> resp = await response.data;
  //     // print("${jsonDecode((resp)["results"]["message"])}");
  //     Fluttertoast.showToast(
  //         msg: messageToast,
  //         toastLength: Toast.LENGTH_LONG,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.green,
  //         textColor: Colors.white,
  //         fontSize: 14.0);
  //     print("i am Ok");
  //     // var postcodeErrorMessage = await json.decode(response.data)["message"];
  //     // print("Message API");
  //     // print(postcodeErrorMessage);
  //     // return response;
  //   }
  //   // else if(response.statusCode==500){
  //   //   final res = await dio.delete(
  //   //     postAjobDynamicUrl,
  //   //     data: selectedFileList,
  //   //     options: Options(
  //   //
  //   //       followRedirects: false,
  //   //       // will not throw errors
  //   //       validateStatus: (status) => true,
  //   //       headers: header2(),
  //   //     ),
  //   //   );
  //   //   print(res);
  //   //   print(messageToast);
  //   // }
  //   else {
  //     // final res = await dio.delete(
  //     //   postAjobDynamicUrl,
  //     //   data: selectedFileList,
  //     //   options: Options(
  //     //
  //     //     followRedirects: false,
  //     //     // will not throw errors
  //     //     validateStatus: (status) => true,
  //     //     headers: header2(),
  //     //   ),
  //     // );
  //     print(response.data);
  //     print("else");
  //     print("StatusCode Else: " + response.statusCode.toString());
  //     Fluttertoast.showToast(
  //         msg: (resp)['result']["message"],
  //         toastLength: Toast.LENGTH_LONG,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.green,
  //         textColor: Colors.white,
  //         fontSize: 14.0);
  //     print("i am Else");
  //     // return response;
  //   }
  //   // }
  //   // on Exception catch (e) {
  //   //   print("Exception:"+e.toString());
  //   //   Fluttertoast.showToast(
  //   //       msg: (resp)["message"],
  //   //       toastLength: Toast.LENGTH_LONG,
  //   //       gravity: ToastGravity.BOTTOM,
  //   //       timeInSecForIosWeb: 1,
  //   //       backgroundColor: Colors.green,
  //   //       textColor: Colors.white,
  //   //       fontSize: 14.0);
  //   //   print("i am Catch");
  //   // }
  // }

  Loader() {
    setState(() {
      loaderStatus = true;
    });
    print("Loader: " + loaderStatus.toString());
  }

  Upload(context) async {
    setState(() {
      loaderStatus = true;
    });
    print("loaderStatus: " + loaderStatus.toString());
    print("PRESS Upload FUnc");
    print(SharedPref.to.prefss!.getString("token"));
    String postAjobDynamicUrl = "";
    String add = "";

    String addCategory = "";
    String addLanguage = "";
    String addSkills = "";

    List _projectTipe = [];

    String isLabourNew = "";
    String isMaterialNew = "";

    var isNewLabourNew;
    var isNewMaterialNew;

    if (_isLabour) {
      _projectTipe.add(1);

      isNewLabourNew = "1";
      isLabourNew = "&project_hire_type[]=1";
    } else {
      isNewLabourNew = "";
      isLabourNew = "";
    }
    if (_isMaterial) {
      _projectTipe.add(2);
      isNewMaterialNew = "2";
      isMaterialNew = "&project_hire_type[]=2";
    } else {
      isNewMaterialNew = "";
      isMaterialNew = "";
    }

    var newleadExpiration =
        leadExpiration == null ? "" : leadExpiration.toString();
    var newhaveInsurance =
        haveInsurance == null ? "" : haveInsurance.toString();
    var newisThereIsuranceCom =
        isThereIsuranceCom == null ? "" : isThereIsuranceCom.toString();
    var newnumberofStories =
        numberofStories == null ? "" : numberofStories.toString();
    var newageOfRoofs = ageOfRoofs == null ? "" : ageOfRoofs.toString();
    var newtypeOfRoofs = typeOfRoofs == null ? "" : typeOfRoofs.toString();
    var newpropertyType = propertyType == null ? "" : propertyType.toString();
    var newsetDateAndTime = convertedSetDateAndTime == null
        ? ""
        : convertedSetDateAndTime.toString();

    print("https://www.fix-era.com/api/v1/post-job?title=${_jobTitle.text}" +
        "&custom_price_type=${customPriceType == null ? "" : customPriceType}" +
        "&custom_price_value=${_customPriceValue.text == null ? "" : _customPriceValue.text}" +
        "&job_duration=${projectDuration == null ? "" : projectDuration}" +
        "&freelancer_type=${freelancerLevel == null ? "" : freelancerLevel}" +
        "&measurement_type=${mesurement == null ? "" : mesurement}" +
        "&measurement_value=${_measurementValue.text}" +
        "&project_start_date=${convertedDateTimeStart == null ? "" : convertedDateTimeStart}" +
        "&project_end_date=${convertedDateTimeEnd == null ? "" : convertedDateTimeEnd}" +
        "&lead_expiration= $newleadExpiration" +
        "&lead_price=${_credits.text}" +
        "&insurance_status=$newhaveInsurance" +
        "&insurance_company=$newisThereIsuranceCom" +
        "&square_size=${_squares.text}" +
        "&no_stories=$newnumberofStories" +
        "&age_of_roof=$newageOfRoofs" +
        "&roof_type=$newtypeOfRoofs" +
        "&property_type=$newpropertyType" +
        "&lead_contact_name=${_leadContactName.text}" +
        "&lead_contact_phone=${_leadContactNumber.text}" +
        "&lead_contact_email=${_leadContactEmail.text}" +
        "&expiry_of_lead=$newsetDateAndTime" +
        "&project_cost=${projectCostMul == null ? "" : projectCostMul}" +
        "&description=${_projectDetails.text}" +
        "&locations=${locations == null ? "" : locations}" +
        "&postal_code=${postalCode.text}" +
        "&address=${addresss.text}" +
        "&is_featured=${isFeatured.toString()}" +
        "&project_status=${isStatus.toString()}" +
        "&show_attachments=${isAttachements.toString()}" +
        isLabourNew +
        isMaterialNew);

    setState(() {
      categoryList.forEach((singleValue) {
        addCategory = "$singleValue";
      });

      languageList.forEach((singleValue) {
        addLanguage = "$singleValue";
      });
      skillList.forEach((singleValue) {
        addSkills = "$singleValue";
      });
    });

    List<File> imageFile = selectedFileList;
    //
    //
    //   var stream =
    //       new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    //   var length = await imageFile.length();

    var uri = Uri.parse('https://www.fix-era.com/api/v1/post-job');

    var request = new http.MultipartRequest("POST", uri);
    request.headers["X-Requested-With"] = 'XMLHttpRequest';
    request.headers["Authorization"] = '$tokenType $token';
    request.headers["Accept"] = "application/json";

    // var multipartFile = new http.MultipartFile('images[]', stream, length,
    //     filename: basename(imageFile.path));

    // var multipartFile = new http.MultipartFile('attachments[]', stream, length,
    // filename: basename(imageFile.path));

    for (int i = 0; i < imageFile.length; i++) {
      request.files.add(
        http.MultipartFile(
          'attachments[]',
          http.ByteStream(DelegatingStream.typed(imageFile[i].openRead())),
          await imageFile[i].length(),
          filename: basename(imageFile[i].path),
        ),
      );
    }

    request.fields["title"] = _jobTitle.text;
    request.fields["custom_price_type"] =
        customPriceType == null ? "" : customPriceType;
    request.fields["custom_price_value"] =
        _customPriceValue.text == null ? "" : _customPriceValue.text;
    request.fields["job_duration"] =
        projectDuration == null ? "" : projectDuration;
    request.fields["freelancer_type"] =
        freelancerLevel == null ? "" : freelancerLevel;
    request.fields["measurement_type"] = mesurement == null ? "" : mesurement;
    request.fields["measurement_value"] = _measurementValue.text;
    request.fields["project_start_date"] =
        convertedDateTimeStart == null ? "" : convertedDateTimeStart;
    request.fields["project_end_date"] =
        convertedDateTimeEnd == null ? "" : convertedDateTimeEnd;
    request.fields["lead_expiration"] = newleadExpiration;
    request.fields["lead_price"] = _credits.text;
    request.fields["insurance_status"] = newhaveInsurance;
    request.fields["insurance_company"] = newisThereIsuranceCom;
    request.fields["square_size"] = _squares.text;
    request.fields["no_stories"] = newnumberofStories;
    request.fields["age_of_roof"] = newageOfRoofs;
    request.fields["roof_type"] = newtypeOfRoofs;
    request.fields["property_type"] = newpropertyType;
    request.fields["lead_contact_name"] = _leadContactName.text;
    request.fields["lead_contact_phone"] = _leadContactNumber.text;
    request.fields["lead_contact_email"] = _leadContactEmail.text;
    request.fields["expiry_of_lead"] = newsetDateAndTime;
    request.fields["project_cost"] =
        projectCostMul == null ? "" : projectCostMul;
    request.fields["description"] = _projectDetails.text;
    request.fields["locations"] = locations == null ? "" : locations;
    request.fields["postal_code"] = postalCode.text;
    request.fields["address"] = addresss.text;
    request.fields["is_featured"] = isFeatured.toString();
    request.fields["project_status"] = isStatus.toString();
    request.fields["show_attachments"] = isAttachements.toString();
    request.fields["project_hire_type[]"] = isNewLabourNew + isNewMaterialNew;
    request.fields["categories[]"] = addCategory.toString();
    request.fields["languages[]"] = addLanguage;
    request.fields["skills[][id]"] = addSkills.toString();

    // request.files.add(multipartFile);
    var response = await request.send();

    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);

    print(responseString.runtimeType);

    // try {

    //  Map<dynamic, dynamic> user = jsonDecode(responseData.toString());
    // //
    //  print("${user['results']['message']}");
    print("responseData: " + responseData.toString());
    if (response.statusCode == 200) {
      setState(() {
        loaderStatus = false;
      });
      print("loaderStatus: " + loaderStatus.toString());
      Fluttertoast.showToast(
          msg: jsonDecode(responseString)['results']['message'],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 14.0);
      print("i am Ok");
      print("********");
      print(response.statusCode);
      print("responseString: " + responseString.toString());
      print("responseString: " +
          jsonDecode(responseString)['results']['message']);
      selectedFileList.clear();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => BottomNavigationPage()));
    } else {
      setState(() {
        loaderStatus = false;
      });
      print("loaderStatus: " + loaderStatus.toString());
      Fluttertoast.showToast(
          msg: jsonDecode(responseString)['message'],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 14.0);
      print("i am else");
      print("+++++++++++++");
      print(response.statusCode);
      print("responseString: " + responseString.toString());
      print("responseString: " + jsonDecode(responseString)['message']);
    }
    // } on Exception catch (e) {
    //   print("Catch: "+e.toString());
    // }
  }

  contractorJobView(context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //project description new
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
                    "Project Description",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimension.text_size_medium),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                controller: nameControllerNew,
                autofocus: false,
                focusNode: FocusNode(),
                decoration: InputDecoration(
                    hintText: 'Your Name', border: OutlineInputBorder()),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                controller: phoneControllerNew,
                autofocus: false,
                focusNode: FocusNode(),
                decoration: InputDecoration(
                    hintText: 'Your Phone Number',
                    border: OutlineInputBorder()),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                controller: addressControllerNew,
                autofocus: false,
                focusNode: FocusNode(),
                decoration: InputDecoration(
                    hintText: 'Address', border: OutlineInputBorder()),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                controller: projectTitleControllerNew,
                autofocus: false,
                focusNode: FocusNode(),
                decoration: InputDecoration(
                    hintText: 'Project Title', border: OutlineInputBorder()),
              ),
            ),
            SizedBox(height: 20),
            // InkWell(
            //   onTap: () {},
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 24),
            //     child: TextField(
            //       controller: customPriceTypeControllerNew,
            //       enabled: false,
            //       autofocus: false,
            //       focusNode: FocusNode(),
            //       decoration: InputDecoration(
            //           suffixIcon: Icon(Icons.arrow_drop_down),
            //           hintText: 'Select Custom Price Type',
            //           border: OutlineInputBorder()),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1)),
                child: DropdownButton(
                  isExpanded: true,
                  hint: Text(
                    "Select Custom Price",
                    style: TextStyle(fontSize: 14),
                  ),
                  underline: SizedBox(),
                  items: postALeadController
                      .postALeadList.value.results!.priceType!.values
                      .map((values) {
                    return DropdownMenuItem(
                      value: values,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Text(
                          values,
                          style: TextStyle(),
                        ),
                      ),
                    );
                  }).toList(),
                  value: customPriceType,
                  onChanged: (valueSelectedByUser) {
                    setState(() {
                      customPriceType = valueSelectedByUser;
                      customPriceTypeControllerNew.text = customPriceType;
                      print(customPriceType);
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                print("TAP");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: projectDurationControllerNew,
                  enabled: false,
                  autofocus: false,
                  focusNode: FocusNode(),
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      hintText: 'Select Project Duration',
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                print("TAP");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: measurementControllerNew,
                  enabled: false,
                  autofocus: false,
                  focusNode: FocusNode(),
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      hintText: 'Select Measurement',
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                print("TAP");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: constuctionLevelControllerNew,
                  enabled: false,
                  autofocus: false,
                  focusNode: FocusNode(),
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      hintText: 'Select Construction Level',
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                print("TAP");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: priceValueControllerNew,
                  enabled: false,
                  autofocus: false,
                  focusNode: FocusNode(),
                  decoration: InputDecoration(
                      suffixIcon: Column(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Icon(Icons.plus_one),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Icon(Icons.exposure_minus_1),
                          ),
                        ],
                      ),
                      hintText: 'Custom Price Value',
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                print("TAP");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: measurementValueControllerNew,
                  enabled: false,
                  autofocus: false,
                  focusNode: FocusNode(),
                  decoration: InputDecoration(
                      suffixIcon: Column(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Icon(Icons.plus_one),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Icon(Icons.exposure_minus_1),
                          ),
                        ],
                      ),
                      hintText: 'Measurement Value',
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                print("TAP");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: startDateControllerNew,
                  enabled: false,
                  autofocus: false,
                  focusNode: FocusNode(),
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.calendar_month),
                      hintText: 'Project Start Date',
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                print("TAP");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: endDateControllerNew,
                  enabled: false,
                  autofocus: false,
                  focusNode: FocusNode(),
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.calendar_month),
                      hintText: 'Project End Date',
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            SizedBox(height: 20),
            ////Project Cost
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
                    "Project Cost",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimension.text_size_medium),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                print("TAP");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: projectCostControllerNew,
                  enabled: false,
                  autofocus: false,
                  focusNode: FocusNode(),
                  decoration: InputDecoration(
                      suffixIcon: Column(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Icon(Icons.plus_one),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Icon(Icons.exposure_minus_1),
                          ),
                        ],
                      ),
                      hintText: 'Project Cost',
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                print("TAP");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: biddingPricePublicControllerNew,
                  enabled: false,
                  autofocus: false,
                  focusNode: FocusNode(),
                  decoration: InputDecoration(
                      suffixIcon: Column(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Icon(Icons.plus_one),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Icon(Icons.exposure_minus_1),
                          ),
                        ],
                      ),
                      hintText: 'Bidding Price(Public)',
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                print("TAP");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: biddingPricePrivateControllerNew,
                  enabled: false,
                  autofocus: false,
                  focusNode: FocusNode(),
                  decoration: InputDecoration(
                      suffixIcon: Column(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Icon(Icons.plus_one),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Icon(Icons.exposure_minus_1),
                          ),
                        ],
                      ),
                      hintText: 'Bidding Price(Private)',
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            SizedBox(height: 20),
            ////Project Categories
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
                    "Project Categories",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimension.text_size_medium),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                print("TAP");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: projectCategoryControllerNew,
                  enabled: false,
                  autofocus: false,
                  focusNode: FocusNode(),
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      hintText: 'Select Project Categories',
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            SizedBox(height: 20),
            ////Language
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
                    "Project Categories",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimension.text_size_medium),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                print("TAP");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: languageControllerNew,
                  enabled: false,
                  autofocus: false,
                  focusNode: FocusNode(),
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      hintText: 'Select Language',
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            SizedBox(height: 20),
            ////Project Details
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
                    "Project Details",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimension.text_size_medium),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            // Container(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: HtmlEditor(
            //     showBottomToolbar: false,
            //     hint: "Project Details",
            //     key: htmlEditor,
            //     height: 400,
            //   ),
            // ),
            SizedBox(height: 20),
            ////Your Location
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
                    "Your Location",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimension.text_size_medium),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                print("TAP");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: locationControllerNew,
                  enabled: false,
                  autofocus: false,
                  focusNode: FocusNode(),
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      hintText: 'Select Locations',
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                controller: postalCodeControllerNew,
                autofocus: false,
                focusNode: FocusNode(),
                decoration: InputDecoration(
                    hintText: 'Enter Postal Code',
                    border: OutlineInputBorder()),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                controller: yourAddressCodeControllerNew,
                autofocus: false,
                focusNode: FocusNode(),
                decoration: InputDecoration(
                    hintText: 'Your Address', border: OutlineInputBorder()),
              ),
            ),
            SizedBox(height: 20),
            ////Featured
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
                    "Featured",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimension.text_size_medium),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Text(
                      "Featured",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: Dimension.text_size_medium),
                    ),
                    Switch(
                      onChanged: (v) {
                        isSwitchedFeature = !isSwitchedFeature;
                        setState(() {});
                      },
                      value: isSwitchedFeature,
                      activeColor: AppColors.primaryColor,
                      activeTrackColor: AppColors.primaryColor,
                      inactiveThumbColor: AppColors.primaryColor,
                      inactiveTrackColor: Colors.grey,
                    ),
                  ],
                )),
            SizedBox(height: 20),
            ////Attachments
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
                    "Attachments",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimension.text_size_medium),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Text(
                      "Show “Attachments” after hiring",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: Dimension.text_size_medium),
                    ),
                    Switch(
                      onChanged: (v) {
                        isSwitchedAttachments = !isSwitchedAttachments;
                        setState(() {});
                      },
                      value: isSwitchedAttachments,
                      activeColor: AppColors.primaryColor,
                      activeTrackColor: AppColors.primaryColor,
                      inactiveThumbColor: AppColors.primaryColor,
                      inactiveTrackColor: Colors.grey,
                    ),
                  ],
                )),
            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              width: Get.width,
              child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    filePick();
                  },

                  child: Text(
                    'Select File',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimension.text_size_small,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: selectedFileList.length > 0
                    ? Column(
                        children: [
                          for (int i = 0; i < selectedFileList.length; i++)
                            Row(
                              children: [
                                Text(
                                    "${selectedFileList[i].toString().split('/').last.substring(0, selectedFileList[i].toString().split('/').last.length - 1)}"),
                                IconButton(
                                    onPressed: () {
                                      selectedFileList.removeAt(i);
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                              ],
                            )
                        ],
                      )
                    : SizedBox(),
              ),
            ),
            ////save and update
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                // _isLabour == false && _isMaterial == false
                //     ? displayMessageLead(context)
                //     : isStatus == false
                //     ? Fluttertoast.showToast(
                //     msg:
                //     "Status Should Be Enabled",
                //     toastLength:
                //     Toast.LENGTH_LONG,
                //     gravity: ToastGravity.BOTTOM,
                //     timeInSecForIosWeb: 1,
                //     backgroundColor: Colors.green,
                //     textColor: Colors.white,
                //     fontSize: 14.0)
                // //: postRequestDio();
                //     : Upload(context);
                //
                // // _isLabour == false && _isMaterial == false
                // //     ? displayMessageProject()
                // //     //: saveAndUpdateJob();
                // //     : postLeadandJob();
              },
              child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: Color(0xff2ECC71),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      'Save and Update',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimension.text_size_small,
                      ),
                    ),
                  )),
            ),

            // //project type
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: Row(
            //     children: [
            //       Container(
            //         color: Color(0xffA0C828),
            //         height: 60,
            //         width: 3,
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Text(
            //         "Project Type",
            //         style: TextStyle(
            //             color: Colors.black,
            //             fontWeight: FontWeight.bold,
            //             fontSize: Dimension.text_size_medium),
            //       )
            //     ],
            //   ),
            // ),
            // Row(
            //   children: [
            //     SizedBox(
            //       width: 30,
            //     ),
            //     Row(
            //       children: [
            //         Checkbox(
            //             value: _isLabour,
            //             onChanged: (v) {
            //               setState(() {
            //                 _isLabour = !_isLabour;
            //               });
            //             }),
            //         Text("Labor"),
            //       ],
            //     ),
            //     Row(
            //       children: [
            //         Checkbox(
            //             value: _isMaterial,
            //             onChanged: (v) {
            //               setState(() {
            //                 _isMaterial = !_isMaterial;
            //               });
            //             }),
            //         Text("Material"),
            //       ],
            //     ),
            //   ],
            // ),
            // SizedBox(height: 20),
            //*****
            //project categories
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: Row(
            //     children: [
            //       Container(
            //         color: Color(0xffA0C828),
            //         height: 60,
            //         width: 3,
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Text(
            //         "Project Categories",
            //         style: TextStyle(
            //             color: Colors.black,
            //             fontWeight: FontWeight.bold,
            //             fontSize: Dimension.text_size_medium),
            //       )
            //     ],
            //   ),
            // ),
            // SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: Container(
            //       decoration: BoxDecoration(
            //           border: Border.all(
            //               color: Colors.grey, width: 1)),
            //       child: ListTile(
            //         title: categoryList.length == null
            //             ? Text(
            //                 "Categories",
            //                 style: TextStyle(fontSize: 14),
            //               )
            //             : Text(categoryList.length.toString() +
            //                 " Selected"),
            //         trailing: IconButton(
            //           onPressed: () {
            //             showDialog(
            //               barrierDismissible: false,
            //               context: context,
            //               builder: (context) {
            //                 return ButtonBarTheme(
            //                     data: ButtonBarThemeData(
            //                         alignment:
            //                             MainAxisAlignment.center),
            //                     child: AlertDialog(
            //                       actions: [
            //                         Column(
            //                           mainAxisAlignment:
            //                               MainAxisAlignment
            //                                   .center,
            //                           children: [
            //                             Container(
            //                               height: Get.height / 2,
            //                               width: Get.width,
            //                               child: Obx(() {
            //                                 if (postAJobController
            //                                     .isLoading.value)
            //                                   return Center(
            //                                     child:
            //                                         CircularProgressIndicator(),
            //                                   );
            //                                 else
            //                                   return ListView
            //                                       .builder(
            //                                           itemCount: postAJobController
            //                                               .postAjobList
            //                                               .value
            //                                               .results
            //                                               .categories
            //                                               .keys
            //                                               .length,
            //                                           itemBuilder:
            //                                               (context,
            //                                                   index) {
            //                                             List maptoListCategories = postAJobController
            //                                                 .postAjobList
            //                                                 .value
            //                                                 .results
            //                                                 .categories
            //                                                 .values
            //                                                 .toList();
            //                                             List maptoListCategoriesKeys = postAJobController
            //                                                 .postAjobList
            //                                                 .value
            //                                                 .results
            //                                                 .categories
            //                                                 .keys
            //                                                 .toList();
            //                                             return CheckboxGroup(
            //                                               labelStyle:
            //                                                   TextStyle(fontSize: 11),
            //                                               labels: [
            //                                                 maptoListCategories[
            //                                                     index]
            //                                               ],
            //                                               onChange: (bool isChecked,
            //                                                   String
            //                                                       label,
            //                                                   int inde) {
            //                                                 if (isChecked) {
            //                                                   categoryList.add(maptoListCategoriesKeys[index]);
            //                                                   print(categoryList);
            //                                                 } else {
            //                                                   categoryList.remove(maptoListCategoriesKeys[index]);
            //                                                   print(categoryList);
            //                                                 }
            //                                                 print(
            //                                                     "isChecked: $isChecked   label: $label  index: $inde");
            //                                               },
            //                                             );
            //                                           });
            //                               }),
            //                             ),
            //                             Container(
            //                               width: Get.width / 1.2,
            //                               child: Row(
            //                                 //mainAxisSize: MainAxisSize.max,
            //                                 mainAxisAlignment:
            //                                     MainAxisAlignment
            //                                         .center,
            //                                 crossAxisAlignment:
            //                                     CrossAxisAlignment
            //                                         .center,
            //                                 children: <Widget>[
            //                                   Container(
            //                                     width:
            //                                         Get.width / 3,
            //                                     child:
            //                                         GestureDetector(
            //                                       child: new Text(
            //                                         'Cancel',
            //                                         style: TextStyle(
            //                                             color: Colors
            //                                                 .white),
            //                                       ),
            //                                       color: Color(
            //                                           0xFF121A21),
            //                                       shape:
            //                                           new RoundedRectangleBorder(
            //                                         borderRadius:
            //                                             new BorderRadius
            //                                                     .circular(
            //                                                 30.0),
            //                                       ),
            //                                       onPressed: () {
            //                                         categoryList
            //                                             .clear();
            //                                         setState(
            //                                             () {});
            //                                         Get.back();
            //                                       },
            //                                     ),
            //                                   ),
            //                                   SizedBox(
            //                                       width:
            //                                           Get.width *
            //                                               0.02),
            //                                   Container(
            //                                     width:
            //                                         Get.width / 3,
            //                                     child:
            //                                         GestureDetector(
            //                                       child: new Text(
            //                                         'Save',
            //                                         style: TextStyle(
            //                                             color: Colors
            //                                                 .white),
            //                                       ),
            //                                       color: Color(
            //                                           0xFF121A21),
            //                                       shape:
            //                                           new RoundedRectangleBorder(
            //                                         borderRadius:
            //                                             new BorderRadius
            //                                                     .circular(
            //                                                 30.0),
            //                                       ),
            //                                       onPressed: () {
            //                                         print(
            //                                             categoryList);
            //                                         setState(
            //                                             () {});
            //                                         Get.back();
            //                                       },
            //                                     ),
            //                                   ),
            //                                 ],
            //                               ),
            //                             )
            //                           ],
            //                         ),
            //                       ],
            //                     ));
            //               },
            //             );
            //           },
            //           icon: Icon(Icons.arrow_drop_down),
            //         ),
            //       )),
            // ),
            // SizedBox(height: 16),
            // //*****
            // //project description
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: Row(
            //     children: [
            //       Container(
            //         color: Color(0xffA0C828),
            //         height: 60,
            //         width: 3,
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Text(
            //         "Project Description",
            //         style: TextStyle(
            //             color: Colors.black,
            //             fontWeight: FontWeight.bold,
            //             fontSize: Dimension.text_size_medium),
            //       )
            //     ],
            //   ),
            // ),
            // SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: TextField(
            //     controller: _jobTitle,
            //     autofocus: false,
            //     focusNode: FocusNode(),
            //     decoration: InputDecoration(
            //         hintText: 'Project Title',
            //         border: OutlineInputBorder()),
            //   ),
            // ),
            // SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: Container(
            //     padding: EdgeInsets.all(6),
            //     decoration: BoxDecoration(
            //         border:
            //             Border.all(color: Colors.grey, width: 1)),
            //     child: DropdownButton(
            //       isExpanded: true,
            //       hint: Text(
            //         "Select Custom Price",
            //         style: TextStyle(fontSize: 14),
            //       ),
            //       underline: SizedBox(),
            //       items: postAJobController
            //           .postAjobList.value.results.priceType.keys
            //           .map((values) {
            //         return DropdownMenuItem(
            //           value: values,
            //           child: Padding(
            //             padding: const EdgeInsets.only(
            //                 left: 8.0, right: 8.0),
            //             child: Text(
            //               toBeginningOfSentenceCase(values),
            //               style: TextStyle(),
            //             ),
            //           ),
            //         );
            //       }).toList(),
            //       value: customPriceType,
            //       onChanged: (valueSelectedByUser) {
            //         setState(() {
            //           customPriceType = valueSelectedByUser;
            //         });
            //       },
            //     ),
            //   ),
            // ),
            // SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: TextField(
            //     autofocus: false,
            //     focusNode: FocusNode(),
            //     controller: _customPriceValue,
            //     keyboardType: TextInputType.number,
            //     decoration: InputDecoration(
            //         hintText: 'Custom Price Value',
            //         border: OutlineInputBorder()),
            //   ),
            // ),
            // SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: Container(
            //     padding: EdgeInsets.all(6),
            //     decoration: BoxDecoration(
            //         border:
            //             Border.all(color: Colors.grey, width: 1)),
            //     child: DropdownButton(
            //       isExpanded: true,
            //       hint: Text(
            //         "Select Project Duration",
            //         style: TextStyle(fontSize: 14),
            //       ),
            //       items: postAJobController.postAjobList.value
            //           .results.projectDuration.keys
            //           .map((values) {
            //         return DropdownMenuItem(
            //           value: values,
            //           child: Padding(
            //             padding: const EdgeInsets.only(
            //                 left: 8.0, right: 8.0),
            //             child: Text(
            //               postAJobController.postAjobList.value
            //                   .results.projectDuration[values],
            //               //values
            //               /*postAJobController.postAjobList.value.results
            //               .projectDuration[values]*/
            //
            //               style: TextStyle(),
            //             ),
            //           ),
            //         );
            //       }).toList(),
            //       value: projectDuration,
            //       underline: SizedBox(),
            //       onChanged: (valueSelectedByUser) {
            //         setState(() {
            //           projectDuration = valueSelectedByUser;
            //         });
            //       },
            //     ),
            //   ),
            // ),
            // SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: Container(
            //     padding: EdgeInsets.all(6),
            //     decoration: BoxDecoration(
            //         border:
            //             Border.all(color: Colors.grey, width: 1)),
            //     child: DropdownButton(
            //       isExpanded: true,
            //       hint: Text(
            //         "Select Construction Level",
            //         style: TextStyle(fontSize: 14),
            //       ),
            //       items: postAJobController.postAjobList.value
            //           .results.freelancerLevel.keys
            //           .map((values) {
            //         return DropdownMenuItem(
            //           value: values,
            //           child: Padding(
            //             padding: const EdgeInsets.only(
            //                 left: 8.0, right: 8.0),
            //             child: Text(
            //               postAJobController.postAjobList.value
            //                   .results.freelancerLevel[values],
            //               style: TextStyle(),
            //             ),
            //           ),
            //         );
            //       }).toList(),
            //       value: freelancerLevel,
            //       underline: SizedBox(),
            //       onChanged: (valueSelectedByUser) {
            //         setState(() {
            //           freelancerLevel = valueSelectedByUser;
            //         });
            //       },
            //     ),
            //   ),
            // ),
            // SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: Container(
            //     padding: EdgeInsets.all(6),
            //     decoration: BoxDecoration(
            //         border:
            //             Border.all(color: Colors.grey, width: 1)),
            //     child: DropdownButton(
            //       isExpanded: true,
            //       hint: Text(
            //         "Select Measurement",
            //         style: TextStyle(fontSize: 14),
            //       ),
            //       items: postAJobController
            //           .postAjobList.value.results.measurement.keys
            //           .map((values) {
            //         return DropdownMenuItem(
            //           value: values,
            //           child: Padding(
            //             padding: const EdgeInsets.only(
            //                 left: 8.0, right: 8.0),
            //             child: Text(
            //               postAJobController.postAjobList.value
            //                   .results.measurement[values],
            //               style: TextStyle(),
            //             ),
            //           ),
            //         );
            //       }).toList(),
            //       value: mesurement,
            //       underline: SizedBox(),
            //       onChanged: (valueSelectedByUser) {
            //         setState(() {
            //           mesurement = valueSelectedByUser;
            //           print(mesurement);
            //         });
            //       },
            //     ),
            //   ),
            // ),
            // SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: TextField(
            //     autofocus: false,
            //     focusNode: FocusNode(),
            //     controller: _measurementValue,
            //     keyboardType: TextInputType.number,
            //     onChanged: (value) {
            //       setState(() {
            //         projectCostMul = int.parse(_squares.text) *
            //             int.parse(value);
            //         FocusScope.of(context).nextFocus();
            //         print(projectCostMul);
            //       });
            //     },
            //     decoration: InputDecoration(
            //         hintText: 'Measurement Value',
            //         border: OutlineInputBorder()),
            //   ),
            // ),
            // SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: GestureDetector(
            //     onTap: () {
            //       showDatePicker(
            //               context: context,
            //               initialDate: _startDate == null
            //                   ? DateTime.now()
            //                   : _startDate,
            //               firstDate: DateTime(2021),
            //               lastDate: DateTime(2030))
            //           .then((date) {
            //         setState(() {
            //           _startDate = date;
            //           convertedDateTimeStart =
            //               "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
            //         });
            //       });
            //     },
            //     child: Container(
            //         decoration: BoxDecoration(
            //             border: Border.all(
            //                 color: Colors.grey, width: 1)),
            //         child: ListTile(
            //           title: convertedDateTimeStart == null
            //               ? Text(
            //                   "Please Select Your Start Date",
            //                   style: TextStyle(fontSize: 14),
            //                 )
            //               : Text(
            //                   convertedDateTimeStart.toString()),
            //           trailing: IconButton(
            //             onPressed: () {
            //               showDatePicker(
            //                       context: context,
            //                       initialDate: _startDate == null
            //                           ? DateTime.now()
            //                           : _startDate,
            //                       firstDate: DateTime(2021),
            //                       lastDate: DateTime(2030))
            //                   .then((date) {
            //                 setState(() {
            //                   _startDate = date;
            //                   convertedDateTimeStart =
            //                       "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
            //                 });
            //               });
            //             },
            //             icon: Icon(Icons.date_range),
            //           ),
            //         )),
            //   ),
            // ),
            // SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: GestureDetector(
            //     onTap: () {
            //       showDatePicker(
            //               context: context,
            //               initialDate: _endDate == null
            //                   ? DateTime.now()
            //                   : _endDate,
            //               firstDate: DateTime(2021),
            //               lastDate: DateTime(2030))
            //           .then((date) {
            //         setState(() {
            //           _endDate = date;
            //           convertedDateTimeEnd =
            //               "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
            //         });
            //       });
            //     },
            //     child: Container(
            //         decoration: BoxDecoration(
            //             border: Border.all(
            //                 color: Colors.grey, width: 1)),
            //         child: ListTile(
            //           title: convertedDateTimeEnd == null
            //               ? Text(
            //                   "Please Select Your End Date",
            //                   style: TextStyle(fontSize: 14),
            //                 )
            //               : Text(convertedDateTimeEnd.toString()),
            //           trailing: IconButton(
            //             onPressed: () {
            //               showDatePicker(
            //                       context: context,
            //                       initialDate: _endDate == null
            //                           ? DateTime.now()
            //                           : _endDate,
            //                       firstDate: DateTime(2021),
            //                       lastDate: DateTime(2030))
            //                   .then((date) {
            //                 setState(() {
            //                   _endDate = date;
            //                   convertedDateTimeEnd =
            //                       "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
            //                 });
            //               });
            //             },
            //             icon: Icon(Icons.date_range),
            //           ),
            //         )),
            //   ),
            // ),
            // SizedBox(height: 16),
            // Container(
            //   child: Column(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 24),
            //         child: Row(
            //           children: [
            //             Container(
            //               color: Color(0xffA0C828),
            //               height: 60,
            //               width: 3,
            //             ),
            //             SizedBox(
            //               width: 10,
            //             ),
            //             Column(
            //               crossAxisAlignment:
            //                   CrossAxisAlignment.start,
            //               children: [
            //                 Text(
            //                   "Additional Details",
            //                   style: TextStyle(
            //                       color: Colors.black,
            //                       fontWeight: FontWeight.bold,
            //                       fontSize:
            //                           Dimension.text_size_small),
            //                 ),
            //                 Text(
            //                   "(Optional)",
            //                   style: TextStyle(
            //                       color: Colors.black,
            //                       fontWeight: FontWeight.bold,
            //                       fontSize:
            //                           Dimension.text_size_small),
            //                 ),
            //               ],
            //             )
            //           ],
            //         ),
            //       ),
            //       SizedBox(height: 16),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 24),
            //         child: Container(
            //           padding: EdgeInsets.all(6),
            //           decoration: BoxDecoration(
            //               border: Border.all(
            //                   color: Colors.grey, width: 1)),
            //           child: DropdownButton(
            //             isExpanded: true,
            //             hint: Text(
            //               "Select Expiration",
            //               style: TextStyle(fontSize: 14),
            //             ),
            //             items: postALeadController.postALeadList
            //                 .value.results.leadExpiration.keys
            //                 .map((values) {
            //               return DropdownMenuItem(
            //                 value: values,
            //                 child: Padding(
            //                   padding: const EdgeInsets.only(
            //                       left: 8.0, right: 8.0),
            //                   child: Text(
            //                     values,
            //                     style: TextStyle(),
            //                   ),
            //                 ),
            //               );
            //             }).toList(),
            //             value: leadExpiration,
            //             underline: SizedBox(),
            //             onChanged: (valueSelectedByUser) {
            //               setState(() {
            //                 leadExpiration = valueSelectedByUser;
            //                 print(leadExpiration);
            //               });
            //             },
            //           ),
            //         ),
            //       ),
            //       SizedBox(height: 16),
            //       // Padding(
            //       //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //       //   child: TextField(
            //       //     autofocus: false,
            //       //     focusNode: FocusNode(),
            //       //     keyboardType: TextInputType.number,
            //       //     controller: _credits,
            //       //     decoration: InputDecoration(
            //       //         hintText:
            //       //             'How many Credits e.g. \$1 dollar = 1 Credit',
            //       //         border: OutlineInputBorder()),
            //       //   ),
            //       // ),
            //       // SizedBox(height: 16),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 24),
            //         child: Container(
            //           padding: EdgeInsets.all(6),
            //           decoration: BoxDecoration(
            //               border: Border.all(
            //                   color: Colors.grey, width: 1)),
            //           child: DropdownButton(
            //             isExpanded: true,
            //             hint: Text(
            //               "Do They Have Insurance",
            //               style: TextStyle(fontSize: 14),
            //             ),
            //             items: postALeadController.postALeadList
            //                 .value.results.leadInsurance.keys
            //                 .map((values) {
            //               return DropdownMenuItem(
            //                 value: values,
            //                 child: Padding(
            //                   padding: const EdgeInsets.only(
            //                       left: 8.0, right: 8.0),
            //                   child: Text(
            //                     values,
            //                     style: TextStyle(),
            //                   ),
            //                 ),
            //               );
            //             }).toList(),
            //             value: haveInsurance,
            //             underline: SizedBox(),
            //             onChanged: (valueSelectedByUser) {
            //               setState(() {
            //                 haveInsurance = valueSelectedByUser;
            //                 print(haveInsurance);
            //               });
            //             },
            //           ),
            //         ),
            //       ),
            //       SizedBox(height: 16),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 24),
            //         child: Container(
            //           padding: EdgeInsets.all(6),
            //           decoration: BoxDecoration(
            //               border: Border.all(
            //                   color: Colors.grey, width: 1)),
            //           child: DropdownButton(
            //             isExpanded: true,
            //             hint: Text(
            //               "Who Is There Insurance Company",
            //               style: TextStyle(fontSize: 14),
            //             ),
            //             items: postALeadController.postALeadList
            //                 .value.results.insuranceCompany.keys
            //                 .map((values) {
            //               return DropdownMenuItem(
            //                 value: values,
            //                 child: Padding(
            //                   padding: const EdgeInsets.only(
            //                       left: 8.0, right: 8.0),
            //                   child: Text(
            //                     values.toString(),
            //                     style: TextStyle(),
            //                   ),
            //                 ),
            //               );
            //             }).toList(),
            //             value: isThereIsuranceCom,
            //             underline: SizedBox(),
            //             onChanged: (valueSelectedByUser) {
            //               setState(() {
            //                 isThereIsuranceCom =
            //                     valueSelectedByUser;
            //                 print(isThereIsuranceCom);
            //               });
            //             },
            //           ),
            //         ),
            //       ),
            //       SizedBox(height: 16),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 24),
            //         child: TextField(
            //           autofocus: false,
            //           focusNode: FocusNode(),
            //           keyboardType: TextInputType.number,
            //           controller: _squares,
            //           onChanged: (value) {
            //             setState(() {
            //               projectCostMul =
            //                   int.parse(_measurementValue.text) *
            //                       int.parse(value);
            //               //FocusScope.of(context).unfocus();
            //               print(projectCostMul);
            //             });
            //           },
            //           decoration: InputDecoration(
            //               hintText: 'How Many Squares',
            //               border: OutlineInputBorder()),
            //         ),
            //       ),
            //       SizedBox(height: 16),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 24),
            //         child: Container(
            //           padding: EdgeInsets.all(6),
            //           decoration: BoxDecoration(
            //               border: Border.all(
            //                   color: Colors.grey, width: 1)),
            //           child: DropdownButton(
            //             isExpanded: true,
            //             hint: Text(
            //               "Number of Stories",
            //               style: TextStyle(fontSize: 14),
            //             ),
            //             items: postALeadController.postALeadList
            //                 .value.results.noOfStories
            //                 .map((values) {
            //               return DropdownMenuItem(
            //                 value: values,
            //                 child: Padding(
            //                   padding: const EdgeInsets.only(
            //                       left: 8.0, right: 8.0),
            //                   child: Text(
            //                     values.toString(),
            //                     style: TextStyle(),
            //                   ),
            //                 ),
            //               );
            //             }).toList(),
            //             value: numberofStories,
            //             underline: SizedBox(),
            //             onChanged: (valueSelectedByUser) {
            //               setState(() {
            //                 numberofStories = valueSelectedByUser;
            //                 print(numberofStories);
            //               });
            //             },
            //           ),
            //         ),
            //       ),
            //       SizedBox(height: 16),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 24),
            //         child: Container(
            //           padding: EdgeInsets.all(6),
            //           decoration: BoxDecoration(
            //               border: Border.all(
            //                   color: Colors.grey, width: 1)),
            //           child: DropdownButton(
            //             isExpanded: true,
            //             hint: Text(
            //               "Age of Roof",
            //               style: TextStyle(fontSize: 14),
            //             ),
            //             items: postALeadController
            //                 .postALeadList.value.results.ageOfRoof
            //                 .map((values) {
            //               return DropdownMenuItem(
            //                 value: values,
            //                 child: Padding(
            //                   padding: const EdgeInsets.only(
            //                       left: 8.0, right: 8.0),
            //                   child: Text(
            //                     values,
            //                     style: TextStyle(),
            //                   ),
            //                 ),
            //               );
            //             }).toList(),
            //             value: ageOfRoofs,
            //             underline: SizedBox(),
            //             onChanged: (valueSelectedByUser) {
            //               setState(() {
            //                 ageOfRoofs = valueSelectedByUser;
            //                 print(ageOfRoofs);
            //               });
            //             },
            //           ),
            //         ),
            //       ),
            //       SizedBox(height: 16),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 24),
            //         child: Container(
            //           padding: EdgeInsets.all(6),
            //           decoration: BoxDecoration(
            //               border: Border.all(
            //                   color: Colors.grey, width: 1)),
            //           child: DropdownButton(
            //             isExpanded: true,
            //             hint: Text(
            //               "Type of Roof",
            //               style: TextStyle(fontSize: 14),
            //             ),
            //             items: postALeadController.postALeadList
            //                 .value.results.typeOfRoof.keys
            //                 .map((values) {
            //               return DropdownMenuItem(
            //                 value: values,
            //                 child: Padding(
            //                   padding: const EdgeInsets.only(
            //                       left: 8.0, right: 8.0),
            //                   child: Text(
            //                     postALeadController
            //                         .postALeadList
            //                         .value
            //                         .results
            //                         .typeOfRoof[values]
            //                         .toString(),
            //                     style: TextStyle(),
            //                   ),
            //                 ),
            //               );
            //             }).toList(),
            //             value: typeOfRoofs,
            //             underline: SizedBox(),
            //             onChanged: (valueSelectedByUser) {
            //               setState(() {
            //                 typeOfRoofs = valueSelectedByUser;
            //                 print(typeOfRoofs);
            //               });
            //             },
            //           ),
            //         ),
            //       ),
            //       SizedBox(height: 16),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 24),
            //         child: Container(
            //           padding: EdgeInsets.all(6),
            //           decoration: BoxDecoration(
            //               border: Border.all(
            //                   color: Colors.grey, width: 1)),
            //           child: DropdownButton(
            //             isExpanded: true,
            //             hint: Text(
            //               "Property Type",
            //               style: TextStyle(fontSize: 14),
            //             ),
            //             items: postALeadController.postALeadList
            //                 .value.results.propertyType.keys
            //                 .map((values) {
            //               return DropdownMenuItem(
            //                 value: values,
            //                 child: Padding(
            //                   padding: const EdgeInsets.only(
            //                       left: 8.0, right: 8.0),
            //                   child: Text(
            //                     postALeadController
            //                         .postALeadList
            //                         .value
            //                         .results
            //                         .propertyType[values]
            //                         .toString(),
            //                     style: TextStyle(),
            //                   ),
            //                 ),
            //               );
            //             }).toList(),
            //             value: propertyType,
            //             underline: SizedBox(),
            //             onChanged: (valueSelectedByUser) {
            //               setState(() {
            //                 propertyType = valueSelectedByUser;
            //                 print(propertyType);
            //               });
            //             },
            //           ),
            //         ),
            //       ),
            //       SizedBox(height: 16),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 24),
            //         child: TextField(
            //           autofocus: false,
            //           focusNode: FocusNode(),
            //           controller: _leadContactName,
            //           decoration: InputDecoration(
            //               hintText: 'Project Contact Name',
            //               border: OutlineInputBorder()),
            //         ),
            //       ),
            //       SizedBox(height: 16),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 24),
            //         child: TextField(
            //           autofocus: false,
            //           focusNode: FocusNode(),
            //           controller: _leadContactNumber,
            //           decoration: InputDecoration(
            //               hintText:
            //                   'Project Contact Phone Number',
            //               border: OutlineInputBorder()),
            //         ),
            //       ),
            //       SizedBox(height: 16),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 24),
            //         child: TextField(
            //           autofocus: false,
            //           focusNode: FocusNode(),
            //           controller: _leadContactEmail,
            //           decoration: InputDecoration(
            //               hintText: 'Project Contact Email',
            //               border: OutlineInputBorder()),
            //         ),
            //       ),
            //       SizedBox(height: 16),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 24),
            //         child: GestureDetector(
            //           onTap: () {
            //             showDatePicker(
            //                     context: context,
            //                     initialDate:
            //                         setDateAndTime == null
            //                             ? DateTime.now()
            //                             : setDateAndTime,
            //                     firstDate: DateTime(2021),
            //                     lastDate: DateTime(2030))
            //                 .then((date) {
            //               setState(() {
            //                 setDateAndTime = date;
            //                 print(
            //                     "Project Expiration Date and Time");
            //                 print(setDateAndTime);
            //                 convertedSetDateAndTime =
            //                     "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
            //               });
            //             });
            //           },
            //           child: Container(
            //               decoration: BoxDecoration(
            //                   border: Border.all(
            //                       color: Colors.grey, width: 1)),
            //               child: ListTile(
            //                 title: convertedSetDateAndTime == null
            //                     ? Text(
            //                         "Project Expiration Date",
            //                         style:
            //                             TextStyle(fontSize: 14),
            //                       )
            //                     : Text(convertedSetDateAndTime
            //                         .toString()),
            //                 trailing: IconButton(
            //                   onPressed: () {
            //                     showDatePicker(
            //                             context: context,
            //                             initialDate:
            //                                 setDateAndTime == null
            //                                     ? DateTime.now()
            //                                     : setDateAndTime,
            //                             firstDate: DateTime(2021),
            //                             lastDate: DateTime(2030))
            //                         .then((date) {
            //                       setState(() {
            //                         setDateAndTime = date;
            //                         print(
            //                             "Project Expiration Date and Time");
            //                         print(setDateAndTime);
            //                         convertedSetDateAndTime =
            //                             "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
            //                       });
            //                     });
            //                   },
            //                   icon: Icon(Icons.date_range),
            //                 ),
            //               )),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: Row(
            //     children: [
            //       Container(
            //         color: Color(0xffA0C828),
            //         height: 60,
            //         width: 3,
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Text(
            //         "Project Cost",
            //         style: TextStyle(
            //             color: Colors.black,
            //             fontWeight: FontWeight.bold,
            //             fontSize: Dimension.text_size_medium),
            //       )
            //     ],
            //   ),
            // ),
            // SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: TextField(
            //     keyboardType: TextInputType.number,
            //     autofocus: false,
            //     focusNode: FocusNode(),
            //     onChanged: (value) {
            //       projectCostMul = value.toString();
            //
            //       print("Project Cost is ${projectCostMul}");
            //     },
            //     decoration: InputDecoration(
            //         hintText: 'Project Cost',
            //         border: OutlineInputBorder()),
            //   ),
            // ),

            //     /* Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: Container(
            //     height: 60,
            //     width: 320,
            //     decoration: BoxDecoration(
            //         border: Border.all(color: Colors.black)),
            //     child: Row(
            //       children: [
            //         SizedBox(
            //           width: 8,
            //         ),
            //         projectCostMul == null
            //             ? Text("Project Cost")
            //             : Text(projectCostMul.toString()),
            //       ],
            //     ),
            //   ),
            // ),*/
            //     SizedBox(height: 16),
            //     // Padding(
            //     //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //     //   child: Row(
            //     //     children: [
            //     //       Container(
            //     //         color: Color(0xffA0C828),
            //     //         height: 60,
            //     //         width: 3,
            //     //       ),
            //     //       SizedBox(
            //     //         width: 10,
            //     //       ),
            //     //       Text(
            //     //         "Project Categories",
            //     //         style: TextStyle(
            //     //             color: Colors.black,
            //     //             fontWeight: FontWeight.bold,
            //     //             fontSize: Dimension.text_size_medium),
            //     //       )
            //     //     ],
            //     //   ),
            //     // ),
            //     // SizedBox(height: 16),
            //     // Padding(
            //     //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //     //   child: Container(
            //     //       decoration: BoxDecoration(
            //     //           border: Border.all(color: Colors.grey, width: 1)),
            //     //       child: ListTile(
            //     //         title: categoryList.length == null
            //     //             ? Text(
            //     //                 "Categories",
            //     //                 style: TextStyle(fontSize: 14),
            //     //               )
            //     //             : Text(categoryList.length.toString() +
            //     //                 " Selected"),
            //     //         trailing: IconButton(
            //     //           onPressed: () {
            //     //             showDialog(
            //     //               barrierDismissible: false,
            //     //               context: context,
            //     //               builder: (context) {
            //     //                 return ButtonBarTheme(
            //     //                     data: ButtonBarThemeData(
            //     //                         alignment:
            //     //                             MainAxisAlignment.center),
            //     //                     child: AlertDialog(
            //     //                       actions: [
            //     //                         Column(
            //     //                           mainAxisAlignment:
            //     //                               MainAxisAlignment.center,
            //     //                           children: [
            //     //                             Container(
            //     //                               height: Get.height / 2,
            //     //                               width: Get.width,
            //     //                               child: Obx(() {
            //     //                                 if (postAJobController
            //     //                                     .isLoading.value)
            //     //                                   return Center(
            //     //                                     child:
            //     //                                         CircularProgressIndicator(),
            //     //                                   );
            //     //                                 else
            //     //                                   return ListView.builder(
            //     //                                       itemCount:
            //     //                                           postAJobController
            //     //                                               .postAjobList
            //     //                                               .value
            //     //                                               .results
            //     //                                               .categories
            //     //                                               .keys
            //     //                                               .length,
            //     //                                       itemBuilder:
            //     //                                           (context, index) {
            //     //                                         List
            //     //                                             maptoListCategories =
            //     //                                             postAJobController
            //     //                                                 .postAjobList
            //     //                                                 .value
            //     //                                                 .results
            //     //                                                 .categories
            //     //                                                 .values
            //     //                                                 .toList();
            //     //                                         List
            //     //                                             maptoListCategoriesKeys =
            //     //                                             postAJobController
            //     //                                                 .postAjobList
            //     //                                                 .value
            //     //                                                 .results
            //     //                                                 .categories
            //     //                                                 .keys
            //     //                                                 .toList();
            //     //                                         return CheckboxGroup(
            //     //                                           labelStyle:
            //     //                                               TextStyle(
            //     //                                                   fontSize:
            //     //                                                       11),
            //     //                                           labels: [
            //     //                                             maptoListCategories[
            //     //                                                 index]
            //     //                                           ],
            //     //                                           onChange: (bool
            //     //                                                   isChecked,
            //     //                                               String label,
            //     //                                               int inde) {
            //     //                                             if (isChecked) {
            //     //                                               categoryList.add(
            //     //                                                   maptoListCategoriesKeys[
            //     //                                                       index]);
            //     //                                               print(
            //     //                                                   categoryList);
            //     //                                             } else {
            //     //                                               categoryList.remove(
            //     //                                                   maptoListCategoriesKeys[
            //     //                                                       index]);
            //     //                                               print(
            //     //                                                   categoryList);
            //     //                                             }
            //     //                                             print(
            //     //                                                 "isChecked: $isChecked   label: $label  index: $inde");
            //     //                                           },
            //     //                                         );
            //     //                                       });
            //     //                               }),
            //     //                             ),
            //     //                             Container(
            //     //                               width: Get.width / 1.2,
            //     //                               child: Row(
            //     //                                 //mainAxisSize: MainAxisSize.max,
            //     //                                 mainAxisAlignment:
            //     //                                     MainAxisAlignment
            //     //                                         .center,
            //     //                                 crossAxisAlignment:
            //     //                                     CrossAxisAlignment
            //     //                                         .center,
            //     //                                 children: <Widget>[
            //     //                                   Container(
            //     //                                     width: Get.width / 3,
            //     //                                     child: GestureDetector(
            //     //                                       child: new Text(
            //     //                                         'Cancel',
            //     //                                         style: TextStyle(
            //     //                                             color: Colors
            //     //                                                 .white),
            //     //                                       ),
            //     //                                       color:
            //     //                                           Color(0xFF121A21),
            //     //                                       shape:
            //     //                                           new RoundedRectangleBorder(
            //     //                                         borderRadius:
            //     //                                             new BorderRadius
            //     //                                                     .circular(
            //     //                                                 30.0),
            //     //                                       ),
            //     //                                       onPressed: () {
            //     //                                         categoryList
            //     //                                             .clear();
            //     //                                         setState(() {});
            //     //                                         Get.back();
            //     //                                       },
            //     //                                     ),
            //     //                                   ),
            //     //                                   SizedBox(
            //     //                                       width:
            //     //                                           Get.width * 0.02),
            //     //                                   Container(
            //     //                                     width: Get.width / 3,
            //     //                                     child: GestureDetector(
            //     //                                       child: new Text(
            //     //                                         'Save',
            //     //                                         style: TextStyle(
            //     //                                             color: Colors
            //     //                                                 .white),
            //     //                                       ),
            //     //                                       color:
            //     //                                           Color(0xFF121A21),
            //     //                                       shape:
            //     //                                           new RoundedRectangleBorder(
            //     //                                         borderRadius:
            //     //                                             new BorderRadius
            //     //                                                     .circular(
            //     //                                                 30.0),
            //     //                                       ),
            //     //                                       onPressed: () {
            //     //                                         print(categoryList);
            //     //                                         setState(() {});
            //     //                                         Get.back();
            //     //                                       },
            //     //                                     ),
            //     //                                   ),
            //     //                                 ],
            //     //                               ),
            //     //                             )
            //     //                           ],
            //     //                         ),
            //     //                       ],
            //     //                     ));
            //     //               },
            //     //             );
            //     //           },
            //     //           icon: Icon(Icons.arrow_drop_down),
            //     //         ),
            //     //       )),
            //     // ),
            //     // SizedBox(height: 16),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 24),
            //       child: Row(
            //         children: [
            //           Container(
            //             color: Color(0xffA0C828),
            //             height: 60,
            //             width: 3,
            //           ),
            //           SizedBox(
            //             width: 10,
            //           ),
            //           Text(
            //             "Languages",
            //             style: TextStyle(
            //                 color: Colors.black,
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: Dimension.text_size_medium),
            //           )
            //         ],
            //       ),
            //     ),
            //     SizedBox(height: 16),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 24),
            //       child: Container(
            //           decoration: BoxDecoration(
            //               border: Border.all(
            //                   color: Colors.grey, width: 1)),
            //           child: ListTile(
            //             title: languageList.length == null
            //                 ? Text(
            //                     "Categories",
            //                     style: TextStyle(fontSize: 14),
            //                   )
            //                 : Text(languageList.length.toString() +
            //                     " Selected"),
            //             trailing: IconButton(
            //               onPressed: () {
            //                 showDialog(
            //                   barrierDismissible: false,
            //                   context: context,
            //                   builder: (context) {
            //                     return ButtonBarTheme(
            //                         data: ButtonBarThemeData(
            //                             alignment:
            //                                 MainAxisAlignment.center),
            //                         child: AlertDialog(
            //                           actions: [
            //                             Column(
            //                               mainAxisAlignment:
            //                                   MainAxisAlignment
            //                                       .center,
            //                               children: [
            //                                 Container(
            //                                   height: Get.height / 4,
            //                                   width: Get.width,
            //                                   child: Obx(() {
            //                                     if (postAJobController
            //                                         .isLoading.value)
            //                                       return Center(
            //                                         child:
            //                                             CircularProgressIndicator(),
            //                                       );
            //                                     else
            //                                       return ListView
            //                                           .builder(
            //                                               itemCount: postAJobController
            //                                                   .postAjobList
            //                                                   .value
            //                                                   .results
            //                                                   .languages
            //                                                   .keys
            //                                                   .length,
            //                                               itemBuilder:
            //                                                   (context,
            //                                                       index) {
            //                                                 List maptoListLanguages = postAJobController
            //                                                     .postAjobList
            //                                                     .value
            //                                                     .results
            //                                                     .languages
            //                                                     .values
            //                                                     .toList();
            //                                                 List maptoListLanguagesKeys = postAJobController
            //                                                     .postAjobList
            //                                                     .value
            //                                                     .results
            //                                                     .languages
            //                                                     .keys
            //                                                     .toList();
            //                                                 return CheckboxGroup(
            //                                                   labelStyle:
            //                                                       TextStyle(fontSize: 11),
            //                                                   labels: [
            //                                                     maptoListLanguages[
            //                                                         index]
            //                                                   ],
            //                                                   onChange: (bool isChecked,
            //                                                       String
            //                                                           label,
            //                                                       int inde) {
            //                                                     if (isChecked) {
            //                                                       languageList.add(maptoListLanguagesKeys[index]);
            //                                                       print(languageList);
            //                                                     } else {
            //                                                       languageList.remove(maptoListLanguagesKeys[index]);
            //                                                       print(languageList);
            //                                                     }
            //                                                     print(
            //                                                         "isChecked: $isChecked   label: $label  index: $inde");
            //                                                   },
            //                                                 );
            //                                               });
            //                                   }),
            //                                 ),
            //                                 Container(
            //                                   width: Get.width / 1.2,
            //                                   child: Row(
            //                                     //mainAxisSize: MainAxisSize.max,
            //                                     mainAxisAlignment:
            //                                         MainAxisAlignment
            //                                             .center,
            //                                     crossAxisAlignment:
            //                                         CrossAxisAlignment
            //                                             .center,
            //                                     children: <Widget>[
            //                                       Container(
            //                                         width:
            //                                             Get.width / 3,
            //                                         child:
            //                                             GestureDetector(
            //                                           child: new Text(
            //                                             'Cancel',
            //                                             style: TextStyle(
            //                                                 color: Colors
            //                                                     .white),
            //                                           ),
            //                                           color: Color(
            //                                               0xFF121A21),
            //                                           shape:
            //                                               new RoundedRectangleBorder(
            //                                             borderRadius:
            //                                                 new BorderRadius
            //                                                         .circular(
            //                                                     30.0),
            //                                           ),
            //                                           onPressed: () {
            //                                             languageList
            //                                                 .clear();
            //                                             setState(
            //                                                 () {});
            //                                             Get.back();
            //                                           },
            //                                         ),
            //                                       ),
            //                                       SizedBox(
            //                                           width:
            //                                               Get.width *
            //                                                   0.02),
            //                                       Container(
            //                                         width:
            //                                             Get.width / 3,
            //                                         child:
            //                                             GestureDetector(
            //                                           child: new Text(
            //                                             'Save',
            //                                             style: TextStyle(
            //                                                 color: Colors
            //                                                     .white),
            //                                           ),
            //                                           color: Color(
            //                                               0xFF121A21),
            //                                           shape:
            //                                               new RoundedRectangleBorder(
            //                                             borderRadius:
            //                                                 new BorderRadius
            //                                                         .circular(
            //                                                     30.0),
            //                                           ),
            //                                           onPressed: () {
            //                                             print(
            //                                                 languageList);
            //                                             setState(
            //                                                 () {});
            //                                             Get.back();
            //                                           },
            //                                         ),
            //                                       ),
            //                                     ],
            //                                   ),
            //                                 )
            //                               ],
            //                             ),
            //                           ],
            //                         ));
            //                   },
            //                 );
            //               },
            //               icon: Icon(Icons.arrow_drop_down),
            //             ),
            //           )),
            //     ),
            //     SizedBox(height: 16),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 24),
            //       child: Row(
            //         children: [
            //           Container(
            //             color: Color(0xffA0C828),
            //             height: 60,
            //             width: 3,
            //           ),
            //           SizedBox(
            //             width: 10,
            //           ),
            //           Text(
            //             "Project Details",
            //             style: TextStyle(
            //                 color: Colors.black,
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: Dimension.text_size_medium),
            //           )
            //         ],
            //       ),
            //     ),
            //     SizedBox(height: 16),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 24),
            //       child: TextField(
            //         autofocus: false,
            //         controller: _projectDetails,
            //         focusNode: FocusNode(),
            //         maxLines: 5,
            //         decoration: InputDecoration(
            //             hintText: 'Write Your Project Details',
            //             border: OutlineInputBorder()),
            //       ),
            //     ),
            //     SizedBox(height: 16),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 24),
            //       child: Row(
            //         children: [
            //           Container(
            //             color: Color(0xffA0C828),
            //             height: 60,
            //             width: 3,
            //           ),
            //           SizedBox(
            //             width: 10,
            //           ),
            //           Text(
            //             "Skills Required",
            //             style: TextStyle(
            //                 color: Colors.black,
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: Dimension.text_size_medium),
            //           )
            //         ],
            //       ),
            //     ),
            //     SizedBox(height: 16),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 24),
            //       child: Container(
            //           decoration: BoxDecoration(
            //               border: Border.all(
            //                   color: Colors.grey, width: 1)),
            //           child: ListTile(
            //             title: skillList.length == null
            //                 ? Text("Categories")
            //                 : Text(skillList.length.toString() +
            //                     " Selected"),
            //             trailing: IconButton(
            //               onPressed: () {
            //                 showDialog(
            //                   barrierDismissible: false,
            //                   context: context,
            //                   builder: (context) {
            //                     return ButtonBarTheme(
            //                         data: ButtonBarThemeData(
            //                             alignment:
            //                                 MainAxisAlignment.center),
            //                         child: AlertDialog(
            //                           actions: [
            //                             Column(
            //                               mainAxisAlignment:
            //                                   MainAxisAlignment
            //                                       .center,
            //                               children: [
            //                                 Container(
            //                                   height: Get.height / 3,
            //                                   width: Get.width,
            //                                   child: Obx(() {
            //                                     if (postAJobController
            //                                         .isLoading.value)
            //                                       return Center(
            //                                         child:
            //                                             CircularProgressIndicator(),
            //                                       );
            //                                     else
            //                                       return ListView
            //                                           .builder(
            //                                               itemCount: postAJobController
            //                                                   .postAjobList
            //                                                   .value
            //                                                   .results
            //                                                   .skills
            //                                                   .keys
            //                                                   .length,
            //                                               itemBuilder:
            //                                                   (context,
            //                                                       index) {
            //                                                 List maptoListSkills = postAJobController
            //                                                     .postAjobList
            //                                                     .value
            //                                                     .results
            //                                                     .skills
            //                                                     .values
            //                                                     .toList();
            //                                                 List maptoListSkillsKeys = postAJobController
            //                                                     .postAjobList
            //                                                     .value
            //                                                     .results
            //                                                     .skills
            //                                                     .keys
            //                                                     .toList();
            //                                                 return CheckboxGroup(
            //                                                   labelStyle:
            //                                                       TextStyle(fontSize: 11),
            //                                                   labels: [
            //                                                     maptoListSkills[
            //                                                         index]
            //                                                   ],
            //                                                   onChange: (bool isChecked,
            //                                                       String
            //                                                           label,
            //                                                       int inde) {
            //                                                     if (isChecked) {
            //                                                       skillList.add(maptoListSkillsKeys[index]);
            //                                                       print(skillList);
            //                                                     } else {
            //                                                       skillList.remove(maptoListSkillsKeys[index]);
            //                                                       print(skillList);
            //                                                     }
            //                                                     print(
            //                                                         "isChecked: $isChecked   label: $label  index: $inde");
            //                                                   },
            //                                                 );
            //                                               });
            //                                   }),
            //                                 ),
            //                                 Container(
            //                                   width: Get.width / 1.2,
            //                                   child: Row(
            //                                     //mainAxisSize: MainAxisSize.max,
            //                                     mainAxisAlignment:
            //                                         MainAxisAlignment
            //                                             .center,
            //                                     crossAxisAlignment:
            //                                         CrossAxisAlignment
            //                                             .center,
            //                                     children: <Widget>[
            //                                       Container(
            //                                         width:
            //                                             Get.width / 3,
            //                                         child:
            //                                             GestureDetector(
            //                                           child: new Text(
            //                                             'Cancel',
            //                                             style: TextStyle(
            //                                                 color: Colors
            //                                                     .white),
            //                                           ),
            //                                           color: Color(
            //                                               0xFF121A21),
            //                                           shape:
            //                                               new RoundedRectangleBorder(
            //                                             borderRadius:
            //                                                 new BorderRadius
            //                                                         .circular(
            //                                                     30.0),
            //                                           ),
            //                                           onPressed: () {
            //                                             skillList
            //                                                 .clear();
            //                                             setState(
            //                                                 () {});
            //                                             Get.back();
            //                                           },
            //                                         ),
            //                                       ),
            //                                       SizedBox(
            //                                           width:
            //                                               Get.width *
            //                                                   0.02),
            //                                       Container(
            //                                         width:
            //                                             Get.width / 3,
            //                                         child:
            //                                             GestureDetector(
            //                                           child: new Text(
            //                                             'Save',
            //                                             style: TextStyle(
            //                                                 color: Colors
            //                                                     .white),
            //                                           ),
            //                                           color: Color(
            //                                               0xFF121A21),
            //                                           shape:
            //                                               new RoundedRectangleBorder(
            //                                             borderRadius:
            //                                                 new BorderRadius
            //                                                         .circular(
            //                                                     30.0),
            //                                           ),
            //                                           onPressed: () {
            //                                             print(
            //                                                 skillList);
            //                                             setState(
            //                                                 () {});
            //                                             Get.back();
            //                                           },
            //                                         ),
            //                                       ),
            //                                     ],
            //                                   ),
            //                                 )
            //                               ],
            //                             ),
            //                           ],
            //                         ));
            //                   },
            //                 );
            //               },
            //               icon: Icon(Icons.arrow_drop_down),
            //             ),
            //           )),
            //     ),
            //     SizedBox(height: 16),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 24),
            //       child: Row(
            //         children: [
            //           Container(
            //             color: Color(0xffA0C828),
            //             height: 60,
            //             width: 3,
            //           ),
            //           SizedBox(
            //             width: 10,
            //           ),
            //           Text(
            //             "Your Location",
            //             style: TextStyle(
            //                 color: Colors.black,
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: Dimension.text_size_medium),
            //           )
            //         ],
            //       ),
            //     ),
            //     SizedBox(height: 16),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 24),
            //       child: Container(
            //         padding: EdgeInsets.all(6),
            //         decoration: BoxDecoration(
            //             border:
            //                 Border.all(color: Colors.grey, width: 1)),
            //         child: DropdownButton(
            //           isExpanded: true,
            //           hint: Text(
            //             "Your Location",
            //             style: TextStyle(fontSize: 14),
            //           ),
            //           items: postAJobController
            //               .postAjobList.value.results.locations.keys
            //               .map((values) {
            //             return DropdownMenuItem(
            //               value: values,
            //               child: Padding(
            //                 padding: const EdgeInsets.only(
            //                     left: 8.0, right: 8.0),
            //                 child: Text(
            //                   postAJobController.postAjobList.value
            //                       .results.locations[values],
            //                   style: TextStyle(),
            //                 ),
            //               ),
            //             );
            //           }).toList(),
            //           value: locations,
            //           underline: SizedBox(),
            //           onChanged: (valueSelectedByUser) {
            //             setState(() {
            //               locations = valueSelectedByUser;
            //               print(locations);
            //             });
            //           },
            //         ),
            //       ),
            //     ),
            //     SizedBox(height: 8),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 24),
            //       child: TextField(
            //         autofocus: false,
            //         focusNode: FocusNode(),
            //         controller: postalCode,
            //         decoration: InputDecoration(
            //             hintText: 'Enter Postal Code',
            //             border: OutlineInputBorder()),
            //       ),
            //     ),
            //     SizedBox(height: 8),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 24),
            //       child: TextField(
            //           autofocus: false,
            //           controller: addresss,
            //           focusNode: FocusNode(),
            //           decoration: InputDecoration(
            //               hintText: 'Your Address',
            //               border: OutlineInputBorder()),
            //           onTap: () async {
            //             print("Search Result");
            //             final sessionToken = Uuid().v4();
            //             final Suggestion result = await showSearch(
            //                 context: context,
            //                 delegate: AddressSearch(sessionToken));
            //             if (result != null) {
            //               setState(() {
            //                 print("${result.description}");
            //                 addresss.text = result.description;
            //               });
            //             } else {
            //               setState(() {
            //                 addresss.text = SharedPref.location;
            //               });
            //             }
            //           }),
            //     ),
            //     SizedBox(height: 8),
            //     Padding(
            //       padding: const EdgeInsets.only(left: 24, right: 24),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text("Featured",
            //               style: TextStyle(
            //                   color: Colors.black,
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: Dimension.text_size_medium)),
            //           Container(
            //             child: Switch(
            //               value: isFeatured,
            //               onChanged: (value) {
            //                 setState(() {
            //                   isFeatured = value;
            //                   print(isFeatured);
            //                 });
            //               },
            //               activeTrackColor: Color(0xff2ECC71),
            //               activeColor: Color(0xff2ECC71),
            //             ),
            //           )
            //         ],
            //       ),
            //     ),
            //     SizedBox(height: 8),
            //     Padding(
            //       padding: const EdgeInsets.only(left: 24, right: 24),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text("Status",
            //               style: TextStyle(
            //                   color: Colors.black,
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: Dimension.text_size_medium)),
            //           Container(
            //             child: Switch(
            //               value: isStatus,
            //               onChanged: (value) {
            //                 setState(() {
            //                   isStatus = value;
            //                   print(isStatus);
            //                 });
            //               },
            //               activeTrackColor: Color(0xff2ECC71),
            //               activeColor: Color(0xff2ECC71),
            //             ),
            //           )
            //         ],
            //       ),
            //     ),
            //     SizedBox(height: 8),
            //     Padding(
            //       padding: const EdgeInsets.only(left: 24, right: 24),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text("Attachments",
            //               style: TextStyle(
            //                   color: Colors.black,
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: Dimension.text_size_medium)),
            //           Container(
            //             child: Switch(
            //               value: isAttachements,
            //               onChanged: (value) {
            //                 setState(() {
            //                   isAttachements = value;
            //                   print(isAttachements);
            //                 });
            //               },
            //               activeTrackColor: Color(0xff2ECC71),
            //               activeColor: Color(0xff2ECC71),
            //             ),
            //           )
            //         ],
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 24),
            //       child: Row(
            //         children: [
            //           Container(
            //             color: Color(0xffA0C828),
            //             height: 60,
            //             width: 3,
            //           ),
            //           SizedBox(
            //             width: 10,
            //           ),
            //           Text(
            //             "Your Attachments",
            //             style: TextStyle(
            //                 color: Colors.black,
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: Dimension.text_size_medium),
            //           ),
            //         ],
            //       ),
            //     ),
            //     SizedBox(height: 16),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 24),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: [
            //           GestureDetector(
            //               onPressed: () async {
            //                 /////CONTRACTOR
            //                 _isLabour == false && _isMaterial == false
            //                     ? displayMessageLead(context)
            //                     : isStatus == false
            //                         ? Fluttertoast.showToast(
            //                             msg:
            //                                 "Status Should Be Enabled",
            //                             toastLength:
            //                                 Toast.LENGTH_LONG,
            //                             gravity: ToastGravity.BOTTOM,
            //                             timeInSecForIosWeb: 1,
            //                             backgroundColor: Colors.green,
            //                             textColor: Colors.white,
            //                             fontSize: 14.0)
            //                         //: postRequestDio();
            //                         : Upload(context);
            //
            //                 // _isLabour == false && _isMaterial == false
            //                 //     ? displayMessageProject()
            //                 //     //: saveAndUpdateJob();
            //                 //     : postLeadandJob();
            //               },
            //               color: Colors.blue,
            //               child: visible == 0
            //                   ? loaderStatus == false
            //                       ? Text(
            //                           '   Post   ',
            //                           style: TextStyle(
            //                             color: Colors.white,
            //                             fontSize:
            //                                 Dimension.text_size_small,
            //                           ),
            //                         )
            //                       : CircularProgressIndicator(
            //                           color: Colors.white,
            //                         )
            //                   : Center(
            //                       child: Container(
            //                           height: 30,
            //                           width: 30,
            //                           child:
            //                               CircularProgressIndicator()),
            //                     )),
            //           SizedBox(width: 20),
            //           GestureDetector(
            //             onPressed: () {
            //               //   fileAppDialouge(context, "Select your file", "");
            //               filePick();
            //             },
            //             color: Color(0xff2ECC71),
            //             child: Text(
            //               'Select File',
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontSize: Dimension.text_size_small,
            //               ),
            //             ),
            //           ),
            //           SizedBox(
            //             width: 8,
            //           ),
            //           Text(
            //             "*File Size\n5 Mb max",
            //             style:
            //                 TextStyle(fontSize: 8, color: Colors.red),
            //           )
            //         ],
            //       ),
            //     ),
            //     Container(
            //       height: 80,
            //       width: Get.width / 1,
            //       child: ListView.builder(
            //         shrinkWrap: false,
            //         itemCount: selectedFileList.length,
            //         itemBuilder: (context, index) {
            //           return Stack(
            //             children: [
            //               Padding(
            //                 padding: const EdgeInsets.only(
            //                     top: 16, bottom: 0, right: 16),
            //                 child: Container(
            //                   child: Row(
            //                     mainAxisAlignment:
            //                         MainAxisAlignment.center,
            //                     children: [
            //                       Icon(Icons.file_upload),
            //                       Center(
            //                         child: Container(
            //                           width: MediaQuery.of(context)
            //                                   .size
            //                                   .width *
            //                               0.8,
            //                           child: Text(
            //                             selectedFileList[index]
            //                                 .path
            //                                 .split("/")
            //                                 .last,
            //                             style:
            //                                 TextStyle(fontSize: 10),
            //                             //overflow: TextOverflow.ellipsis,
            //                           ),
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //               Positioned(
            //                 top: 4,
            //                 right: 10,
            //                 child: InkWell(
            //                   onTap: () {
            //                     setState(() {
            //                       selectedFileList.remove(
            //                           selectedFileList[index]);
            //                       // filepick.remove(index);
            //                       // fileShow.remove(index);
            //                     });
            //                   },
            //                   child: CircleAvatar(
            //                     radius: 12,
            //                     backgroundColor: Colors.red,
            //                     child: Icon(
            //                       Icons.delete,
            //                       color: Colors.black,
            //                       size: 16,
            //                     ),
            //                   ),
            //                 ),
            //               )
            //             ],
            //           );
            //         },
            //       ),
            //     ),
          ],
        ),
      ),
    );
  }

  vendorJobView(context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //project description new
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
                    "Project Description",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimension.text_size_medium),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                //controller: _jobTitle,
                autofocus: false,
                focusNode: FocusNode(),
                decoration: InputDecoration(
                    hintText: 'Your Name', border: OutlineInputBorder()),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                //controller: _jobTitle,
                autofocus: false,
                focusNode: FocusNode(),
                decoration: InputDecoration(
                    hintText: 'Your Phone Number',
                    border: OutlineInputBorder()),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                //controller: _jobTitle,
                autofocus: false,
                focusNode: FocusNode(),
                decoration: InputDecoration(
                    hintText: 'Address', border: OutlineInputBorder()),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                //controller: _jobTitle,
                autofocus: false,
                focusNode: FocusNode(),
                decoration: InputDecoration(
                    hintText: 'Project Title', border: OutlineInputBorder()),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                print("TAP");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  //controller: _jobTitle,
                  enabled: false,
                  autofocus: false,
                  focusNode: FocusNode(),
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      hintText: 'Select Custom Price Type',
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                print("TAP");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  //controller: _jobTitle,
                  enabled: false,
                  autofocus: false,
                  focusNode: FocusNode(),
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      hintText: 'Select Project Duration',
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                print("TAP");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  //controller: _jobTitle,
                  enabled: false,
                  autofocus: false,
                  focusNode: FocusNode(),
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      hintText: 'Select Measurement',
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                print("TAP");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  //controller: _jobTitle,
                  enabled: false,
                  autofocus: false,
                  focusNode: FocusNode(),
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      hintText: 'Select Construction Level',
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                print("TAP");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  //controller: _jobTitle,
                  enabled: false,
                  autofocus: false,
                  focusNode: FocusNode(),
                  decoration: InputDecoration(
                      suffixIcon: Column(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Icon(Icons.plus_one),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Icon(Icons.exposure_minus_1),
                          ),
                        ],
                      ),
                      hintText: 'Custom Price Value',
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                print("TAP");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  //controller: _jobTitle,
                  enabled: false,
                  autofocus: false,
                  focusNode: FocusNode(),
                  decoration: InputDecoration(
                      suffixIcon: Column(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Icon(Icons.plus_one),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Icon(Icons.exposure_minus_1),
                          ),
                        ],
                      ),
                      hintText: 'Measurement Value',
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                print("TAP");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  //controller: _jobTitle,
                  enabled: false,
                  autofocus: false,
                  focusNode: FocusNode(),
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.calendar_month),
                      hintText: 'Project Start Date',
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                print("TAP");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  //controller: _jobTitle,
                  enabled: false,
                  autofocus: false,
                  focusNode: FocusNode(),
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.calendar_month),
                      hintText: 'Project End Date',
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            SizedBox(height: 20),
            ////Project Cost
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
                    "Project Cost",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimension.text_size_medium),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                print("TAP");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  //controller: _jobTitle,
                  enabled: false,
                  autofocus: false,
                  focusNode: FocusNode(),
                  decoration: InputDecoration(
                      suffixIcon: Column(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Icon(Icons.plus_one),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Icon(Icons.exposure_minus_1),
                          ),
                        ],
                      ),
                      hintText: 'Project Cost',
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                print("TAP");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  //controller: _jobTitle,
                  enabled: false,
                  autofocus: false,
                  focusNode: FocusNode(),
                  decoration: InputDecoration(
                      suffixIcon: Column(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Icon(Icons.plus_one),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Icon(Icons.exposure_minus_1),
                          ),
                        ],
                      ),
                      hintText: 'Bidding Price(Public)',
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                print("TAP");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  //controller: _jobTitle,
                  enabled: false,
                  autofocus: false,
                  focusNode: FocusNode(),
                  decoration: InputDecoration(
                      suffixIcon: Column(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Icon(Icons.plus_one),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Icon(Icons.exposure_minus_1),
                          ),
                        ],
                      ),
                      hintText: 'Bidding Price(Private)',
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            SizedBox(height: 20),
            ////Project Categories
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
                    "Project Categories",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimension.text_size_medium),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                print("TAP");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  //controller: _jobTitle,
                  enabled: false,
                  autofocus: false,
                  focusNode: FocusNode(),
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      hintText: 'Select Project Categories',
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            SizedBox(height: 20),
            ////Language
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
                    "Project Categories",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimension.text_size_medium),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                print("TAP");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  //controller: _jobTitle,
                  enabled: false,
                  autofocus: false,
                  focusNode: FocusNode(),
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      hintText: 'Select Language',
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            SizedBox(height: 20),
            ////Project Details
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
                    "Project Details",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimension.text_size_medium),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            // Container(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: HtmlEditor(
            //     showBottomToolbar: false,
            //     hint: "Project Details",
            //     key: htmlEditor,
            //     height: 400,
            //   ),
            // ),
            SizedBox(height: 20),
            ////Your Location
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
                    "Your Location",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimension.text_size_medium),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                print("TAP");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  //controller: _jobTitle,
                  enabled: false,
                  autofocus: false,
                  focusNode: FocusNode(),
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      hintText: 'Select Locations',
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                //controller: _jobTitle,
                autofocus: false,
                focusNode: FocusNode(),
                decoration: InputDecoration(
                    hintText: 'Enter Postal Code',
                    border: OutlineInputBorder()),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                //controller: _jobTitle,
                autofocus: false,
                focusNode: FocusNode(),
                decoration: InputDecoration(
                    hintText: 'Your Address', border: OutlineInputBorder()),
              ),
            ),
            SizedBox(height: 20),
            ////Featured
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
                    "Featured",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimension.text_size_medium),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Text(
                      "Featured",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: Dimension.text_size_medium),
                    ),
                    Switch(
                      onChanged: (v) {
                        isSwitchedFeature = !isSwitchedFeature;
                        setState(() {});
                      },
                      value: isSwitchedFeature,
                      activeColor: AppColors.primaryColor,
                      activeTrackColor: AppColors.primaryColor,
                      inactiveThumbColor: AppColors.primaryColor,
                      inactiveTrackColor: Colors.grey,
                    ),
                  ],
                )),
            SizedBox(height: 20),
            ////Attachments
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
                    "Attachments",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimension.text_size_medium),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Text(
                      "Show “Attachments” after hiring",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: Dimension.text_size_medium),
                    ),
                    Switch(
                      onChanged: (v) {
                        isSwitchedAttachments = !isSwitchedAttachments;
                        setState(() {});
                      },
                      value: isSwitchedAttachments,
                      activeColor: AppColors.primaryColor,
                      activeTrackColor: AppColors.primaryColor,
                      inactiveThumbColor: AppColors.primaryColor,
                      inactiveTrackColor: Colors.grey,
                    ),
                  ],
                )),
            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              width: Get.width,
              child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    //  Alerts.rateAppDialouge(context, "Select Your File", "");
                    filePick();
                    // fileAppDialouge(context, "Select your file", "");
                  },

                  child: Text(
                    'Select File',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimension.text_size_small,
                    ),
                  ),
                ),
              ),
            ),
            ////save and update
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                // _isLabour == false && _isMaterial == false
                //     ? displayMessageLead(context)
                //     : isStatus == false
                //     ? Fluttertoast.showToast(
                //     msg:
                //     "Status Should Be Enabled",
                //     toastLength:
                //     Toast.LENGTH_LONG,
                //     gravity: ToastGravity.BOTTOM,
                //     timeInSecForIosWeb: 1,
                //     backgroundColor: Colors.green,
                //     textColor: Colors.white,
                //     fontSize: 14.0)
                // //: postRequestDio();
                //     : Upload(context);
                //
                // // _isLabour == false && _isMaterial == false
                // //     ? displayMessageProject()
                // //     //: saveAndUpdateJob();
                // //     : postLeadandJob();
              },
              child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: Color(0xff2ECC71),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      'Save and Update',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimension.text_size_small,
                      ),
                    ),
                  )),
            ),

            // //project type
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: Row(
            //     children: [
            //       Container(
            //         color: Color(0xffA0C828),
            //         height: 60,
            //         width: 3,
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Text(
            //         "Project Type",
            //         style: TextStyle(
            //             color: Colors.black,
            //             fontWeight: FontWeight.bold,
            //             fontSize: Dimension.text_size_medium),
            //       )
            //     ],
            //   ),
            // ),
            // Row(
            //   children: [
            //     SizedBox(
            //       width: 30,
            //     ),
            //     Row(
            //       children: [
            //         Checkbox(
            //             value: _isLabour,
            //             onChanged: (v) {
            //               setState(() {
            //                 _isLabour = !_isLabour;
            //               });
            //             }),
            //         Text("Labor"),
            //       ],
            //     ),
            //     Row(
            //       children: [
            //         Checkbox(
            //             value: _isMaterial,
            //             onChanged: (v) {
            //               setState(() {
            //                 _isMaterial = !_isMaterial;
            //               });
            //             }),
            //         Text("Material"),
            //       ],
            //     ),
            //   ],
            // ),
            // SizedBox(height: 20),
            //*****
            //project categories
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: Row(
            //     children: [
            //       Container(
            //         color: Color(0xffA0C828),
            //         height: 60,
            //         width: 3,
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Text(
            //         "Project Categories",
            //         style: TextStyle(
            //             color: Colors.black,
            //             fontWeight: FontWeight.bold,
            //             fontSize: Dimension.text_size_medium),
            //       )
            //     ],
            //   ),
            // ),
            // SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: Container(
            //       decoration: BoxDecoration(
            //           border: Border.all(
            //               color: Colors.grey, width: 1)),
            //       child: ListTile(
            //         title: categoryList.length == null
            //             ? Text(
            //                 "Categories",
            //                 style: TextStyle(fontSize: 14),
            //               )
            //             : Text(categoryList.length.toString() +
            //                 " Selected"),
            //         trailing: IconButton(
            //           onPressed: () {
            //             showDialog(
            //               barrierDismissible: false,
            //               context: context,
            //               builder: (context) {
            //                 return ButtonBarTheme(
            //                     data: ButtonBarThemeData(
            //                         alignment:
            //                             MainAxisAlignment.center),
            //                     child: AlertDialog(
            //                       actions: [
            //                         Column(
            //                           mainAxisAlignment:
            //                               MainAxisAlignment
            //                                   .center,
            //                           children: [
            //                             Container(
            //                               height: Get.height / 2,
            //                               width: Get.width,
            //                               child: Obx(() {
            //                                 if (postAJobController
            //                                     .isLoading.value)
            //                                   return Center(
            //                                     child:
            //                                         CircularProgressIndicator(),
            //                                   );
            //                                 else
            //                                   return ListView
            //                                       .builder(
            //                                           itemCount: postAJobController
            //                                               .postAjobList
            //                                               .value
            //                                               .results
            //                                               .categories
            //                                               .keys
            //                                               .length,
            //                                           itemBuilder:
            //                                               (context,
            //                                                   index) {
            //                                             List maptoListCategories = postAJobController
            //                                                 .postAjobList
            //                                                 .value
            //                                                 .results
            //                                                 .categories
            //                                                 .values
            //                                                 .toList();
            //                                             List maptoListCategoriesKeys = postAJobController
            //                                                 .postAjobList
            //                                                 .value
            //                                                 .results
            //                                                 .categories
            //                                                 .keys
            //                                                 .toList();
            //                                             return CheckboxGroup(
            //                                               labelStyle:
            //                                                   TextStyle(fontSize: 11),
            //                                               labels: [
            //                                                 maptoListCategories[
            //                                                     index]
            //                                               ],
            //                                               onChange: (bool isChecked,
            //                                                   String
            //                                                       label,
            //                                                   int inde) {
            //                                                 if (isChecked) {
            //                                                   categoryList.add(maptoListCategoriesKeys[index]);
            //                                                   print(categoryList);
            //                                                 } else {
            //                                                   categoryList.remove(maptoListCategoriesKeys[index]);
            //                                                   print(categoryList);
            //                                                 }
            //                                                 print(
            //                                                     "isChecked: $isChecked   label: $label  index: $inde");
            //                                               },
            //                                             );
            //                                           });
            //                               }),
            //                             ),
            //                             Container(
            //                               width: Get.width / 1.2,
            //                               child: Row(
            //                                 //mainAxisSize: MainAxisSize.max,
            //                                 mainAxisAlignment:
            //                                     MainAxisAlignment
            //                                         .center,
            //                                 crossAxisAlignment:
            //                                     CrossAxisAlignment
            //                                         .center,
            //                                 children: <Widget>[
            //                                   Container(
            //                                     width:
            //                                         Get.width / 3,
            //                                     child:
            //                                         GestureDetector(
            //                                       child: new Text(
            //                                         'Cancel',
            //                                         style: TextStyle(
            //                                             color: Colors
            //                                                 .white),
            //                                       ),
            //                                       color: Color(
            //                                           0xFF121A21),
            //                                       shape:
            //                                           new RoundedRectangleBorder(
            //                                         borderRadius:
            //                                             new BorderRadius
            //                                                     .circular(
            //                                                 30.0),
            //                                       ),
            //                                       onPressed: () {
            //                                         categoryList
            //                                             .clear();
            //                                         setState(
            //                                             () {});
            //                                         Get.back();
            //                                       },
            //                                     ),
            //                                   ),
            //                                   SizedBox(
            //                                       width:
            //                                           Get.width *
            //                                               0.02),
            //                                   Container(
            //                                     width:
            //                                         Get.width / 3,
            //                                     child:
            //                                         GestureDetector(
            //                                       child: new Text(
            //                                         'Save',
            //                                         style: TextStyle(
            //                                             color: Colors
            //                                                 .white),
            //                                       ),
            //                                       color: Color(
            //                                           0xFF121A21),
            //                                       shape:
            //                                           new RoundedRectangleBorder(
            //                                         borderRadius:
            //                                             new BorderRadius
            //                                                     .circular(
            //                                                 30.0),
            //                                       ),
            //                                       onPressed: () {
            //                                         print(
            //                                             categoryList);
            //                                         setState(
            //                                             () {});
            //                                         Get.back();
            //                                       },
            //                                     ),
            //                                   ),
            //                                 ],
            //                               ),
            //                             )
            //                           ],
            //                         ),
            //                       ],
            //                     ));
            //               },
            //             );
            //           },
            //           icon: Icon(Icons.arrow_drop_down),
            //         ),
            //       )),
            // ),
            // SizedBox(height: 16),
            // //*****
            // //project description
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: Row(
            //     children: [
            //       Container(
            //         color: Color(0xffA0C828),
            //         height: 60,
            //         width: 3,
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Text(
            //         "Project Description",
            //         style: TextStyle(
            //             color: Colors.black,
            //             fontWeight: FontWeight.bold,
            //             fontSize: Dimension.text_size_medium),
            //       )
            //     ],
            //   ),
            // ),
            // SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: TextField(
            //     controller: _jobTitle,
            //     autofocus: false,
            //     focusNode: FocusNode(),
            //     decoration: InputDecoration(
            //         hintText: 'Project Title',
            //         border: OutlineInputBorder()),
            //   ),
            // ),
            // SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: Container(
            //     padding: EdgeInsets.all(6),
            //     decoration: BoxDecoration(
            //         border:
            //             Border.all(color: Colors.grey, width: 1)),
            //     child: DropdownButton(
            //       isExpanded: true,
            //       hint: Text(
            //         "Select Custom Price",
            //         style: TextStyle(fontSize: 14),
            //       ),
            //       underline: SizedBox(),
            //       items: postAJobController
            //           .postAjobList.value.results.priceType.keys
            //           .map((values) {
            //         return DropdownMenuItem(
            //           value: values,
            //           child: Padding(
            //             padding: const EdgeInsets.only(
            //                 left: 8.0, right: 8.0),
            //             child: Text(
            //               toBeginningOfSentenceCase(values),
            //               style: TextStyle(),
            //             ),
            //           ),
            //         );
            //       }).toList(),
            //       value: customPriceType,
            //       onChanged: (valueSelectedByUser) {
            //         setState(() {
            //           customPriceType = valueSelectedByUser;
            //         });
            //       },
            //     ),
            //   ),
            // ),
            // SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: TextField(
            //     autofocus: false,
            //     focusNode: FocusNode(),
            //     controller: _customPriceValue,
            //     keyboardType: TextInputType.number,
            //     decoration: InputDecoration(
            //         hintText: 'Custom Price Value',
            //         border: OutlineInputBorder()),
            //   ),
            // ),
            // SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: Container(
            //     padding: EdgeInsets.all(6),
            //     decoration: BoxDecoration(
            //         border:
            //             Border.all(color: Colors.grey, width: 1)),
            //     child: DropdownButton(
            //       isExpanded: true,
            //       hint: Text(
            //         "Select Project Duration",
            //         style: TextStyle(fontSize: 14),
            //       ),
            //       items: postAJobController.postAjobList.value
            //           .results.projectDuration.keys
            //           .map((values) {
            //         return DropdownMenuItem(
            //           value: values,
            //           child: Padding(
            //             padding: const EdgeInsets.only(
            //                 left: 8.0, right: 8.0),
            //             child: Text(
            //               postAJobController.postAjobList.value
            //                   .results.projectDuration[values],
            //               //values
            //               /*postAJobController.postAjobList.value.results
            //               .projectDuration[values]*/
            //
            //               style: TextStyle(),
            //             ),
            //           ),
            //         );
            //       }).toList(),
            //       value: projectDuration,
            //       underline: SizedBox(),
            //       onChanged: (valueSelectedByUser) {
            //         setState(() {
            //           projectDuration = valueSelectedByUser;
            //         });
            //       },
            //     ),
            //   ),
            // ),
            // SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: Container(
            //     padding: EdgeInsets.all(6),
            //     decoration: BoxDecoration(
            //         border:
            //             Border.all(color: Colors.grey, width: 1)),
            //     child: DropdownButton(
            //       isExpanded: true,
            //       hint: Text(
            //         "Select Construction Level",
            //         style: TextStyle(fontSize: 14),
            //       ),
            //       items: postAJobController.postAjobList.value
            //           .results.freelancerLevel.keys
            //           .map((values) {
            //         return DropdownMenuItem(
            //           value: values,
            //           child: Padding(
            //             padding: const EdgeInsets.only(
            //                 left: 8.0, right: 8.0),
            //             child: Text(
            //               postAJobController.postAjobList.value
            //                   .results.freelancerLevel[values],
            //               style: TextStyle(),
            //             ),
            //           ),
            //         );
            //       }).toList(),
            //       value: freelancerLevel,
            //       underline: SizedBox(),
            //       onChanged: (valueSelectedByUser) {
            //         setState(() {
            //           freelancerLevel = valueSelectedByUser;
            //         });
            //       },
            //     ),
            //   ),
            // ),
            // SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: Container(
            //     padding: EdgeInsets.all(6),
            //     decoration: BoxDecoration(
            //         border:
            //             Border.all(color: Colors.grey, width: 1)),
            //     child: DropdownButton(
            //       isExpanded: true,
            //       hint: Text(
            //         "Select Measurement",
            //         style: TextStyle(fontSize: 14),
            //       ),
            //       items: postAJobController
            //           .postAjobList.value.results.measurement.keys
            //           .map((values) {
            //         return DropdownMenuItem(
            //           value: values,
            //           child: Padding(
            //             padding: const EdgeInsets.only(
            //                 left: 8.0, right: 8.0),
            //             child: Text(
            //               postAJobController.postAjobList.value
            //                   .results.measurement[values],
            //               style: TextStyle(),
            //             ),
            //           ),
            //         );
            //       }).toList(),
            //       value: mesurement,
            //       underline: SizedBox(),
            //       onChanged: (valueSelectedByUser) {
            //         setState(() {
            //           mesurement = valueSelectedByUser;
            //           print(mesurement);
            //         });
            //       },
            //     ),
            //   ),
            // ),
            // SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: TextField(
            //     autofocus: false,
            //     focusNode: FocusNode(),
            //     controller: _measurementValue,
            //     keyboardType: TextInputType.number,
            //     onChanged: (value) {
            //       setState(() {
            //         projectCostMul = int.parse(_squares.text) *
            //             int.parse(value);
            //         FocusScope.of(context).nextFocus();
            //         print(projectCostMul);
            //       });
            //     },
            //     decoration: InputDecoration(
            //         hintText: 'Measurement Value',
            //         border: OutlineInputBorder()),
            //   ),
            // ),
            // SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: GestureDetector(
            //     onTap: () {
            //       showDatePicker(
            //               context: context,
            //               initialDate: _startDate == null
            //                   ? DateTime.now()
            //                   : _startDate,
            //               firstDate: DateTime(2021),
            //               lastDate: DateTime(2030))
            //           .then((date) {
            //         setState(() {
            //           _startDate = date;
            //           convertedDateTimeStart =
            //               "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
            //         });
            //       });
            //     },
            //     child: Container(
            //         decoration: BoxDecoration(
            //             border: Border.all(
            //                 color: Colors.grey, width: 1)),
            //         child: ListTile(
            //           title: convertedDateTimeStart == null
            //               ? Text(
            //                   "Please Select Your Start Date",
            //                   style: TextStyle(fontSize: 14),
            //                 )
            //               : Text(
            //                   convertedDateTimeStart.toString()),
            //           trailing: IconButton(
            //             onPressed: () {
            //               showDatePicker(
            //                       context: context,
            //                       initialDate: _startDate == null
            //                           ? DateTime.now()
            //                           : _startDate,
            //                       firstDate: DateTime(2021),
            //                       lastDate: DateTime(2030))
            //                   .then((date) {
            //                 setState(() {
            //                   _startDate = date;
            //                   convertedDateTimeStart =
            //                       "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
            //                 });
            //               });
            //             },
            //             icon: Icon(Icons.date_range),
            //           ),
            //         )),
            //   ),
            // ),
            // SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: GestureDetector(
            //     onTap: () {
            //       showDatePicker(
            //               context: context,
            //               initialDate: _endDate == null
            //                   ? DateTime.now()
            //                   : _endDate,
            //               firstDate: DateTime(2021),
            //               lastDate: DateTime(2030))
            //           .then((date) {
            //         setState(() {
            //           _endDate = date;
            //           convertedDateTimeEnd =
            //               "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
            //         });
            //       });
            //     },
            //     child: Container(
            //         decoration: BoxDecoration(
            //             border: Border.all(
            //                 color: Colors.grey, width: 1)),
            //         child: ListTile(
            //           title: convertedDateTimeEnd == null
            //               ? Text(
            //                   "Please Select Your End Date",
            //                   style: TextStyle(fontSize: 14),
            //                 )
            //               : Text(convertedDateTimeEnd.toString()),
            //           trailing: IconButton(
            //             onPressed: () {
            //               showDatePicker(
            //                       context: context,
            //                       initialDate: _endDate == null
            //                           ? DateTime.now()
            //                           : _endDate,
            //                       firstDate: DateTime(2021),
            //                       lastDate: DateTime(2030))
            //                   .then((date) {
            //                 setState(() {
            //                   _endDate = date;
            //                   convertedDateTimeEnd =
            //                       "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
            //                 });
            //               });
            //             },
            //             icon: Icon(Icons.date_range),
            //           ),
            //         )),
            //   ),
            // ),
            // SizedBox(height: 16),
            // Container(
            //   child: Column(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 24),
            //         child: Row(
            //           children: [
            //             Container(
            //               color: Color(0xffA0C828),
            //               height: 60,
            //               width: 3,
            //             ),
            //             SizedBox(
            //               width: 10,
            //             ),
            //             Column(
            //               crossAxisAlignment:
            //                   CrossAxisAlignment.start,
            //               children: [
            //                 Text(
            //                   "Additional Details",
            //                   style: TextStyle(
            //                       color: Colors.black,
            //                       fontWeight: FontWeight.bold,
            //                       fontSize:
            //                           Dimension.text_size_small),
            //                 ),
            //                 Text(
            //                   "(Optional)",
            //                   style: TextStyle(
            //                       color: Colors.black,
            //                       fontWeight: FontWeight.bold,
            //                       fontSize:
            //                           Dimension.text_size_small),
            //                 ),
            //               ],
            //             )
            //           ],
            //         ),
            //       ),
            //       SizedBox(height: 16),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 24),
            //         child: Container(
            //           padding: EdgeInsets.all(6),
            //           decoration: BoxDecoration(
            //               border: Border.all(
            //                   color: Colors.grey, width: 1)),
            //           child: DropdownButton(
            //             isExpanded: true,
            //             hint: Text(
            //               "Select Expiration",
            //               style: TextStyle(fontSize: 14),
            //             ),
            //             items: postALeadController.postALeadList
            //                 .value.results.leadExpiration.keys
            //                 .map((values) {
            //               return DropdownMenuItem(
            //                 value: values,
            //                 child: Padding(
            //                   padding: const EdgeInsets.only(
            //                       left: 8.0, right: 8.0),
            //                   child: Text(
            //                     values,
            //                     style: TextStyle(),
            //                   ),
            //                 ),
            //               );
            //             }).toList(),
            //             value: leadExpiration,
            //             underline: SizedBox(),
            //             onChanged: (valueSelectedByUser) {
            //               setState(() {
            //                 leadExpiration = valueSelectedByUser;
            //                 print(leadExpiration);
            //               });
            //             },
            //           ),
            //         ),
            //       ),
            //       SizedBox(height: 16),
            //       // Padding(
            //       //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //       //   child: TextField(
            //       //     autofocus: false,
            //       //     focusNode: FocusNode(),
            //       //     keyboardType: TextInputType.number,
            //       //     controller: _credits,
            //       //     decoration: InputDecoration(
            //       //         hintText:
            //       //             'How many Credits e.g. \$1 dollar = 1 Credit',
            //       //         border: OutlineInputBorder()),
            //       //   ),
            //       // ),
            //       // SizedBox(height: 16),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 24),
            //         child: Container(
            //           padding: EdgeInsets.all(6),
            //           decoration: BoxDecoration(
            //               border: Border.all(
            //                   color: Colors.grey, width: 1)),
            //           child: DropdownButton(
            //             isExpanded: true,
            //             hint: Text(
            //               "Do They Have Insurance",
            //               style: TextStyle(fontSize: 14),
            //             ),
            //             items: postALeadController.postALeadList
            //                 .value.results.leadInsurance.keys
            //                 .map((values) {
            //               return DropdownMenuItem(
            //                 value: values,
            //                 child: Padding(
            //                   padding: const EdgeInsets.only(
            //                       left: 8.0, right: 8.0),
            //                   child: Text(
            //                     values,
            //                     style: TextStyle(),
            //                   ),
            //                 ),
            //               );
            //             }).toList(),
            //             value: haveInsurance,
            //             underline: SizedBox(),
            //             onChanged: (valueSelectedByUser) {
            //               setState(() {
            //                 haveInsurance = valueSelectedByUser;
            //                 print(haveInsurance);
            //               });
            //             },
            //           ),
            //         ),
            //       ),
            //       SizedBox(height: 16),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 24),
            //         child: Container(
            //           padding: EdgeInsets.all(6),
            //           decoration: BoxDecoration(
            //               border: Border.all(
            //                   color: Colors.grey, width: 1)),
            //           child: DropdownButton(
            //             isExpanded: true,
            //             hint: Text(
            //               "Who Is There Insurance Company",
            //               style: TextStyle(fontSize: 14),
            //             ),
            //             items: postALeadController.postALeadList
            //                 .value.results.insuranceCompany.keys
            //                 .map((values) {
            //               return DropdownMenuItem(
            //                 value: values,
            //                 child: Padding(
            //                   padding: const EdgeInsets.only(
            //                       left: 8.0, right: 8.0),
            //                   child: Text(
            //                     values.toString(),
            //                     style: TextStyle(),
            //                   ),
            //                 ),
            //               );
            //             }).toList(),
            //             value: isThereIsuranceCom,
            //             underline: SizedBox(),
            //             onChanged: (valueSelectedByUser) {
            //               setState(() {
            //                 isThereIsuranceCom =
            //                     valueSelectedByUser;
            //                 print(isThereIsuranceCom);
            //               });
            //             },
            //           ),
            //         ),
            //       ),
            //       SizedBox(height: 16),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 24),
            //         child: TextField(
            //           autofocus: false,
            //           focusNode: FocusNode(),
            //           keyboardType: TextInputType.number,
            //           controller: _squares,
            //           onChanged: (value) {
            //             setState(() {
            //               projectCostMul =
            //                   int.parse(_measurementValue.text) *
            //                       int.parse(value);
            //               //FocusScope.of(context).unfocus();
            //               print(projectCostMul);
            //             });
            //           },
            //           decoration: InputDecoration(
            //               hintText: 'How Many Squares',
            //               border: OutlineInputBorder()),
            //         ),
            //       ),
            //       SizedBox(height: 16),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 24),
            //         child: Container(
            //           padding: EdgeInsets.all(6),
            //           decoration: BoxDecoration(
            //               border: Border.all(
            //                   color: Colors.grey, width: 1)),
            //           child: DropdownButton(
            //             isExpanded: true,
            //             hint: Text(
            //               "Number of Stories",
            //               style: TextStyle(fontSize: 14),
            //             ),
            //             items: postALeadController.postALeadList
            //                 .value.results.noOfStories
            //                 .map((values) {
            //               return DropdownMenuItem(
            //                 value: values,
            //                 child: Padding(
            //                   padding: const EdgeInsets.only(
            //                       left: 8.0, right: 8.0),
            //                   child: Text(
            //                     values.toString(),
            //                     style: TextStyle(),
            //                   ),
            //                 ),
            //               );
            //             }).toList(),
            //             value: numberofStories,
            //             underline: SizedBox(),
            //             onChanged: (valueSelectedByUser) {
            //               setState(() {
            //                 numberofStories = valueSelectedByUser;
            //                 print(numberofStories);
            //               });
            //             },
            //           ),
            //         ),
            //       ),
            //       SizedBox(height: 16),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 24),
            //         child: Container(
            //           padding: EdgeInsets.all(6),
            //           decoration: BoxDecoration(
            //               border: Border.all(
            //                   color: Colors.grey, width: 1)),
            //           child: DropdownButton(
            //             isExpanded: true,
            //             hint: Text(
            //               "Age of Roof",
            //               style: TextStyle(fontSize: 14),
            //             ),
            //             items: postALeadController
            //                 .postALeadList.value.results.ageOfRoof
            //                 .map((values) {
            //               return DropdownMenuItem(
            //                 value: values,
            //                 child: Padding(
            //                   padding: const EdgeInsets.only(
            //                       left: 8.0, right: 8.0),
            //                   child: Text(
            //                     values,
            //                     style: TextStyle(),
            //                   ),
            //                 ),
            //               );
            //             }).toList(),
            //             value: ageOfRoofs,
            //             underline: SizedBox(),
            //             onChanged: (valueSelectedByUser) {
            //               setState(() {
            //                 ageOfRoofs = valueSelectedByUser;
            //                 print(ageOfRoofs);
            //               });
            //             },
            //           ),
            //         ),
            //       ),
            //       SizedBox(height: 16),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 24),
            //         child: Container(
            //           padding: EdgeInsets.all(6),
            //           decoration: BoxDecoration(
            //               border: Border.all(
            //                   color: Colors.grey, width: 1)),
            //           child: DropdownButton(
            //             isExpanded: true,
            //             hint: Text(
            //               "Type of Roof",
            //               style: TextStyle(fontSize: 14),
            //             ),
            //             items: postALeadController.postALeadList
            //                 .value.results.typeOfRoof.keys
            //                 .map((values) {
            //               return DropdownMenuItem(
            //                 value: values,
            //                 child: Padding(
            //                   padding: const EdgeInsets.only(
            //                       left: 8.0, right: 8.0),
            //                   child: Text(
            //                     postALeadController
            //                         .postALeadList
            //                         .value
            //                         .results
            //                         .typeOfRoof[values]
            //                         .toString(),
            //                     style: TextStyle(),
            //                   ),
            //                 ),
            //               );
            //             }).toList(),
            //             value: typeOfRoofs,
            //             underline: SizedBox(),
            //             onChanged: (valueSelectedByUser) {
            //               setState(() {
            //                 typeOfRoofs = valueSelectedByUser;
            //                 print(typeOfRoofs);
            //               });
            //             },
            //           ),
            //         ),
            //       ),
            //       SizedBox(height: 16),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 24),
            //         child: Container(
            //           padding: EdgeInsets.all(6),
            //           decoration: BoxDecoration(
            //               border: Border.all(
            //                   color: Colors.grey, width: 1)),
            //           child: DropdownButton(
            //             isExpanded: true,
            //             hint: Text(
            //               "Property Type",
            //               style: TextStyle(fontSize: 14),
            //             ),
            //             items: postALeadController.postALeadList
            //                 .value.results.propertyType.keys
            //                 .map((values) {
            //               return DropdownMenuItem(
            //                 value: values,
            //                 child: Padding(
            //                   padding: const EdgeInsets.only(
            //                       left: 8.0, right: 8.0),
            //                   child: Text(
            //                     postALeadController
            //                         .postALeadList
            //                         .value
            //                         .results
            //                         .propertyType[values]
            //                         .toString(),
            //                     style: TextStyle(),
            //                   ),
            //                 ),
            //               );
            //             }).toList(),
            //             value: propertyType,
            //             underline: SizedBox(),
            //             onChanged: (valueSelectedByUser) {
            //               setState(() {
            //                 propertyType = valueSelectedByUser;
            //                 print(propertyType);
            //               });
            //             },
            //           ),
            //         ),
            //       ),
            //       SizedBox(height: 16),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 24),
            //         child: TextField(
            //           autofocus: false,
            //           focusNode: FocusNode(),
            //           controller: _leadContactName,
            //           decoration: InputDecoration(
            //               hintText: 'Project Contact Name',
            //               border: OutlineInputBorder()),
            //         ),
            //       ),
            //       SizedBox(height: 16),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 24),
            //         child: TextField(
            //           autofocus: false,
            //           focusNode: FocusNode(),
            //           controller: _leadContactNumber,
            //           decoration: InputDecoration(
            //               hintText:
            //                   'Project Contact Phone Number',
            //               border: OutlineInputBorder()),
            //         ),
            //       ),
            //       SizedBox(height: 16),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 24),
            //         child: TextField(
            //           autofocus: false,
            //           focusNode: FocusNode(),
            //           controller: _leadContactEmail,
            //           decoration: InputDecoration(
            //               hintText: 'Project Contact Email',
            //               border: OutlineInputBorder()),
            //         ),
            //       ),
            //       SizedBox(height: 16),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 24),
            //         child: GestureDetector(
            //           onTap: () {
            //             showDatePicker(
            //                     context: context,
            //                     initialDate:
            //                         setDateAndTime == null
            //                             ? DateTime.now()
            //                             : setDateAndTime,
            //                     firstDate: DateTime(2021),
            //                     lastDate: DateTime(2030))
            //                 .then((date) {
            //               setState(() {
            //                 setDateAndTime = date;
            //                 print(
            //                     "Project Expiration Date and Time");
            //                 print(setDateAndTime);
            //                 convertedSetDateAndTime =
            //                     "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
            //               });
            //             });
            //           },
            //           child: Container(
            //               decoration: BoxDecoration(
            //                   border: Border.all(
            //                       color: Colors.grey, width: 1)),
            //               child: ListTile(
            //                 title: convertedSetDateAndTime == null
            //                     ? Text(
            //                         "Project Expiration Date",
            //                         style:
            //                             TextStyle(fontSize: 14),
            //                       )
            //                     : Text(convertedSetDateAndTime
            //                         .toString()),
            //                 trailing: IconButton(
            //                   onPressed: () {
            //                     showDatePicker(
            //                             context: context,
            //                             initialDate:
            //                                 setDateAndTime == null
            //                                     ? DateTime.now()
            //                                     : setDateAndTime,
            //                             firstDate: DateTime(2021),
            //                             lastDate: DateTime(2030))
            //                         .then((date) {
            //                       setState(() {
            //                         setDateAndTime = date;
            //                         print(
            //                             "Project Expiration Date and Time");
            //                         print(setDateAndTime);
            //                         convertedSetDateAndTime =
            //                             "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
            //                       });
            //                     });
            //                   },
            //                   icon: Icon(Icons.date_range),
            //                 ),
            //               )),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: Row(
            //     children: [
            //       Container(
            //         color: Color(0xffA0C828),
            //         height: 60,
            //         width: 3,
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Text(
            //         "Project Cost",
            //         style: TextStyle(
            //             color: Colors.black,
            //             fontWeight: FontWeight.bold,
            //             fontSize: Dimension.text_size_medium),
            //       )
            //     ],
            //   ),
            // ),
            // SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: TextField(
            //     keyboardType: TextInputType.number,
            //     autofocus: false,
            //     focusNode: FocusNode(),
            //     onChanged: (value) {
            //       projectCostMul = value.toString();
            //
            //       print("Project Cost is ${projectCostMul}");
            //     },
            //     decoration: InputDecoration(
            //         hintText: 'Project Cost',
            //         border: OutlineInputBorder()),
            //   ),
            // ),

            //     /* Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: Container(
            //     height: 60,
            //     width: 320,
            //     decoration: BoxDecoration(
            //         border: Border.all(color: Colors.black)),
            //     child: Row(
            //       children: [
            //         SizedBox(
            //           width: 8,
            //         ),
            //         projectCostMul == null
            //             ? Text("Project Cost")
            //             : Text(projectCostMul.toString()),
            //       ],
            //     ),
            //   ),
            // ),*/
            //     SizedBox(height: 16),
            //     // Padding(
            //     //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //     //   child: Row(
            //     //     children: [
            //     //       Container(
            //     //         color: Color(0xffA0C828),
            //     //         height: 60,
            //     //         width: 3,
            //     //       ),
            //     //       SizedBox(
            //     //         width: 10,
            //     //       ),
            //     //       Text(
            //     //         "Project Categories",
            //     //         style: TextStyle(
            //     //             color: Colors.black,
            //     //             fontWeight: FontWeight.bold,
            //     //             fontSize: Dimension.text_size_medium),
            //     //       )
            //     //     ],
            //     //   ),
            //     // ),
            //     // SizedBox(height: 16),
            //     // Padding(
            //     //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //     //   child: Container(
            //     //       decoration: BoxDecoration(
            //     //           border: Border.all(color: Colors.grey, width: 1)),
            //     //       child: ListTile(
            //     //         title: categoryList.length == null
            //     //             ? Text(
            //     //                 "Categories",
            //     //                 style: TextStyle(fontSize: 14),
            //     //               )
            //     //             : Text(categoryList.length.toString() +
            //     //                 " Selected"),
            //     //         trailing: IconButton(
            //     //           onPressed: () {
            //     //             showDialog(
            //     //               barrierDismissible: false,
            //     //               context: context,
            //     //               builder: (context) {
            //     //                 return ButtonBarTheme(
            //     //                     data: ButtonBarThemeData(
            //     //                         alignment:
            //     //                             MainAxisAlignment.center),
            //     //                     child: AlertDialog(
            //     //                       actions: [
            //     //                         Column(
            //     //                           mainAxisAlignment:
            //     //                               MainAxisAlignment.center,
            //     //                           children: [
            //     //                             Container(
            //     //                               height: Get.height / 2,
            //     //                               width: Get.width,
            //     //                               child: Obx(() {
            //     //                                 if (postAJobController
            //     //                                     .isLoading.value)
            //     //                                   return Center(
            //     //                                     child:
            //     //                                         CircularProgressIndicator(),
            //     //                                   );
            //     //                                 else
            //     //                                   return ListView.builder(
            //     //                                       itemCount:
            //     //                                           postAJobController
            //     //                                               .postAjobList
            //     //                                               .value
            //     //                                               .results
            //     //                                               .categories
            //     //                                               .keys
            //     //                                               .length,
            //     //                                       itemBuilder:
            //     //                                           (context, index) {
            //     //                                         List
            //     //                                             maptoListCategories =
            //     //                                             postAJobController
            //     //                                                 .postAjobList
            //     //                                                 .value
            //     //                                                 .results
            //     //                                                 .categories
            //     //                                                 .values
            //     //                                                 .toList();
            //     //                                         List
            //     //                                             maptoListCategoriesKeys =
            //     //                                             postAJobController
            //     //                                                 .postAjobList
            //     //                                                 .value
            //     //                                                 .results
            //     //                                                 .categories
            //     //                                                 .keys
            //     //                                                 .toList();
            //     //                                         return CheckboxGroup(
            //     //                                           labelStyle:
            //     //                                               TextStyle(
            //     //                                                   fontSize:
            //     //                                                       11),
            //     //                                           labels: [
            //     //                                             maptoListCategories[
            //     //                                                 index]
            //     //                                           ],
            //     //                                           onChange: (bool
            //     //                                                   isChecked,
            //     //                                               String label,
            //     //                                               int inde) {
            //     //                                             if (isChecked) {
            //     //                                               categoryList.add(
            //     //                                                   maptoListCategoriesKeys[
            //     //                                                       index]);
            //     //                                               print(
            //     //                                                   categoryList);
            //     //                                             } else {
            //     //                                               categoryList.remove(
            //     //                                                   maptoListCategoriesKeys[
            //     //                                                       index]);
            //     //                                               print(
            //     //                                                   categoryList);
            //     //                                             }
            //     //                                             print(
            //     //                                                 "isChecked: $isChecked   label: $label  index: $inde");
            //     //                                           },
            //     //                                         );
            //     //                                       });
            //     //                               }),
            //     //                             ),
            //     //                             Container(
            //     //                               width: Get.width / 1.2,
            //     //                               child: Row(
            //     //                                 //mainAxisSize: MainAxisSize.max,
            //     //                                 mainAxisAlignment:
            //     //                                     MainAxisAlignment
            //     //                                         .center,
            //     //                                 crossAxisAlignment:
            //     //                                     CrossAxisAlignment
            //     //                                         .center,
            //     //                                 children: <Widget>[
            //     //                                   Container(
            //     //                                     width: Get.width / 3,
            //     //                                     child: GestureDetector(
            //     //                                       child: new Text(
            //     //                                         'Cancel',
            //     //                                         style: TextStyle(
            //     //                                             color: Colors
            //     //                                                 .white),
            //     //                                       ),
            //     //                                       color:
            //     //                                           Color(0xFF121A21),
            //     //                                       shape:
            //     //                                           new RoundedRectangleBorder(
            //     //                                         borderRadius:
            //     //                                             new BorderRadius
            //     //                                                     .circular(
            //     //                                                 30.0),
            //     //                                       ),
            //     //                                       onPressed: () {
            //     //                                         categoryList
            //     //                                             .clear();
            //     //                                         setState(() {});
            //     //                                         Get.back();
            //     //                                       },
            //     //                                     ),
            //     //                                   ),
            //     //                                   SizedBox(
            //     //                                       width:
            //     //                                           Get.width * 0.02),
            //     //                                   Container(
            //     //                                     width: Get.width / 3,
            //     //                                     child: GestureDetector(
            //     //                                       child: new Text(
            //     //                                         'Save',
            //     //                                         style: TextStyle(
            //     //                                             color: Colors
            //     //                                                 .white),
            //     //                                       ),
            //     //                                       color:
            //     //                                           Color(0xFF121A21),
            //     //                                       shape:
            //     //                                           new RoundedRectangleBorder(
            //     //                                         borderRadius:
            //     //                                             new BorderRadius
            //     //                                                     .circular(
            //     //                                                 30.0),
            //     //                                       ),
            //     //                                       onPressed: () {
            //     //                                         print(categoryList);
            //     //                                         setState(() {});
            //     //                                         Get.back();
            //     //                                       },
            //     //                                     ),
            //     //                                   ),
            //     //                                 ],
            //     //                               ),
            //     //                             )
            //     //                           ],
            //     //                         ),
            //     //                       ],
            //     //                     ));
            //     //               },
            //     //             );
            //     //           },
            //     //           icon: Icon(Icons.arrow_drop_down),
            //     //         ),
            //     //       )),
            //     // ),
            //     // SizedBox(height: 16),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 24),
            //       child: Row(
            //         children: [
            //           Container(
            //             color: Color(0xffA0C828),
            //             height: 60,
            //             width: 3,
            //           ),
            //           SizedBox(
            //             width: 10,
            //           ),
            //           Text(
            //             "Languages",
            //             style: TextStyle(
            //                 color: Colors.black,
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: Dimension.text_size_medium),
            //           )
            //         ],
            //       ),
            //     ),
            //     SizedBox(height: 16),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 24),
            //       child: Container(
            //           decoration: BoxDecoration(
            //               border: Border.all(
            //                   color: Colors.grey, width: 1)),
            //           child: ListTile(
            //             title: languageList.length == null
            //                 ? Text(
            //                     "Categories",
            //                     style: TextStyle(fontSize: 14),
            //                   )
            //                 : Text(languageList.length.toString() +
            //                     " Selected"),
            //             trailing: IconButton(
            //               onPressed: () {
            //                 showDialog(
            //                   barrierDismissible: false,
            //                   context: context,
            //                   builder: (context) {
            //                     return ButtonBarTheme(
            //                         data: ButtonBarThemeData(
            //                             alignment:
            //                                 MainAxisAlignment.center),
            //                         child: AlertDialog(
            //                           actions: [
            //                             Column(
            //                               mainAxisAlignment:
            //                                   MainAxisAlignment
            //                                       .center,
            //                               children: [
            //                                 Container(
            //                                   height: Get.height / 4,
            //                                   width: Get.width,
            //                                   child: Obx(() {
            //                                     if (postAJobController
            //                                         .isLoading.value)
            //                                       return Center(
            //                                         child:
            //                                             CircularProgressIndicator(),
            //                                       );
            //                                     else
            //                                       return ListView
            //                                           .builder(
            //                                               itemCount: postAJobController
            //                                                   .postAjobList
            //                                                   .value
            //                                                   .results
            //                                                   .languages
            //                                                   .keys
            //                                                   .length,
            //                                               itemBuilder:
            //                                                   (context,
            //                                                       index) {
            //                                                 List maptoListLanguages = postAJobController
            //                                                     .postAjobList
            //                                                     .value
            //                                                     .results
            //                                                     .languages
            //                                                     .values
            //                                                     .toList();
            //                                                 List maptoListLanguagesKeys = postAJobController
            //                                                     .postAjobList
            //                                                     .value
            //                                                     .results
            //                                                     .languages
            //                                                     .keys
            //                                                     .toList();
            //                                                 return CheckboxGroup(
            //                                                   labelStyle:
            //                                                       TextStyle(fontSize: 11),
            //                                                   labels: [
            //                                                     maptoListLanguages[
            //                                                         index]
            //                                                   ],
            //                                                   onChange: (bool isChecked,
            //                                                       String
            //                                                           label,
            //                                                       int inde) {
            //                                                     if (isChecked) {
            //                                                       languageList.add(maptoListLanguagesKeys[index]);
            //                                                       print(languageList);
            //                                                     } else {
            //                                                       languageList.remove(maptoListLanguagesKeys[index]);
            //                                                       print(languageList);
            //                                                     }
            //                                                     print(
            //                                                         "isChecked: $isChecked   label: $label  index: $inde");
            //                                                   },
            //                                                 );
            //                                               });
            //                                   }),
            //                                 ),
            //                                 Container(
            //                                   width: Get.width / 1.2,
            //                                   child: Row(
            //                                     //mainAxisSize: MainAxisSize.max,
            //                                     mainAxisAlignment:
            //                                         MainAxisAlignment
            //                                             .center,
            //                                     crossAxisAlignment:
            //                                         CrossAxisAlignment
            //                                             .center,
            //                                     children: <Widget>[
            //                                       Container(
            //                                         width:
            //                                             Get.width / 3,
            //                                         child:
            //                                             GestureDetector(
            //                                           child: new Text(
            //                                             'Cancel',
            //                                             style: TextStyle(
            //                                                 color: Colors
            //                                                     .white),
            //                                           ),
            //                                           color: Color(
            //                                               0xFF121A21),
            //                                           shape:
            //                                               new RoundedRectangleBorder(
            //                                             borderRadius:
            //                                                 new BorderRadius
            //                                                         .circular(
            //                                                     30.0),
            //                                           ),
            //                                           onPressed: () {
            //                                             languageList
            //                                                 .clear();
            //                                             setState(
            //                                                 () {});
            //                                             Get.back();
            //                                           },
            //                                         ),
            //                                       ),
            //                                       SizedBox(
            //                                           width:
            //                                               Get.width *
            //                                                   0.02),
            //                                       Container(
            //                                         width:
            //                                             Get.width / 3,
            //                                         child:
            //                                             GestureDetector(
            //                                           child: new Text(
            //                                             'Save',
            //                                             style: TextStyle(
            //                                                 color: Colors
            //                                                     .white),
            //                                           ),
            //                                           color: Color(
            //                                               0xFF121A21),
            //                                           shape:
            //                                               new RoundedRectangleBorder(
            //                                             borderRadius:
            //                                                 new BorderRadius
            //                                                         .circular(
            //                                                     30.0),
            //                                           ),
            //                                           onPressed: () {
            //                                             print(
            //                                                 languageList);
            //                                             setState(
            //                                                 () {});
            //                                             Get.back();
            //                                           },
            //                                         ),
            //                                       ),
            //                                     ],
            //                                   ),
            //                                 )
            //                               ],
            //                             ),
            //                           ],
            //                         ));
            //                   },
            //                 );
            //               },
            //               icon: Icon(Icons.arrow_drop_down),
            //             ),
            //           )),
            //     ),
            //     SizedBox(height: 16),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 24),
            //       child: Row(
            //         children: [
            //           Container(
            //             color: Color(0xffA0C828),
            //             height: 60,
            //             width: 3,
            //           ),
            //           SizedBox(
            //             width: 10,
            //           ),
            //           Text(
            //             "Project Details",
            //             style: TextStyle(
            //                 color: Colors.black,
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: Dimension.text_size_medium),
            //           )
            //         ],
            //       ),
            //     ),
            //     SizedBox(height: 16),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 24),
            //       child: TextField(
            //         autofocus: false,
            //         controller: _projectDetails,
            //         focusNode: FocusNode(),
            //         maxLines: 5,
            //         decoration: InputDecoration(
            //             hintText: 'Write Your Project Details',
            //             border: OutlineInputBorder()),
            //       ),
            //     ),
            //     SizedBox(height: 16),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 24),
            //       child: Row(
            //         children: [
            //           Container(
            //             color: Color(0xffA0C828),
            //             height: 60,
            //             width: 3,
            //           ),
            //           SizedBox(
            //             width: 10,
            //           ),
            //           Text(
            //             "Skills Required",
            //             style: TextStyle(
            //                 color: Colors.black,
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: Dimension.text_size_medium),
            //           )
            //         ],
            //       ),
            //     ),
            //     SizedBox(height: 16),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 24),
            //       child: Container(
            //           decoration: BoxDecoration(
            //               border: Border.all(
            //                   color: Colors.grey, width: 1)),
            //           child: ListTile(
            //             title: skillList.length == null
            //                 ? Text("Categories")
            //                 : Text(skillList.length.toString() +
            //                     " Selected"),
            //             trailing: IconButton(
            //               onPressed: () {
            //                 showDialog(
            //                   barrierDismissible: false,
            //                   context: context,
            //                   builder: (context) {
            //                     return ButtonBarTheme(
            //                         data: ButtonBarThemeData(
            //                             alignment:
            //                                 MainAxisAlignment.center),
            //                         child: AlertDialog(
            //                           actions: [
            //                             Column(
            //                               mainAxisAlignment:
            //                                   MainAxisAlignment
            //                                       .center,
            //                               children: [
            //                                 Container(
            //                                   height: Get.height / 3,
            //                                   width: Get.width,
            //                                   child: Obx(() {
            //                                     if (postAJobController
            //                                         .isLoading.value)
            //                                       return Center(
            //                                         child:
            //                                             CircularProgressIndicator(),
            //                                       );
            //                                     else
            //                                       return ListView
            //                                           .builder(
            //                                               itemCount: postAJobController
            //                                                   .postAjobList
            //                                                   .value
            //                                                   .results
            //                                                   .skills
            //                                                   .keys
            //                                                   .length,
            //                                               itemBuilder:
            //                                                   (context,
            //                                                       index) {
            //                                                 List maptoListSkills = postAJobController
            //                                                     .postAjobList
            //                                                     .value
            //                                                     .results
            //                                                     .skills
            //                                                     .values
            //                                                     .toList();
            //                                                 List maptoListSkillsKeys = postAJobController
            //                                                     .postAjobList
            //                                                     .value
            //                                                     .results
            //                                                     .skills
            //                                                     .keys
            //                                                     .toList();
            //                                                 return CheckboxGroup(
            //                                                   labelStyle:
            //                                                       TextStyle(fontSize: 11),
            //                                                   labels: [
            //                                                     maptoListSkills[
            //                                                         index]
            //                                                   ],
            //                                                   onChange: (bool isChecked,
            //                                                       String
            //                                                           label,
            //                                                       int inde) {
            //                                                     if (isChecked) {
            //                                                       skillList.add(maptoListSkillsKeys[index]);
            //                                                       print(skillList);
            //                                                     } else {
            //                                                       skillList.remove(maptoListSkillsKeys[index]);
            //                                                       print(skillList);
            //                                                     }
            //                                                     print(
            //                                                         "isChecked: $isChecked   label: $label  index: $inde");
            //                                                   },
            //                                                 );
            //                                               });
            //                                   }),
            //                                 ),
            //                                 Container(
            //                                   width: Get.width / 1.2,
            //                                   child: Row(
            //                                     //mainAxisSize: MainAxisSize.max,
            //                                     mainAxisAlignment:
            //                                         MainAxisAlignment
            //                                             .center,
            //                                     crossAxisAlignment:
            //                                         CrossAxisAlignment
            //                                             .center,
            //                                     children: <Widget>[
            //                                       Container(
            //                                         width:
            //                                             Get.width / 3,
            //                                         child:
            //                                             GestureDetector(
            //                                           child: new Text(
            //                                             'Cancel',
            //                                             style: TextStyle(
            //                                                 color: Colors
            //                                                     .white),
            //                                           ),
            //                                           color: Color(
            //                                               0xFF121A21),
            //                                           shape:
            //                                               new RoundedRectangleBorder(
            //                                             borderRadius:
            //                                                 new BorderRadius
            //                                                         .circular(
            //                                                     30.0),
            //                                           ),
            //                                           onPressed: () {
            //                                             skillList
            //                                                 .clear();
            //                                             setState(
            //                                                 () {});
            //                                             Get.back();
            //                                           },
            //                                         ),
            //                                       ),
            //                                       SizedBox(
            //                                           width:
            //                                               Get.width *
            //                                                   0.02),
            //                                       Container(
            //                                         width:
            //                                             Get.width / 3,
            //                                         child:
            //                                             GestureDetector(
            //                                           child: new Text(
            //                                             'Save',
            //                                             style: TextStyle(
            //                                                 color: Colors
            //                                                     .white),
            //                                           ),
            //                                           color: Color(
            //                                               0xFF121A21),
            //                                           shape:
            //                                               new RoundedRectangleBorder(
            //                                             borderRadius:
            //                                                 new BorderRadius
            //                                                         .circular(
            //                                                     30.0),
            //                                           ),
            //                                           onPressed: () {
            //                                             print(
            //                                                 skillList);
            //                                             setState(
            //                                                 () {});
            //                                             Get.back();
            //                                           },
            //                                         ),
            //                                       ),
            //                                     ],
            //                                   ),
            //                                 )
            //                               ],
            //                             ),
            //                           ],
            //                         ));
            //                   },
            //                 );
            //               },
            //               icon: Icon(Icons.arrow_drop_down),
            //             ),
            //           )),
            //     ),
            //     SizedBox(height: 16),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 24),
            //       child: Row(
            //         children: [
            //           Container(
            //             color: Color(0xffA0C828),
            //             height: 60,
            //             width: 3,
            //           ),
            //           SizedBox(
            //             width: 10,
            //           ),
            //           Text(
            //             "Your Location",
            //             style: TextStyle(
            //                 color: Colors.black,
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: Dimension.text_size_medium),
            //           )
            //         ],
            //       ),
            //     ),
            //     SizedBox(height: 16),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 24),
            //       child: Container(
            //         padding: EdgeInsets.all(6),
            //         decoration: BoxDecoration(
            //             border:
            //                 Border.all(color: Colors.grey, width: 1)),
            //         child: DropdownButton(
            //           isExpanded: true,
            //           hint: Text(
            //             "Your Location",
            //             style: TextStyle(fontSize: 14),
            //           ),
            //           items: postAJobController
            //               .postAjobList.value.results.locations.keys
            //               .map((values) {
            //             return DropdownMenuItem(
            //               value: values,
            //               child: Padding(
            //                 padding: const EdgeInsets.only(
            //                     left: 8.0, right: 8.0),
            //                 child: Text(
            //                   postAJobController.postAjobList.value
            //                       .results.locations[values],
            //                   style: TextStyle(),
            //                 ),
            //               ),
            //             );
            //           }).toList(),
            //           value: locations,
            //           underline: SizedBox(),
            //           onChanged: (valueSelectedByUser) {
            //             setState(() {
            //               locations = valueSelectedByUser;
            //               print(locations);
            //             });
            //           },
            //         ),
            //       ),
            //     ),
            //     SizedBox(height: 8),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 24),
            //       child: TextField(
            //         autofocus: false,
            //         focusNode: FocusNode(),
            //         controller: postalCode,
            //         decoration: InputDecoration(
            //             hintText: 'Enter Postal Code',
            //             border: OutlineInputBorder()),
            //       ),
            //     ),
            //     SizedBox(height: 8),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 24),
            //       child: TextField(
            //           autofocus: false,
            //           controller: addresss,
            //           focusNode: FocusNode(),
            //           decoration: InputDecoration(
            //               hintText: 'Your Address',
            //               border: OutlineInputBorder()),
            //           onTap: () async {
            //             print("Search Result");
            //             final sessionToken = Uuid().v4();
            //             final Suggestion result = await showSearch(
            //                 context: context,
            //                 delegate: AddressSearch(sessionToken));
            //             if (result != null) {
            //               setState(() {
            //                 print("${result.description}");
            //                 addresss.text = result.description;
            //               });
            //             } else {
            //               setState(() {
            //                 addresss.text = SharedPref.location;
            //               });
            //             }
            //           }),
            //     ),
            //     SizedBox(height: 8),
            //     Padding(
            //       padding: const EdgeInsets.only(left: 24, right: 24),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text("Featured",
            //               style: TextStyle(
            //                   color: Colors.black,
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: Dimension.text_size_medium)),
            //           Container(
            //             child: Switch(
            //               value: isFeatured,
            //               onChanged: (value) {
            //                 setState(() {
            //                   isFeatured = value;
            //                   print(isFeatured);
            //                 });
            //               },
            //               activeTrackColor: Color(0xff2ECC71),
            //               activeColor: Color(0xff2ECC71),
            //             ),
            //           )
            //         ],
            //       ),
            //     ),
            //     SizedBox(height: 8),
            //     Padding(
            //       padding: const EdgeInsets.only(left: 24, right: 24),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text("Status",
            //               style: TextStyle(
            //                   color: Colors.black,
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: Dimension.text_size_medium)),
            //           Container(
            //             child: Switch(
            //               value: isStatus,
            //               onChanged: (value) {
            //                 setState(() {
            //                   isStatus = value;
            //                   print(isStatus);
            //                 });
            //               },
            //               activeTrackColor: Color(0xff2ECC71),
            //               activeColor: Color(0xff2ECC71),
            //             ),
            //           )
            //         ],
            //       ),
            //     ),
            //     SizedBox(height: 8),
            //     Padding(
            //       padding: const EdgeInsets.only(left: 24, right: 24),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text("Attachments",
            //               style: TextStyle(
            //                   color: Colors.black,
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: Dimension.text_size_medium)),
            //           Container(
            //             child: Switch(
            //               value: isAttachements,
            //               onChanged: (value) {
            //                 setState(() {
            //                   isAttachements = value;
            //                   print(isAttachements);
            //                 });
            //               },
            //               activeTrackColor: Color(0xff2ECC71),
            //               activeColor: Color(0xff2ECC71),
            //             ),
            //           )
            //         ],
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 24),
            //       child: Row(
            //         children: [
            //           Container(
            //             color: Color(0xffA0C828),
            //             height: 60,
            //             width: 3,
            //           ),
            //           SizedBox(
            //             width: 10,
            //           ),
            //           Text(
            //             "Your Attachments",
            //             style: TextStyle(
            //                 color: Colors.black,
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: Dimension.text_size_medium),
            //           ),
            //         ],
            //       ),
            //     ),
            //     SizedBox(height: 16),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 24),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: [
            //           GestureDetector(
            //               onPressed: () async {
            //                 /////CONTRACTOR
            //                 _isLabour == false && _isMaterial == false
            //                     ? displayMessageLead(context)
            //                     : isStatus == false
            //                         ? Fluttertoast.showToast(
            //                             msg:
            //                                 "Status Should Be Enabled",
            //                             toastLength:
            //                                 Toast.LENGTH_LONG,
            //                             gravity: ToastGravity.BOTTOM,
            //                             timeInSecForIosWeb: 1,
            //                             backgroundColor: Colors.green,
            //                             textColor: Colors.white,
            //                             fontSize: 14.0)
            //                         //: postRequestDio();
            //                         : Upload(context);
            //
            //                 // _isLabour == false && _isMaterial == false
            //                 //     ? displayMessageProject()
            //                 //     //: saveAndUpdateJob();
            //                 //     : postLeadandJob();
            //               },
            //               color: Colors.blue,
            //               child: visible == 0
            //                   ? loaderStatus == false
            //                       ? Text(
            //                           '   Post   ',
            //                           style: TextStyle(
            //                             color: Colors.white,
            //                             fontSize:
            //                                 Dimension.text_size_small,
            //                           ),
            //                         )
            //                       : CircularProgressIndicator(
            //                           color: Colors.white,
            //                         )
            //                   : Center(
            //                       child: Container(
            //                           height: 30,
            //                           width: 30,
            //                           child:
            //                               CircularProgressIndicator()),
            //                     )),
            //           SizedBox(width: 20),
            //           GestureDetector(
            //             onPressed: () {
            //               //   fileAppDialouge(context, "Select your file", "");
            //               filePick();
            //             },
            //             color: Color(0xff2ECC71),
            //             child: Text(
            //               'Select File',
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontSize: Dimension.text_size_small,
            //               ),
            //             ),
            //           ),
            //           SizedBox(
            //             width: 8,
            //           ),
            //           Text(
            //             "*File Size\n5 Mb max",
            //             style:
            //                 TextStyle(fontSize: 8, color: Colors.red),
            //           )
            //         ],
            //       ),
            //     ),
            //     Container(
            //       height: 80,
            //       width: Get.width / 1,
            //       child: ListView.builder(
            //         shrinkWrap: false,
            //         itemCount: selectedFileList.length,
            //         itemBuilder: (context, index) {
            //           return Stack(
            //             children: [
            //               Padding(
            //                 padding: const EdgeInsets.only(
            //                     top: 16, bottom: 0, right: 16),
            //                 child: Container(
            //                   child: Row(
            //                     mainAxisAlignment:
            //                         MainAxisAlignment.center,
            //                     children: [
            //                       Icon(Icons.file_upload),
            //                       Center(
            //                         child: Container(
            //                           width: MediaQuery.of(context)
            //                                   .size
            //                                   .width *
            //                               0.8,
            //                           child: Text(
            //                             selectedFileList[index]
            //                                 .path
            //                                 .split("/")
            //                                 .last,
            //                             style:
            //                                 TextStyle(fontSize: 10),
            //                             //overflow: TextOverflow.ellipsis,
            //                           ),
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //               Positioned(
            //                 top: 4,
            //                 right: 10,
            //                 child: InkWell(
            //                   onTap: () {
            //                     setState(() {
            //                       selectedFileList.remove(
            //                           selectedFileList[index]);
            //                       // filepick.remove(index);
            //                       // fileShow.remove(index);
            //                     });
            //                   },
            //                   child: CircleAvatar(
            //                     radius: 12,
            //                     backgroundColor: Colors.red,
            //                     child: Icon(
            //                       Icons.delete,
            //                       color: Colors.black,
            //                       size: 16,
            //                     ),
            //                   ),
            //                 ),
            //               )
            //             ],
            //           );
            //         },
            //       ),
            //     ),
          ],
        ),
      ),
    );
  }

  void openBottomSheet(String title, BuildContext context, int position) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        )),
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: Colors.pink,
            height: Get.height / 1.5,
            width: Get.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title),
                Divider(),
                position == 0
                    ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: postALeadController.postALeadList.value
                            .results!.priceType!.values!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: Get.width,
                            child: Center(
                              child: Text(postALeadController
                                  .postALeadList.value.results!.priceType!.values
                                  .toString()),
                            ),
                          );
                        },
                      )

                    // Text(postALeadController
                    //         .postALeadList.value.results.priceType.values.length
                    //         .toString())
                    : SizedBox()
              ],
            ),
          );
        });
  }
}
