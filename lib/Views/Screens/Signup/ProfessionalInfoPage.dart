import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:new_fixera/Controller/SignUpController.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

class ProfessionalInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfessionalInfoPageState();
  }
}

class ProfessionalInfoPageState extends State<ProfessionalInfoPage> {
  final SignUpController signUpController = Get.find();
  static final formKey = GlobalKey<FormState>();
  static SignatureController userSignatureController = SignatureController();

  static TextEditingController controllerVendor = new TextEditingController();
  static TextEditingController controllerPassword = new TextEditingController();

  //static TextEditingController initialSignature = new TextEditingController();

  static TextEditingController controllerConfirmPassword =
      new TextEditingController();
  static int? grpVal;
  static String errorLocation = " ";
  static String errorGroupValue = " ";
  static String? selectedCategories;
  static var selectedLocation;
  static String? mySelectionEmployee;
  static String? mySelectionDepartment;

  grpValFunc(value) {
    setState(() {
      grpVal = value;
      print(grpVal);
    });
  }

  bool agreeCheckBox = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              alignment: Alignment.center,
              // color: AppColors.backgroundColor,
              child: Image.asset(
                'images/fixera_logo.png',
                height: 40,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              alignment: Alignment.center,
              // color: AppColors.backgroundColor,
              child: Text(
                "Professional Info",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Dimension.text_size_medium,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 35.0,
        ),
        Form(
          key: formKey,
          // ignore: deprecated_member_use
          //autovalidate: true,
          child: Column(
            children: <Widget>[
              Obx(() {
                if (signUpController.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else
                  return Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: DropdownButton(
                      isExpanded: true,
                      hint: Text("Select Locations"),
                      items: signUpController
                          .signUpList.value.results!.locations!.keys
                          .map((values) {
                        return DropdownMenuItem(
                          value: values,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Text(
                              signUpController
                                  .signUpList.value.results!.locations![values],
                              style: TextStyle(),
                            ),
                          ),
                        );
                      }).toList(),
                      value: selectedLocation,
                      onChanged: (valueSelectedByUser) {
                        setState(() {
                          selectedLocation = valueSelectedByUser;
                          print(selectedLocation);
                        });
                      },
                    ),
                  );
              }),
              Text(errorLocation,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  )),
              SizedBox(height: 20),
              // TextFormField(
              //   maxLines: 1,
              //   decoration: InputDecoration(
              //     hintText: 'Initial Signature',
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.all(Radius.circular(10.0)),
              //     ),
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return "Initial Signature is Required";
              //     } else {
              //       return null;
              //     }
              //   },
              //   controller: initialSignature,
              // ),
              SizedBox(height: 20.0),
              TextFormField(
                // minLines: 1,

                maxLines: 1,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is Required";
                  } else if (value.length < 6) {
                    return "password must be at least 6 characters";
                  }
                },
                controller: controllerPassword,
              ),
              SizedBox(height: 20),
              TextFormField(
                maxLines: 1,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Confirm Password is required";
                  } else if (value != controllerPassword.text) {
                    return "Password is not Matched";
                  }
                  // else if (!value.contains(controllerPassword.text)) {
                  //   return "Password is not Matched";
                  // }
                },
                controller: controllerConfirmPassword,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 35.0,
        ),
        Container(
          width: Get.width,
          child: Text(
            "Start As",
            style: TextStyle(
              fontSize: Dimension.text_size_medium,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(errorGroupValue,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                )),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black54,
                ),
                // color: AppColors.textColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  Radio(
                    value: 0,
                    groupValue: grpVal,
                    onChanged: grpValFunc,
                  ),
                  Text(
                    "Lead MarketPlaces",
                    style: TextStyle(
                      fontSize: Dimension.text_size_semi_medium,
                    ),
                  ),
                ],
              ),
            ),
            grpVal == 0
                ? Column(
                    children: [
                      ExpansionTile(
                        title: Text("No. Of Employees You Have"),
                        children: [
                          Obx(() {
                            if (signUpController.isLoading.value) {
                              return Center(child: CircularProgressIndicator());
                            } else
                              return Container(
                                height: 130,
                                child: ListView.builder(
                                    itemCount: signUpController.signUpList.value
                                        .results!.employeeCount!.length,
                                    itemBuilder: (contex, index) {
                                      return Container(
                                          height: 40,
                                          child: RadioListTile(
                                            title: Text(signUpController
                                                .signUpList
                                                .value!
                                                .results!
                                                .employeeCount!["${index + 1}"]!
                                                .title!),
                                            value: signUpController
                                                .signUpList
                                                .value
                                                .results!
                                                .employeeCount!["${index + 1}"]!
                                                .value!
                                                .toString(),
                                            groupValue: mySelectionEmployee,
                                            onChanged: (val) {
                                              setState(() {
                                                mySelectionEmployee = val;
                                                print(mySelectionEmployee);
                                              });
                                            },
                                          ));
                                    }),
                              );
                          }),
                        ],
                      ),
                      // ExpansionTile(
                      //   title: Text("Your Department?"),
                      //   children: [
                      //     Obx(() {
                      //       if (signUpController.isLoading.value) {
                      //         return Center(child: CircularProgressIndicator());
                      //       } else
                      //         return Container(
                      //           height: 130,
                      //           child: ListView.builder(
                      //               itemCount: signUpController.signUpList.value
                      //                   .results.departments.length,
                      //               itemBuilder: (contex, index) {
                      //                 return Container(
                      //                     height: 50,
                      //                     child: RadioListTile(
                      //                       title: Text(signUpController
                      //                           .signUpList
                      //                           .value
                      //                           .results
                      //                           .departments[index]
                      //                           .title),
                      //                       value: signUpController
                      //                           .signUpList
                      //                           .value
                      //                           .results
                      //                           .departments[index]
                      //                           .id
                      //                           .toString(),
                      //                       groupValue: mySelectionDepartment,
                      //                       onChanged: (val) {
                      //                         setState(() {
                      //                           mySelectionDepartment = val;
                      //                           print(mySelectionDepartment);
                      //                         });
                      //                       },
                      //                     ));
                      //               }),
                      //         );
                      //     }),
                      //   ],
                      // ),
                    ],
                  )
                : Container(),
            SizedBox(
              height: 16.0,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black54,
                ),
                // color: AppColors.textColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: grpVal,
                    onChanged: grpValFunc,
                  ),
                  Text(
                    "Contractor",
                    style: TextStyle(
                      fontSize: Dimension.text_size_semi_medium,
                    ),
                  ),
                ],
              ),
            ),
            grpVal == 1
                ? Column(
                    children: [
                      Obx(() {
                        if (signUpController.isLoading.value) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else
                          return Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Text("Select Categories"),
                              items: signUpController
                                  .signUpList.value.results!.categories!.keys!
                                  .map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Text(
                                      signUpController!.signUpList.value.results!
                                          .categories![value]!,
                                      style: TextStyle(),
                                    ),
                                  ),
                                );
                              }).toList(),
                              value: selectedCategories,
                              onChanged: (value) {
                                setState(() {
                                  selectedCategories = value;
                                  print(selectedCategories);
                                });
                              },
                            ),
                          );
                      })
                    ],
                  )
                : Container(),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 200,
          width: Get.width,
          child: Signature(
            controller: userSignatureController,
            height: 200,
            width: Get.width - 48,
          ),
        ),
        SizedBox(height: 16),
        InkWell(
          onTap: () {
            userSignatureController.clear();
          },
          child: Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              height: 50,
              width: 160,
              child: Center(
                  child: Text(
                "Clear signature",
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
        ),
        // ElevatedButton(
        //   onPressed: () async {
        //     // var dir = await getTemporaryDirectory();
        //     // File userSugnatureFile = File(dir.path + '/userSign.png');
        //     // await userSugnatureFile
        //     //     .writeAsBytes(await userSignatureController.toPngBytes());
        //     // final bytes = File(userSugnatureFile.path).readAsBytesSync();
        //     // String base64Image = "data:image/png;base64," + base64Encode(bytes);
        //     //
        //     // log("img_pan : $base64Image");
        //   },
        //   child: Text("SIGN"),
        // ),
        SizedBox(
          height: 25,
        ),
      ],
    ));
  }
}
