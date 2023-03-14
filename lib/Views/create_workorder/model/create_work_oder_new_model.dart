class CreateWorkOrderNewModel {
  bool? error;
  Results? results;

  CreateWorkOrderNewModel({this.error, this.results});

  CreateWorkOrderNewModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    results =
    json['results'] != null ? new Results.fromJson(json['results']) : null;
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

class Results {
  List<Data>? data;
  Pagination? pagination;

  Results({this.data, this.pagination});

  Results.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      List<Data> data = [];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
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
  String? jobName;
  String? price;
  String? customerName;
  String? customerAddress;
  String? comRepName;
  String? comRepEmail;
  String? comRepPhone;
  String? createdAt;

  Data(
      {this.id,
        this.receivableEmail,
        this.jobName,
        this.price,
        this.customerName,
        this.customerAddress,
        this.comRepName,
        this.comRepEmail,
        this.comRepPhone,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    receivableEmail = json['receivable_email'];
    jobName = json['job_name'];
    price = json['price'];
    customerName = json['customer_name'];
    customerAddress = json['customer_address'];
    comRepName = json['com_rep_name'];
    comRepEmail = json['com_rep_email'];
    comRepPhone = json['com_rep_phone'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['receivable_email'] = this.receivableEmail;
    data['job_name'] = this.jobName;
    data['price'] = this.price;
    data['customer_name'] = this.customerName;
    data['customer_address'] = this.customerAddress;
    data['com_rep_name'] = this.comRepName;
    data['com_rep_email'] = this.comRepEmail;
    data['com_rep_phone'] = this.comRepPhone;
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

