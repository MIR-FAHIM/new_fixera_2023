import 'dart:convert';
import 'dart:developer';

import 'package:new_fixera/SharedPreferance/shared_preferance.dart';
import 'package:new_fixera/Views/Utilities/AppColors.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class EstimationDetail extends StatefulWidget {
  String? url;

  EstimationDetail({this.url});

  @override
  State<EstimationDetail> createState() => _EstimationDetailState();
}

class _EstimationDetailState extends State<EstimationDetail> {
  String url = "";
  bool pageLoader = false;
  String receiver_email = "";
  String project_title = "";
  String company_name = "";
  String company_address = "";
  String company_phone = "";
  String company_representive_name = "";
  String company_representive_email = "";
  String company_representive_phone = "";
  String estimation_description = "";
  var estimation_products = [];
  int estimation_final_price = 0;
  String estimation_policy = "";
  String company_authorized_signature_date = "";
  String customer_signature_date = "";
  String company_signature = "";
  String customer_signature = "";
  String created_at = "";
  String updated_at = "";
  String companySignTitle = "Company Authorized Signature";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageLoader = true;
    url = widget.url!;
    print("HERE URL: ${url}");
    getEstimationDetail(url);
  }

  getEstimationDetail(String url) async {
    estimation_products.clear();
    try {
      var tokenVal = SharedPref.to.prefss!.getString("token");

      var headers = {
        'Authorization': 'Bearer $tokenVal',
        "Accept": "application/json",
        "Content-Type": "application/json"
      };
      var response = await http.get(url, headers: headers);

      var responseResult = jsonDecode(response.body)['results'];
      receiver_email = responseResult['receiver_email'];
      project_title = responseResult['project_title'];
      company_name = responseResult['company_name'];
      company_address = responseResult['company_address'];
      company_phone = responseResult['company_phone'];
      company_representive_name = responseResult['company_representive_name'];
      company_representive_email = responseResult['company_representive_email'];
      company_representive_phone = responseResult['company_representive_phone'];
      estimation_description = responseResult['estimation_description'];
      estimation_final_price = responseResult['estimation_final_price'];
      estimation_policy = responseResult['estimation_policy'];
      company_authorized_signature_date =
          responseResult['company_authorized_signature_date'];
      customer_signature_date = responseResult['customer_signature_date'];
      company_signature = responseResult['company_signature'];
      created_at = responseResult['created_at'];
      updated_at = responseResult['updated_at'];
      estimation_products = jsonDecode(responseResult['estimation_products']);
      pageLoader = false;
      setState(() {});
    } catch (e) {
      print("THIS IS CATCH");
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text("Estimation Detail"),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        color: Colors.white,
        child: pageLoader == true
            ? Center(child: CircularProgressIndicator())
            : Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widgetShow("Company Name: ", "${company_name}"),
                      widgetShow("Address: ", "${company_address}"),
                      widgetShow("Phone: ", "${company_phone}"),
                      widgetShow(
                          "Representative: ", "${company_representive_name}"),
                      widgetShow("Company Name: ", "${company_name}"),
                      widgetShow("Representative Email: ",
                          "${company_representive_email}"),
                      widgetShow("Representative Phone: ",
                          "${company_representive_phone}"),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(color: Colors.black)),
                        child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              color: Colors.black,
                            );
                          },
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: estimation_products.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 5, bottom: 5),
                              width: Get.width,
                              child: Column(
                                children: [
                                  Container(
                                    //width: Get.width,
                                    color: Colors.grey[300],
                                    child: Center(
                                      child: widgetShow("Project Title: ",
                                          "${estimation_products[index]['estimation_card_title']}"),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: Get.width / 2.4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            widgetShow("Product Title: ",
                                                "${estimation_products[index]['estimation_product_title']}"),
                                            widgetShow("Product Description: ",
                                                "${estimation_products[index]['estimation_product_desc']}"),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: Get.width / 2.4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            widgetShow("Quantity: ",
                                                "${estimation_products[index]['estimation_product_qty']}"),
                                            widgetShow("Per Unit Charge: ",
                                                "\$${estimation_products[index]['estimation_product_price']}"),
                                            widgetShow("Price: ",
                                                "\$${estimation_products[index]['estimation_product_total']}"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.only(right: 10, top: 5, bottom: 5),
                        width: Get.width,
                        color: Colors.grey[300],
                        child: Align(
                          alignment: Alignment.topRight,
                          child: widgetShow("Total Price: ",
                              "\$${estimation_final_price.toString().trim()}"),
                        ),
                      ),
                      widgetShow("Company Sinature Date: ",
                          formatedDate(company_authorized_signature_date)),
                      SizedBox(
                        height: 20,
                      ),
                      company_signature == null ||
                              company_signature.toString().trim() == ""
                          ? SizedBox()
                          : companySignature()
                    ],
                  ),
                ),
              ),
        //color: pageLoader == false ? Colors.green : Colors.red,
      ),
    );
  }

  Widget widgetShow(String title, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
                text: "$title",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            TextSpan(
              text: "$value",
              style: TextStyle(color: Colors.black, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }

  String formatedDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    return formattedDate;
  }

  Widget companySignature() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          "https://www.fix-era.com/" + "$company_signature",
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            return Text('Could not load signature');
          },
        ),
        Container(
          margin: EdgeInsets.only(bottom: 5),
          height: 3,
          width: Get.width,
          color: Colors.grey,
        ),
        Text(
          "$companySignTitle",
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
