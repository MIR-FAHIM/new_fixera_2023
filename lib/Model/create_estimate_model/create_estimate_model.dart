import 'dart:convert';
import 'dart:io';

import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CreateEstimate {
  String? receivable_email;
  String? project_title;
  String? company_name;
  String? company_address;
  String? company_phone;
  String? company_representive_name;
  String? company_representive_email;
  String? company_representive_phone;
  String? estimation_description;
  String? estimation_product_title;
  String? estimation_card_title;
  String? estimation_product_decs;
  String? estimation_product_qty;
  double? estimation_product_price;
  double? estimation_product_total;
  double? estimation_final_amount;
  String? estimation_policy;
  File? comapny_signature;
  File? customer_signature;
  String? company_authorized_signature_date;
  String? customer_signature_date;

  CreateEstimate({
    this.receivable_email,
    this.project_title,
    this.company_name,
    this.company_address,
    this.company_phone,
    this.company_representive_name,
    this.company_representive_email,
    this.company_representive_phone,
    this.estimation_description,
    this.estimation_final_amount,
    this.estimation_policy,
    this.comapny_signature,
    this.customer_signature,
    this.company_authorized_signature_date,
    this.customer_signature_date,
  });

  Map<String, dynamic> toMap() {
    return {
      'receiver_email': receivable_email,
      'project_title': project_title,
      'company_name': company_name,
      'company_address': company_address,
      'company_phone': company_phone,
      'company_representive_name': company_representive_name,
      'company_representive_email': company_representive_email,
      'company_representive_phone': company_representive_phone,
      'estimation_description': estimation_description,
      'estimation_final_amount': estimation_final_amount,
      'estimation_policy': estimation_policy,
      'company_authorized_signature_date': company_authorized_signature_date,
      'customer_signature_date': customer_signature_date,
    };
  }

  CreateEstimate copyWith({
    String? receivable_email,
    String? project_title,
    String? company_name,
    String? company_address,
    String? company_phone,
    String? company_representive_name,
    String? company_representive_email,
    String? company_representive_phone,
    String? estimation_description,
    String? estimation_product_title,
    String? estimation_card_title,
    String? estimation_product_decs,
    String? estimation_product_qty,
    double? estimation_product_price,
    double? estimation_product_total,
    double? estimation_final_amount,
    String? estimation_policy,
    File? comapny_signature,
    File? customer_signature,
    String? company_authorized_signature_date,
    String? customer_signature_date,
  }) {
    return CreateEstimate(
      receivable_email: receivable_email ?? this.receivable_email,
      project_title: project_title ?? this.project_title,
      company_name: company_name ?? this.company_name,
      company_address: company_address ?? this.company_address,
      company_phone: company_phone ?? this.company_phone,
      company_representive_name:
          company_representive_name ?? this.company_representive_name,
      company_representive_email:
          company_representive_email ?? this.company_representive_email,
      company_representive_phone:
          company_representive_phone ?? this.company_representive_phone,
      estimation_description:
          estimation_description ?? this.estimation_description,
      estimation_final_amount:
          estimation_final_amount ?? this.estimation_final_amount,
      estimation_policy: estimation_policy ?? this.estimation_policy,
      comapny_signature: comapny_signature ?? this.comapny_signature,
      customer_signature: customer_signature ?? this.customer_signature,
      company_authorized_signature_date: company_authorized_signature_date ??
          this.company_authorized_signature_date,
      customer_signature_date:
          customer_signature_date ?? this.customer_signature_date,
    );
  }

  @override
  String toString() {
    return 'CreateEstimate(receivable_email: $receivable_email, project_title: $project_title, company_name: $company_name, company_address: $company_address, company_phone: $company_phone, company_representive_name: $company_representive_name, company_representive_email: $company_representive_email, company_representive_phone: $company_representive_phone, estimation_description: $estimation_description, estimation_product_title: $estimation_product_title, estimation_card_title: $estimation_card_title, estimation_product_decs: $estimation_product_decs, estimation_product_qty: $estimation_product_qty, estimation_product_price: $estimation_product_price, estimation_product_total: $estimation_product_total, estimation_final_amount: $estimation_final_amount, estimation_policy: $estimation_policy, comapny_signature: $comapny_signature, customer_signature: $customer_signature, company_authorized_signature_date: $company_authorized_signature_date, customer_signature_date: $customer_signature_date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreateEstimate &&
        other.receivable_email == receivable_email &&
        other.project_title == project_title &&
        other.company_name == company_name &&
        other.company_address == company_address &&
        other.company_phone == company_phone &&
        other.company_representive_name == company_representive_name &&
        other.company_representive_email == company_representive_email &&
        other.company_representive_phone == company_representive_phone &&
        other.estimation_description == estimation_description &&
        other.estimation_product_title == estimation_product_title &&
        other.estimation_card_title == estimation_card_title &&
        other.estimation_product_decs == estimation_product_decs &&
        other.estimation_product_qty == estimation_product_qty &&
        other.estimation_product_price == estimation_product_price &&
        other.estimation_product_total == estimation_product_total &&
        other.estimation_final_amount == estimation_final_amount &&
        other.estimation_policy == estimation_policy &&
        other.comapny_signature == comapny_signature &&
        other.customer_signature == customer_signature &&
        other.company_authorized_signature_date ==
            company_authorized_signature_date &&
        other.customer_signature_date == customer_signature_date;
  }

  @override
  int get hashCode {
    return receivable_email.hashCode ^
        project_title.hashCode ^
        company_name.hashCode ^
        company_address.hashCode ^
        company_phone.hashCode ^
        company_representive_name.hashCode ^
        company_representive_email.hashCode ^
        company_representive_phone.hashCode ^
        estimation_description.hashCode ^
        estimation_product_title.hashCode ^
        estimation_card_title.hashCode ^
        estimation_product_decs.hashCode ^
        estimation_product_qty.hashCode ^
        estimation_product_price.hashCode ^
        estimation_product_total.hashCode ^
        estimation_final_amount.hashCode ^
        estimation_policy.hashCode ^
        comapny_signature.hashCode ^
        customer_signature.hashCode ^
        company_authorized_signature_date.hashCode ^
        customer_signature_date.hashCode;
  }

  save(List<EstimateAddModelForUI> products) async {
    Dio dio = Dio(
      BaseOptions(
        contentType: Headers.formUrlEncodedContentType,
        responseType: ResponseType.json,
        receiveDataWhenStatusError: true,
        validateStatus: (status) {
          return status < 600;
        },
      ),
    );
    var data = toMap();
    data['comapny_signature'] = "data:image/png;base64," +
        Base64Encoder().convert(await comapny_signature!.readAsBytes());
    // data['customer_signature'] = "data:image/png;base64," +
    //     Base64Encoder().convert(await customer_signature.readAsBytes());
    for (int i = 0; i < products.length; i++) {
      data.addAll(products[i].toMap(i));
    }
    await Future.delayed(Duration(seconds: 1));
    print(data['customer_signature']);
    try {
      Response response = await dio.post(
        AppUrl.estimationStore,
        data: data,
        options: Options(
          headers: MyApiClient.header2(),
        ),
      );
      print("THE RESPONSE IS::: ${response.data}");
      return response;
      // if (response.statusCode == 200) {
      //   return true;
      // } else {
      //   return false;
      // }
    } catch (e) {
      print(e);
      return false;
    }
  }
}

class EstimateAddModelForUI {
  TextEditingController titleOfProductController = TextEditingController();
  TextEditingController SelectMeasurmentController = TextEditingController();
  TextEditingController DiscriptionController = TextEditingController();
  TextEditingController QuantityController = TextEditingController();
  TextEditingController PerUnitChargeController = TextEditingController();
  TextEditingController PriceController = TextEditingController();
  String? selectedMeasurement;

  var TotalPriceController = TextEditingController();

  Map<String, String> toMap(int index) {
    return {
      "estimation_product_title[$index]": titleOfProductController.text,
      "estimation_product_qty[$index]": QuantityController.text,
      "estimation_product_price[$index]": PerUnitChargeController.text,
      "estimation_product_total[$index]": TotalPriceController.text,
      "estimation_product_desc[$index]": DiscriptionController.text,
      "estimation_card_title[$index]": selectedMeasurement!,
    };
  }
}
