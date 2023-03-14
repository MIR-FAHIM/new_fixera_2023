import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/Views/Utilities/AppUrl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class create_work_order_model {
  String? receivable_email;
  String? comapny_name;
  String? comapny_address;
  String? job_name;
  String? work_order_crew;
  String? work_order_start;
  String? work_order_end;
  String? customer_name;
  String? customer_address;
  String? com_rep_name;
  String? com_rep_email;
  String? com_rep_phone;
  String? work_order_total_amount;
  String? work_order_decs;
  String? work_order_disclaimer;
  String? work_order_material_qty;
  String? work_order_material_unit;
  String? work_order_material_decs;

  create_work_order_model({
    @required this.receivable_email,
    @required this.comapny_name,
    @required this.comapny_address,
    @required this.job_name,
    @required this.work_order_crew,
    @required this.work_order_start,
    @required this.work_order_end,
    @required this.customer_name,
    @required this.customer_address,
    @required this.com_rep_name,
    @required this.com_rep_email,
    @required this.com_rep_phone,
    @required this.work_order_total_amount,
    @required this.work_order_decs,
    @required this.work_order_disclaimer,
  });

  Map<String, dynamic> toMap() {
    return {
      'receivable_email': this.receivable_email,
      'company_name': this.comapny_name,
      'company_address': this.comapny_address,
      'job_name': this.job_name,
      'work_order_crew': this.work_order_crew,
      'work_order_crew_start': this.work_order_start,
      'work_order_crew_end': this.work_order_end,
      'customer_name': this.customer_name,
      'customer_address': this.customer_address,
      'com_rep_name': this.com_rep_name,
      'com_rep_email': this.com_rep_email,
      'com_rep_phone': this.com_rep_phone,
      'work_order_total_amount': this.work_order_total_amount,
      'work_order_desc': this.work_order_decs,
      'work_order_disclaimer': this.work_order_disclaimer,
    };
  }

  factory create_work_order_model.fromMap(Map<String, dynamic> map) {
    return create_work_order_model(
      receivable_email: map['receiver_email'] as String,
      comapny_name: map['comapny_name'] as String,
      comapny_address: map['comapny_address'] as String,
      job_name: map['job_name'] as String,
      work_order_crew: map['work_order_crew'] as String,
      work_order_start: map['work_order_start'] as String,
      work_order_end: map['work_order_end'] as String,
      customer_name: map['customer_name'] as String,
      customer_address: map['customer_address'] as String,
      com_rep_name: map['com_rep_name'] as String,
      com_rep_email: map['com_rep_email'] as String,
      com_rep_phone: map['com_rep_phone'] as String,
      work_order_total_amount: map['work_order_total_amount'] as String,
      work_order_decs: map['work_order_decs'] as String,
      work_order_disclaimer: map['work_order_disclaimer'] as String,
    );
  }

  Future<bool> save(List<WorkOrderAddModelUI> orders) async {
    Dio dio = Dio(
      BaseOptions(
        contentType: Headers.formUrlEncodedContentType,
        responseType: ResponseType.json,
        receiveDataWhenStatusError: true,
        validateStatus: (status) {
          return status < 500;
        },
      ),
    );
    var formData = toMap();
    for (int i = 0; i < orders.length; i++) {
      formData.addAll(orders[i].toMap(i));
    }
    var response = await dio.post(AppUrl.workorderStore,
        queryParameters: formData,
        options: Options(headers: MyApiClient.header2()));
    print(response.data);
    print(response.request.uri.toString());
    print(response.request.queryParameters);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}

class WorkOrderAddModelUI {
  TextEditingController MaterialQtyController = TextEditingController();
  String MaterialUnitController = "DA";
  TextEditingController MaterialDescriptionController = TextEditingController();

  toMap(index) {
    return {
      'work_order_metarial_qty[$index]': MaterialQtyController.text,
      'work_order_metarial_unit[$index]': MaterialUnitController,
      'work_order_metarial_desc[$index]': MaterialDescriptionController.text,
    };
  }
}
