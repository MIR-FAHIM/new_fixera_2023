import 'dart:convert';

import 'package:new_fixera/Model/CreateInvoice/create_invoice_model.dart';
import 'package:new_fixera/Model/CreateInvoice/invoice_product_model.dart';
import 'package:new_fixera/Widgets/text_field_widget.dart';
import 'package:new_fixera/Views/Screens/BottomNavigationScreen/BottomNavigationPage.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import "package:get/get.dart" hide MultipartFile, Response, FormData;

class CreateInvoiceWebview extends StatefulWidget {
  CreateInvoiceWebview({Key? key}) : super(key: key);

  @override
  _CreateInvoiceWebviewState createState() => _CreateInvoiceWebviewState();
}

class _CreateInvoiceWebviewState extends State<CreateInvoiceWebview> {
  List<File> imageFiles = [];
  var loaderStatus = false;
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyAddressController = TextEditingController();
  TextEditingController companyEmailController = TextEditingController();
  TextEditingController companyMobileController = TextEditingController();
  TextEditingController vendorMobileController = TextEditingController();
  TextEditingController vendorNameController = TextEditingController();
  TextEditingController recievableEmailController = TextEditingController();
  TextEditingController vendorEmailController = TextEditingController();
  TextEditingController vendorAddressController = TextEditingController();
  String? paymentDate;

  // var totalAmount = 0.0;
  var formKey = GlobalKey<FormState>();
  List<InvoiceProductModelForUI> invoiceProductModelList = [
    InvoiceProductModelForUI()
  ];
  bool loader = false;

