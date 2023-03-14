import 'dart:convert';

import 'package:new_fixera/SharedPreferance/shared_preferance.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:new_fixera/Views/create_invoice/model/create_invoice_new_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CreateInvoiceController extends GetxController {
  var titleTextStyle = TextStyle(fontWeight: FontWeight.bold);
  RxInt apiPageNumber = 1.obs;
  RxInt apiLastPageNumber = 0.obs;
  Rx<CreateInvoiceNewModel> invoiceData = CreateInvoiceNewModel().obs;
  RxBool pageLoader = false.obs;
  RxBool isFinish = false.obs;
  List pageNumbers = [].obs;

  @override
  onInit() {
    super.onInit();
    pageLoader.value = true;
    getInvoiceList();
  }

  getInvoiceList() async {
    print("GET INVOICE");
    pageNumbers.clear();
    try {
      var tokenVal = SharedPref.to.prefss!.getString("token");

      var headers = {
        'Authorization': 'Bearer $tokenVal',
        "Accept": "application/json",
        "Content-Type": "application/json"
      };
      var response = await http.get(
          "${baseUrl}/create-invoices/?page=${apiPageNumber.value}",
          headers: headers);

      print("RESPONSE IS: ${response.body}");
      invoiceData.value =
          CreateInvoiceNewModel.fromJson(jsonDecode(response.body));
      if (invoiceData.value.error == false) {
        pageLoader.value = false;
        apiLastPageNumber.value = invoiceData.value.results!.pagination!.lastPage!;
        for (int i = 0; i < apiLastPageNumber.value; i++) {
          pageNumbers.add(i);
        }
        if (invoiceData.value.results!.data!.isEmpty) {
          isFinish.value = true;
        }
      }
    } catch (e) {
      print("THIS IS CATCH");
      throw e;
    }
  }

  String parsedTime(String txt) {
    DateTime dateTime = DateTime.parse(txt);
    String formattedDate = DateFormat('yyyy-MM-dd, hh:mm a').format(dateTime);
    return formattedDate;
  }

  goBack() {
    if (apiPageNumber.value == 1) {
      Get.back();
    } else {
      apiPageNumber.value--;
      pageLoader.value = true;
      pageNumbers.clear();
      getInvoiceList();
    }
  }
}
