class CreateInvoiceNewModel {
  bool? error;
  InvoiceListResults? results;

  CreateInvoiceNewModel({this.error, this.results});

  CreateInvoiceNewModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    results =
    json['results'] != null ? new InvoiceListResults.fromJson(json['results']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.results != null) {
      data['results'] = this.results!.toJson();
    }
    return data;
  }
}

class InvoiceListResults {
  List<Data>? data;
  Pagination?  pagination;

  InvoiceListResults({this.data, this.pagination});

  InvoiceListResults.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
     List<Data> data = [];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? receivableEmail;
  String? invoiceNumber;
  String? paymentDate;
  String? totalAmount;
  String? vendorName;
  String? vendorAddress;
  String? vendorMobile;
  String? vendorEmail;
  String? createdAt;

  Data(
      {this.id,
        this.receivableEmail,
        this.invoiceNumber,
        this.paymentDate,
        this.totalAmount,
        this.vendorName,
        this.vendorAddress,
        this.vendorMobile,
        this.vendorEmail,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    receivableEmail = json['receivable_email'];
    invoiceNumber = json['invoice_number'];
    paymentDate = json['payment_date'];
    totalAmount = json['total_amount'];
    vendorName = json['vendor_name'];
    vendorAddress = json['vendor_address'];
    vendorMobile = json['vendor_mobile'];
    vendorEmail = json['vendor_email'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['receivable_email'] = this.receivableEmail;
    data['invoice_number'] = this.invoiceNumber;
    data['payment_date'] = this.paymentDate;
    data['total_amount'] = this.totalAmount;
    data['vendor_name'] = this.vendorName;
    data['vendor_address'] = this.vendorAddress;
    data['vendor_mobile'] = this.vendorMobile;
    data['vendor_email'] = this.vendorEmail;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Pagination {
  int? currentPage;
  int? lastPage;

  Pagination({this.currentPage, this.lastPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    lastPage = json['last_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    return data;
  }
}

