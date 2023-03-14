import 'dart:io';
import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/Views/Utilities/AppUrl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:new_fixera/Model/CreateInvoice/invoice_product_model.dart';

class CreateInvoiceModel {
  String? companyName;
  String? companyAddress;
  String? companyEmail;
  String? companyMobile;
  String? vendorName;
  String? vendorMobile;
  String? recievableVendorEmail;
  String? vendorAddress;
  String? paymentDate;
  double? totalAmount;
  List<InvoiceProductModel>? invoiceProductList = [];
  List<File>? images;
  CreateInvoiceModel({
    @required this.companyName,
    @required this.companyAddress,
    @required this.companyEmail,
    @required this.companyMobile,
    @required this.vendorName,
    @required this.vendorMobile,
    @required this.recievableVendorEmail,
    @required this.vendorAddress,
    @required this.paymentDate,
    @required this.invoiceProductList,
    @required this.totalAmount,
    @required this.images,
  });

  CreateInvoiceModel copyWith({
    String? companyName,
    String? companyAddress,
    String? companyEmail,
    String? companyMobile,
    String? vendorName,
    String? vendorMobile,
    String? recievableVendorEmail,
    String? vendorAddress,
    String? paymentDate,
    double? totalAmount,
    List<InvoiceProductModel>? invoiceProductList,
    List<File>? images,
  }) {
    return CreateInvoiceModel(
      companyName: companyName ?? this.companyName,
      companyAddress: companyAddress ?? this.companyAddress,
      companyEmail: companyEmail ?? this.companyEmail,
      companyMobile: companyMobile ?? this.companyMobile,
      vendorName: vendorName ?? this.vendorName,
      vendorMobile: vendorMobile ?? this.vendorMobile,
      recievableVendorEmail:
          recievableVendorEmail ?? this.recievableVendorEmail,
      vendorAddress: vendorAddress ?? this.vendorAddress,
      paymentDate: paymentDate ?? this.paymentDate,
      invoiceProductList: invoiceProductList ?? this.invoiceProductList,
      totalAmount: totalAmount ?? this.totalAmount,
      images: images ?? this.images,
    );
  }

  Map<String, String> toMap() {
    Map<String, String> data = {
      'company_name': companyName!,
      'company_address': companyAddress!,
      'company_email': companyEmail!,
      'company_mobile': companyMobile!,
      'vendor_name': vendorName!,
      'vendor_mobile': vendorMobile!,
      'receivable_email': recievableVendorEmail!,
      'vendor_address': vendorAddress!,
      'payment_date': paymentDate!,
      'total_amount': totalAmount.toString(),
      'invoice_product_list': invoiceProductList.toString(),
    };
    if (invoiceProductList != null) {
      int index = 0;
      invoiceProductList!.forEach((element) {
        data['title[$index]'] = element.productTitle!;
        data['rate[$index]'] = element.productRate.toString();
        data['quantity[$index]'] = element.productQuantity.toString();
        data['final_amount[$index]'] =
            (element.productRate! * element.productQuantity!).toString();
        print(data);

        index++;
      });
    }
    return data;
  }

  factory CreateInvoiceModel.fromMap(Map<String, dynamic> map) {
    return CreateInvoiceModel(
      companyName: map['companyName'] ?? '',
      companyAddress: map['companyAddress'] ?? '',
      companyEmail: map['companyEmail'] ?? '',
      companyMobile: map['companyMobile'] ?? '',
      vendorName: map['vendorName'] ?? '',
      vendorMobile: map['vendorMobile'] ?? '',
      recievableVendorEmail: map['recievableVendorEmail'] ?? '',
      vendorAddress: map['vendorAddress'] ?? '',
      paymentDate: map['paymentDate'] ?? '',
      invoiceProductList: List<InvoiceProductModel>.from(
          map['invoiceProductList']
              ?.map((x) => InvoiceProductModel.fromMap(x))),
      totalAmount: map['totalAmount'] ?? 0,
      images: List<File>.from(map['images']?.map((x) => File(x))),
    );
  }

  @override
  String toString() {
    return 'CreateInvoiceModel(companyName: $companyName, companyAddress: $companyAddress, companyEmail: $companyEmail, companyMobile: $companyMobile, vendorName: $vendorName, vendorMobile: $vendorMobile, recievableVendorEmail: $recievableVendorEmail, vendorAddress: $vendorAddress, paymentDate: $paymentDate, invoiceProductList: $invoiceProductList)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreateInvoiceModel &&
        other.companyName == companyName &&
        other.companyAddress == companyAddress &&
        other.companyEmail == companyEmail &&
        other.companyMobile == companyMobile &&
        other.vendorName == vendorName &&
        other.vendorMobile == vendorMobile &&
        other.recievableVendorEmail == recievableVendorEmail &&
        other.vendorAddress == vendorAddress &&
        other.paymentDate == paymentDate &&
        listEquals(other.invoiceProductList, invoiceProductList) &&
        other.totalAmount == totalAmount &&
        listEquals(other.images, images);
  }

  @override
  int get hashCode {
    return companyName.hashCode ^
        companyAddress.hashCode ^
        companyEmail.hashCode ^
        companyMobile.hashCode ^
        vendorName.hashCode ^
        vendorMobile.hashCode ^
        recievableVendorEmail.hashCode ^
        vendorAddress.hashCode ^
        paymentDate.hashCode ^
        invoiceProductList.hashCode ^
        totalAmount.hashCode ^
        images.hashCode;
  }

  save() async {
    var dio = Dio(
      BaseOptions(
        contentType: Headers.formUrlEncodedContentType,
        responseType: ResponseType.json,
        receiveDataWhenStatusError: true,
        validateStatus: (status) {
          return status < 500;
        },
      ),
    );
    FormData formData = FormData.fromMap(toMap());
    print(toString());
    for (int i = 0; i < images!.length; i++) {
      formData.files.add(MapEntry('images[$i]',
          await MultipartFile.fromFile(images![i].path, filename: 'image.png')));
    }
    var response = await dio.post(AppUrl.invoiceStore,
        data: formData, options: Options(headers: MyApiClient.header2()));
    print(response.data);
    print(response.statusCode);
    return response;
    // if (response.statusCode == 200) {
    //   return true;
    // } else {
    //   return false;
    // }
  }
}
