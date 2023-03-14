import 'dart:convert';

import 'package:new_fixera/Controller/ContractorController.dart';
import 'package:new_fixera/Model/create_estimate_model/create_estimate_model.dart';
import 'package:new_fixera/Views/Screens/BottomNavigationScreen/BottomNavigationPage.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:new_fixera/Widgets/text_field_title.dart';
import 'package:new_fixera/Widgets/text_field_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import "package:get/get.dart" hide MultipartFile, Response, FormData;
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

class CreateEstimationForm extends StatefulWidget {
  CreateEstimationForm({Key? key}) : super(key: key);

  @override
  _PostAJobAndLeadState createState() => _PostAJobAndLeadState();
}

class _PostAJobAndLeadState extends State<CreateEstimationForm> {
  List imageFiles = [];
  List<String> measurement = [
    "DA",
    "BF",
    "BG",
    "Bundle",
    "BX",
    "CF",
    "CR",
    "CY",
    "EA",
    "FT",
    "HR",
    "LB",
    "LF",
    "LY",
    "MB",
    "ML",
    "MN",
    "MO",
    "PL",
    "PT",
    "QT",
    "RL",
    "RM",
    "SF",
    "SQ",
    "SY",
    "TB",
    "TN",
    "UN",
    "WK",
    "MTH",
    "YR"
  ];

  bool loaderStatus= false;

  List<EstimateAddModelForUI> EstimateAddList = [
    EstimateAddModelForUI(),
  ];

  DateTime? _selectedDate;