  var totalAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text("Create Invoice"),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                              "Create Invoice",
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
                        title: "Company Name",
                        controller: companyNameController,
                      ),
                      SizedBox(height: 16),
                      TextFieldWidget(
                          title: "Company Email",
                          controller: companyEmailController),
                      SizedBox(height: 16),
                      TextFieldWidget(
                          title: "Company Mobile",
                          controller: companyMobileController),
                      SizedBox(height: 16),
                      TextFieldWidget(
                          title: "Company Address",
                          controller: companyAddressController),
                      SizedBox(height: 16),
                      TextFieldWidget(
                          title: "Vendor Name",
                          controller: vendorNameController),
                      SizedBox(height: 16),
                      TextFieldWidget(
                          title: "Receivable Vendor Email",
                          controller: recievableEmailController),
                      SizedBox(height: 16),
                      TextFieldWidget(
                          title: "Vendor Mobile",
                          controller: vendorMobileController),
                      SizedBox(height: 16),
                      TextFieldWidget(
                          title: "Vendor Address",
                          controller: vendorAddressController),
                      SizedBox(height: 16),
                      TextFieldWidget(
                          title: "Vendor Email",
                          controller: vendorEmailController),
                      SizedBox(height: 16),
                      InkWell(
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2050))
                              .then((value) {
                            // "2022-04-02"
                            setState(() {
                              paymentDate =
                                  "${value!.year}-${value.month}-${value.day}";
                            });
                          });
                        },
                        child: TextFieldWidget(
                          title: "Payment Date",
                          enabled: false,
                          controller:
                              TextEditingController(text: paymentDate ?? ""),
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            Text("Product Description :"),
                            Icon(
                              Icons.star_rate_outlined,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                      ...invoiceProductModelList.map((e) {
                        return Column(
                          children: [
                            Text(
                                "Product: ${invoiceProductModelList.indexOf(e) + 1}"),
                            SizedBox(height: 16),
                            TextFieldWidget(
                                title: "Title",
                                controller: e.productTitleController),
                            SizedBox(height: 16),
                            TextFieldWidget(
                              title: "Rate",
                              controller: e.productRateController,
                              keyboardType: TextInputType.number,
                              onChanged: (c) {
                                e.productRate = double.tryParse(c) ?? 0.0;
                              },
                              onSubmitted: (s) {
                                setState(() {});
                              },
                            ),
                            SizedBox(height: 16),
                            TextFieldWidget(
                              title: "Quantity",
                              controller: e.productQuantityController,
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                e.productQuantity = int.tryParse(v) ?? 0;
                                setState(() {});
                              },
                              onSubmitted: (s) {
                                setState(() {});
                              },
                            ),
                            SizedBox(height: 16),
                            TextFieldWidget(
                              title: "Total",
                              enabled: false,
                              controller: TextEditingController(
                                  text: "${e.productRate * e.productQuantity}"),
                            ),
                            SizedBox(height: 16),
                          ],
                        );
                      }).toList(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                invoiceProductModelList
                                    .add(InvoiceProductModelForUI());
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
                                if (invoiceProductModelList.length > 1) {
                                  invoiceProductModelList.removeLast();
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
                      Divider(
                        color: Colors.black,
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text("Total amount :"),
                        ),
                      ),
                      SizedBox(height: 16),
                      Builder(builder: (context) {
                        // var total = 0.0;
                        var totalAmount = 0.0;
                        invoiceProductModelList.forEach((e) {
                          print("HERE IS E:: ${totalAmount}");
                          totalAmount += e.productRate * e.productQuantity;
                        });
                        return TextFieldWidget(
                          title: "Total: $totalAmount",
                          enabled: false,
                          controller: totalAmountController,
                        );
                      }),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Select File :",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        height: 150,
                        child: ListView.separated(
                          shrinkWrap: true,
                          primary: false,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  child: Image.file(
                                    imageFiles[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: -5,
                                  right: -5,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        imageFiles.removeAt(index);
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      height: 20,
                                      width: 20,
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          itemCount: imageFiles.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(width: 10);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: InkWell(
                          onTap: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();
                            if (result != null) {
                              imageFiles.add(File(result!.files!.first.path!));
                              setState(() {});
                            } else {}
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xffA0C828),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: 60,
                            width: Get.width,
                            child: Center(
                                child: Text(
                              "Select Files",
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      loader
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : InkWell(
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  try {
                                    var createInvoiceModel = CreateInvoiceModel(
                                        companyName: companyNameController.text,
                                        companyAddress:
                                            companyAddressController.text,
                                        companyEmail:
                                            companyEmailController.text,
                                        companyMobile:
                                            companyMobileController.text,
                                        vendorName: vendorNameController.text,
                                        vendorMobile:
                                            vendorMobileController.text,
                                        recievableVendorEmail:
                                            recievableEmailController.text,
                                        vendorAddress:
                                            vendorAddressController.text,
                                        paymentDate: paymentDate,
                                        invoiceProductList:
                                            invoiceProductModelList
                                                .map(
                                                  (e) => InvoiceProductModel(
                                                    productTitle: e
                                                        .productTitleController
                                                        .text,
                                                    productRate: double.parse(e
                                                        .productRateController
                                                        .text),
                                                    productQuantity: double.parse(e
                                                        .productQuantityController!
                                                        .text!),
                                                    productTotal: double.tryParse(e
                                                            .productTotalController
                                                            .text) ??
                                                        0.0,
                                                    productAmount: e
                                                        .productAmountController,
                                                  ),
                                                )
                                                .toList(),
                                        images: imageFiles,
                                        totalAmount: 0.0);
                                    setState(() {
                                      loader = true;
                                    });
                                    var result =
                                        await createInvoiceModel.save();
                                    setState(() {
                                      loader = false;
                                    });

                                    if (jsonDecode(
                                            result.toString())['error'] ==
                                        true) {
                                      Get.dialog(AlertDialog(
                                        content: Container(
                                          height: 100,
                                          child: Center(
                                            child: Text(
                                                "${jsonDecode(result.toString())['message']}"),
                                          ),
                                        ),
                                      ));

                                      // Get.back();
                                    } else {
                                      Get.dialog(AlertDialog(
                                        content: Container(
                                          height: 100,
                                          child: Center(
                                            child: Text(
                                                "${jsonDecode(result.toString())['results']['message']}"),
                                          ),
                                        ),
                                      ));
                                    }
                                  } catch (e) {
                                    setState(() {
                                      loader = false;
                                    });
                                    Get.dialog(AlertDialog(
                                      content: Container(
                                        height: 100,
                                        child: Center(
                                          child: Text("Something went wrong"),
                                        ),
                                      ),
                                    ));
                                  }
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
                            ),
                      SizedBox(height: 16),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
