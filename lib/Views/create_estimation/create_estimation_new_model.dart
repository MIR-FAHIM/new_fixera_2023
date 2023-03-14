class CreateEstimationNewModel {
  bool? error;
  Results? results;

  CreateEstimationNewModel({this.error, this.results});

  CreateEstimationNewModel.fromJson(Map<String, dynamic> json) {
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
  String? receiverEmail;
  String? projectTitle;
  int? price;
  String? companyRepresentiveName;
  String? companyRepresentiveEmail;
  String?  companyRepresentivePhone;
  String? createdAt;

  Data(
      {this.id,
        this.receiverEmail,
        this.projectTitle,
        this.price,
        this.companyRepresentiveName,
        this.companyRepresentiveEmail,
        this.companyRepresentivePhone,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    receiverEmail = json['receiver_email'];
    projectTitle = json['project_title'];
    price = json['price'];
    companyRepresentiveName = json['company_representive_name'];
    companyRepresentiveEmail = json['company_representive_email'];
    companyRepresentivePhone = json['company_representive_phone'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['receiver_email'] = this.receiverEmail;
    data['project_title'] = this.projectTitle;
    data['price'] = this.price;
    data['company_representive_name'] = this.companyRepresentiveName;
    data['company_representive_email'] = this.companyRepresentiveEmail;
    data['company_representive_phone'] = this.companyRepresentivePhone;
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