  Future<String> selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate! : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        builder: (BuildContext? context, Widget? child) {
          return Theme(
            data: ThemeData.light(),
            child: child!,
          );
        });
    if (newSelectedDate != null) {
      //2022-12-26
      return "${newSelectedDate.year}-${newSelectedDate.month}-${newSelectedDate.day}";
    }
    return '';
  }

  TextEditingController ReceiverEmailController = TextEditingController();
  TextEditingController ProjectTitleController = TextEditingController();
  TextEditingController CompanyNameController = TextEditingController();
  TextEditingController CompanyAddressController = TextEditingController();
  TextEditingController CompanyPhoneNumberController = TextEditingController();
  TextEditingController CompanyRepresentativeNameController =
      TextEditingController();
  TextEditingController CompanyRepresentativeEmailController =
      TextEditingController();
  TextEditingController CompanyRepresentativephoneController =
      TextEditingController();
  TextEditingController EstimationDescriptionController =
      TextEditingController();
  TextEditingController TypeOfProjectController = TextEditingController();
  TextEditingController MeasurementController = TextEditingController();
  TextEditingController DescriptionController = TextEditingController();
  TextEditingController QuantityController = TextEditingController();
  TextEditingController PerUnitChargeController = TextEditingController();
  TextEditingController PriceController = TextEditingController();
  TextEditingController TotalPriceController = TextEditingController();
  TextEditingController CompanySignatureController = TextEditingController();
  TextEditingController EstimationTermsAndConditionsController =
      TextEditingController();
  TextEditingController CompanySignatureDateController =
      TextEditingController();
  TextEditingController SignatureDateController = TextEditingController();
  TextEditingController CustomerSignatureController = TextEditingController();
  TextEditingController CustomerSignatureDateController =
      TextEditingController();
  SignatureController customerSignature = SignatureController();
  SignatureController companySignature = SignatureController();
  String? companySignatureDate;
  String? customerSignatureDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text("Create Estimation"),
        leading: GestureDetector(
          onTap: () {
            Get.back();
            // Route route =
            //     MaterialPageRoute(builder: (c) => BottomNavigationPage());
            // Navigator.pushReplacement(context, route);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //*****

                    //*****
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
                            "Create Estimation",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: Dimension.text_size_medium),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFieldWidget(
                      title: "Receiver Email Address",
                      controller: ReceiverEmailController,
                    ),

                    SizedBox(height: 16),
                    TextFieldWidget(
                        title: "Project Title",
                        controller: ProjectTitleController),

                    SizedBox(height: 16),
                    TextFieldWidget(
                        title: "Company Name",
                        controller: CompanyNameController),

                    SizedBox(height: 16),
                    TextFieldWidget(
                        title: "Company Address",
                        controller: CompanyAddressController),

                    SizedBox(height: 16),
                    TextFieldWidget(
                        title: "Company Phone Number",
                        controller: CompanyPhoneNumberController),

                    SizedBox(height: 16),
                    TextFieldWidget(
                        title: "Company Representative Name",
                        controller: CompanyRepresentativeNameController),

                    SizedBox(height: 16),
                    TextFieldWidget(
                        title: "Company Representative Email",
                        controller: CompanyRepresentativeEmailController),

                    SizedBox(height: 16),
                    TextFieldWidget(
                        title: "Company Representative Phone Number",
                        controller: CompanyRepresentativephoneController),

                    SizedBox(height: 16),
                    TextFieldWidget(
                        title: "Estimation Description",
                        controller: EstimationDescriptionController),
                    SizedBox(height: 16),
                    TextFieldWidget(
                        title: "Estimation Terms and conditions",
                        controller: EstimationTermsAndConditionsController),
                    SizedBox(height: 16),
                    TextFieldTitle("Project Line Item"),
                    ...EstimateAddList.map((e) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          Text("Product: ${EstimateAddList.indexOf(e) + 1}"),
                          SizedBox(height: 16),
                          TextFieldWidget(
                              title: "Product Title",
                              controller: e.titleOfProductController),
                          SizedBox(height: 16),
                          // Selectable dropdown from measurement
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xffA0C828), width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButton<String>(
                                    value: e.selectedMeasurement,
                                    isExpanded: true,
                                    underline: Container(),
                                    hint: Text("Select Measurement"),
                                    elevation: 16,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        e.selectedMeasurement = newValue;
                                      });
                                    },
                                    items: measurement
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 16),
                          TextFieldWidget(
                              title: "Description",
                              controller: e.DiscriptionController),
                          SizedBox(height: 16),
                          TextFieldWidget(
                            title: "Quantity",
                            controller: e.QuantityController,
                            keyboardType: TextInputType.number,
                            onChanged: (v) {
                              Future.delayed(Duration.zero, () {
                                setState(() {
                                  e.TotalPriceController.text = (int.parse(
                                              e.QuantityController.text) *
                                          int.parse(
                                              e.PerUnitChargeController.text))
                                      .toString();
                                });
                              });
                            },
                            onSubmitted: (s) {
                              // Future.delayed(Duration.zero, () {
                              //   setState(() {
                              //     e.TotalPriceController.text = (int.parse(
                              //                 e.QuantityController.text) *
                              //             int.parse(
                              //                 e.PerUnitChargeController.text))
                              //         .toString();
                              //   });
                              // });
                            },
                          ),
                          SizedBox(height: 16),
                          TextFieldWidget(
                            title: "Per Unit Charge",
                            controller: e.PerUnitChargeController,
                            keyboardType: TextInputType.number,
                            onChanged: (v) {
                              // setState((){});
                              Future.delayed(Duration.zero, () {
                                setState(() {
                                  e.TotalPriceController.text = (int.parse(
                                              e.QuantityController.text) *
                                          int.parse(
                                              e.PerUnitChargeController.text))
                                      .toString();
                                });
                              });
                            },
                            onSubmitted: (s) {
                              // Future.delayed(Duration.zero, () {
                              //   setState(() {
                              //     e.TotalPriceController.text = (int.parse(
                              //                 e.QuantityController.text) *
                              //             int.parse(
                              //                 e.PerUnitChargeController.text))
                              //         .toString();
                              //   });
                              // });
                              setState(() {});
                            },
                          ),
                          SizedBox(height: 16),
                          TextFieldWidget(
                              title: "Total Price: ",
                              enabled: false,
                              controller: e.TotalPriceController),
                        ],
                      );
                    }).toList(),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              EstimateAddList.add(EstimateAddModelForUI());
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 24),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffA0C828),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                height: 40,
                                width: 50,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (EstimateAddList.length > 1) {
                                EstimateAddList.removeLast();
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 24),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffA0C828),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                height: 40,
                                width: 50,
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    SizedBox(height: 16),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text("Total amount:"),
                      ),
                    ),
                    SizedBox(height: 16),
                    Builder(builder: (context) {
                      var totalPrice = 0.0;
                      for (var i = 0; i < EstimateAddList.length; i++) {
                        totalPrice += double.tryParse(
                                EstimateAddList[i].TotalPriceController.text) ??
                            0.0;
                      }
                      TotalPriceController =
                          TextEditingController(text: totalPrice.toString());

                      return TextFieldWidget(
                        title: "Total Price: $totalPrice",
                        controller: TextEditingController(),
                        enabled: false,
                      );
                    }),
                    SizedBox(height: 16),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text("Company Authorized Signature"),
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 200,
                        width: Get.width,
                        child: Signature(
                          controller: companySignature,
                          height: 200,
                          width: Get.width - 48,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    InkWell(
                      onTap: () {
                        companySignature.clear();
                      },
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
                    SizedBox(height: 16),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text("Company Authorized Signature Date"),
                      ),
                    ),
                    SizedBox(height: 16),
                    InkWell(
                      onTap: () async {
                        companySignatureDate = await selectDate(context);
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Container(
                            height: 65,
                            width: Get.width,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Text(companySignatureDate ?? '')),
                      ),
                    ),
                    // SizedBox(height: 16),
                    /////
                    // Align(
                    //   alignment: Alignment.topLeft,
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(horizontal: 24),
                    //     child: Text("Customer Signature"),
                    //   ),
                    // ),
                    // SizedBox(height: 16),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 24),
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       color: Colors.grey,
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     height: 200,
                    //     width: Get.width,
                    //     child: Signature(
                    //       controller: customerSignature,
                    //       height: 200,
                    //       width: Get.width - 48,
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 16),
                    // InkWell(
                    //   onTap: () {
                    //     customerSignature.clear();
                    //   },
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       color: Colors.red,
                    //       borderRadius: BorderRadius.circular(20),
                    //     ),
                    //     height: 50,
                    //     width: 160,
                    //     child: Center(
                    //         child: Text(
                    //       "Clear signature",
                    //       style: TextStyle(color: Colors.white),
                    //     )),
                    //   ),
                    // ),
                    // SizedBox(height: 16),
                    // Align(
                    //   alignment: Alignment.topLeft,
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(horizontal: 24),
                    //     child: Text("Customer Signature Date"),
                    //   ),
                    // ),
                    // SizedBox(height: 16),
                    // InkWell(
                    //   onTap: () async {
                    //     customerSignatureDate = await selectDate(context);
                    //     setState(() {});
                    //   },
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(horizontal: 24),
                    //     child: Container(
                    //       height: 65,
                    //       width: Get.width,
                    //       decoration: BoxDecoration(
                    //         border: Border.all(color: Colors.grey),
                    //         borderRadius: BorderRadius.circular(5),
                    //       ),
                    //       alignment: Alignment.centerLeft,
                    //       padding: EdgeInsets.symmetric(horizontal: 24),
                    //       child: Text(customerSignatureDate ?? ''),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 16),
                    loaderStatus == false
                        ? InkWell(
                            onTap: () async {
                              setState(() {
                                loaderStatus = true;
                              });
                              try {
                                var dir = await getTemporaryDirectory();
                                File companySignatureFile =
                                    File(dir.path + '/company.png');
                                // File customerSignatureFile =
                                //     File(dir.path + '/customer.png');
                                await companySignatureFile.writeAsBytes(
                                    await companySignature.toPngBytes());
                                // await customerSignatureFile.writeAsBytes(
                                //     await customerSignature.toPngBytes());
                                var result = await CreateEstimate(
                                  receivable_email:
                                      ReceiverEmailController.text,
                                  project_title: ProjectTitleController.text,
                                  company_name: CompanyNameController.text,
                                  company_address:
                                      CompanyAddressController.text,
                                  company_phone:
                                      CompanyPhoneNumberController.text,
                                  company_representive_email:
                                      CompanyRepresentativeEmailController.text,
                                  company_representive_name:
                                      CompanyRepresentativeNameController.text,
                                  company_representive_phone:
                                      CompanyRepresentativephoneController.text,
                                  comapny_signature: companySignatureFile,
                                  //customer_signature: customerSignatureFile,
                                  // customer_signature_date: customerSignatureDate,
                                  company_authorized_signature_date:
                                      companySignatureDate,
                                  estimation_description:
                                      EstimationDescriptionController.text,
                                  estimation_final_amount:
                                      double.parse(TotalPriceController.text),
                                  estimation_policy:
                                      EstimationTermsAndConditionsController
                                          .text,
                                ).save(EstimateAddList);
                                setState(() {
                                  loaderStatus = false;
                                });
                                print(
                                    "THE RESP IS: ${jsonDecode(result.toString())['error']}");
                                if (jsonDecode(result.toString())['error'] ==
                                    true) {
                                  Get.snackbar('Error',
                                      '${jsonDecode(result.toString())['message']}',
                                      snackPosition: SnackPosition.BOTTOM);
                                } else {
                                  Get.snackbar('Success',
                                      'Estimate created successfully',
                                      snackPosition: SnackPosition.BOTTOM);
                                }
                              } catch (e) {
                                setState(() {
                                  loaderStatus = false;
                                });
                                Get.snackbar('Error', 'Something went wrong',
                                    snackPosition: SnackPosition.BOTTOM);
                                throw e;
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xffA0C828),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 50,
                              width: 160,
                              child: Center(
                                  child: Text(
                                "Send",
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
