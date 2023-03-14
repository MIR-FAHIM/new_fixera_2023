import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
// http://127.0.0.1:8000/api/v1/work-order/store?receivable_email=ctgsukkur112@gmail.com&company_name=Md Sukkur Ali&company_address=Mirpur Dohs&job_name=Test Job&work_order_crew=Test Crew&work_order_crew_start=2022-01-01&work_order_crew_end=2022-02-01&customer_name=Fix-era&customer_address=Usa&com_rep_name=mahbub&com_rep_email=mahbub@gmail.com&com_rep_phone=0199999999&work_order_total_amount=2000&work_order_desc=iu uiui ui ui uh uhh oih9 0h0h h09 h09h 09h0h &work_order_disclaimer=90909090 909 9 h 09 k hh 0hin n n noh oih &work_order_metarial_qty[]=200&work_order_metarial_unit[]=EA&work_order_metarial_desc[]=kjjnjjkn j jioio io ioio oiomkm

class InvoiceProductModel {
  String? productTitle;
  double? productRate;
  double? productQuantity;
  double? productTotal;
  String? productAmount;
  InvoiceProductModel({
    @required this.productTitle,
    @required this.productRate,
    @required this.productQuantity,
    @required this.productTotal,
    @required this.productAmount,
  });

  InvoiceProductModel copyWith({
    String? productTitle,
    double? productRate,
    double? productQuantity,
    double? productTotal,
    String? productAmount,
  }) {
    return InvoiceProductModel(
      productTitle: productTitle ?? this.productTitle,
      productRate: productRate ?? this.productRate,
      productQuantity: productQuantity ?? this.productQuantity,
      productTotal: productTotal ?? this.productTotal,
      productAmount: productAmount ?? this.productAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productTitle': productTitle,
      'productRate': productRate,
      'productQuantity': productQuantity,
      'productTotal': productTotal,
      'productAmount': productAmount,
    };
  }

  factory InvoiceProductModel.fromMap(Map<String, dynamic> map) {
    return InvoiceProductModel(
      productTitle: map['productTitle'] ?? '',
      productRate: map['productRate']?.toDouble() ?? 0.0,
      productQuantity: map['productQuantity']?.toDouble() ?? 0.0,
      productTotal: map['productTotal']?.toDouble() ?? 0.0,
      productAmount: map['productAmount'] ?? '',
    );
  }

  @override
  String toString() {
    return 'InvoiceProductModel(productTitle: $productTitle, productRate: $productRate, productQuantity: $productQuantity, productTotal: $productTotal, productAmount: $productAmount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InvoiceProductModel &&
        other.productTitle == productTitle &&
        other.productRate == productRate &&
        other.productQuantity == productQuantity &&
        other.productTotal == productTotal &&
        other.productAmount == productAmount;
  }

  @override
  int get hashCode {
    return productTitle.hashCode ^
        productRate.hashCode ^
        productQuantity.hashCode ^
        productTotal.hashCode ^
        productAmount.hashCode;
  }
}

class InvoiceProductModelForUI {
  String productTitle = '';
  double productRate = 0.0;
  int productQuantity = 0;
  double productTotal = 0.0;
  double productAmount = 0.0;
  TextEditingController productTitleController = TextEditingController();
  TextEditingController productRateController = TextEditingController();
  TextEditingController productQuantityController = TextEditingController();
  TextEditingController productTotalController = TextEditingController();
  String productAmountController = '';
}
