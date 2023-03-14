import 'dart:convert';
import 'package:new_fixera/SharedPreferance/shared_preferance.dart';
import 'package:new_fixera/Views/Utilities/AppUrl.dart';
import 'package:new_fixera/Views/create_workorder/model/create_work_oder_new_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CreateWorkOrderController extends GetxController {
  var titleTextStyle = TextStyle(fontWeight: FontWeight.bold);
  RxInt apiPageNumber = 1.obs;
  RxInt apiLastPageNumber = 0.obs;
  Rx<CreateWorkOrderNewModel> workOrderData = CreateWorkOrderNewModel().obs;
  RxBool pageLoader = false.obs;
  List pageNumbers = [].obs;

  @override
  onInit() {
    super.onInit();
    pageLoader.value = true;
    getInvoiceList();
  }

  getInvoiceList() async {
    print("GET WORK ORDER");
    pageNumbers.clear();
    try {
      var tokenVal = SharedPref.to.prefss!.getString("token");

      var headers = {
        'Authorization': 'Bearer $tokenVal',
        "Accept": "application/json",
        "Content-Type": "application/json"
      };
      var response = await http.get(
          "${baseUrl}/create-work-orders/?page=${apiPageNumber.value}",
          headers: headers);

      print("RESPONSE IS: ${response.body}");
      workOrderData.value =
          CreateWorkOrderNewModel.fromJson(jsonDecode(response.body));
      if (workOrderData.value.error == false) {
        pageLoader.value = false;
        apiLastPageNumber.value =
            workOrderData!.value.results!.pagination!.lastPage!;
        print("LAST PAGE:: ${apiLastPageNumber.value}");
        for (int i = 0; i < apiLastPageNumber.value; i++) {
          print("HERE PRINT: $i");
          pageNumbers.add(i);
        }
      }
    } catch (e) {
      print("THIS IS CATCH");
      pageLoader.value = false;
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
