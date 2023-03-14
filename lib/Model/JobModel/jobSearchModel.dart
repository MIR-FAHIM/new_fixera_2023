// To parse this JSON data, do
//
//     final jobSearchModel = jobSearchModelFromJson(jsonString);

import 'dart:convert';

JobSearchModel jobSearchModelFromJson(String str) =>
    JobSearchModel.fromJson(json.decode(str));

String jobSearchModelToJson(JobSearchModel data) => json.encode(data.toJson());

class JobSearchModel {
  JobSearchModel({
    this.error,
    this.results,
  });

  bool? error;
  Results? results;

  factory JobSearchModel.fromJson(Map<String, dynamic> json) => JobSearchModel(
        error: json["error"],
        results: Results.fromJson(json["results"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "results": results!.toJson(),
      };
}

class Results {
  Results({
    this.jobs,
    this.categories,
    this.locations,
    this.languages,
    this.freelancerSkills,
    this.projectLength,
    this.jobsTotalRecords,
    this.keyword,
    this.skills,
    this.type,
    this.currentDate,
    this.loggedUserRole,
  });

  Jobs? jobs;
  List<Category>? categories;
  List<Language>? locations;
  List<Language>? languages;
  FreelancerSkills? freelancerSkills;
  ProjectLength? projectLength;
  int? jobsTotalRecords;
  String? keyword;
  List<Language>? skills;
  String? type;
  DateTime? currentDate;
  int? loggedUserRole;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        jobs: Jobs.fromJson(json["jobs"]),
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        locations: List<Language>.from(
            json["locations"].map((x) => Language.fromJson(x))),
        languages: List<Language>.from(
            json["languages"].map((x) => Language.fromJson(x))),
        freelancerSkills: FreelancerSkills.fromJson(json["freelancer_skills"]),
        projectLength: ProjectLength.fromJson(json["project_length"]),
        jobsTotalRecords: json["Jobs_total_records"],
        keyword: json["keyword"],
        skills: List<Language>.from(
            json["skills"].map((x) => Language.fromJson(x))),
        type: json["type"],
        currentDate: DateTime.parse(json["current_date"]),
        loggedUserRole: json["loggedUserRole"],
      );

  Map<String, dynamic> toJson() => {
        "jobs": jobs!.toJson(),
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
        "locations": List<dynamic>.from(locations!.map((x) => x.toJson())),
        "languages": List<dynamic>.from(languages!.map((x) => x.toJson())),
        "freelancer_skills": freelancerSkills!.toJson(),
        "project_length": projectLength!.toJson(),
        "Jobs_total_records": jobsTotalRecords,
        "keyword": keyword,
        "skills": List<dynamic>.from(skills!.map((x) => x.toJson())),
        "type": type!,
        "current_date": currentDate!.toIso8601String(),
        "loggedUserRole": loggedUserRole,
      };
}

class Category {
  Category({
    this.id,
    this.title,
    this.slug,
    this.categoryAbstract,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? title;
  String? slug;
  String? categoryAbstract;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        categoryAbstract: json["abstract"],
        image: json["image"] == null ? null : json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "abstract": categoryAbstract,
        "image": image == null ? null : image,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class FreelancerSkills {
  FreelancerSkills({
    this.independent,
    this.agency,
    this.risingTalent,
  });

  String? independent;
  String? agency;
  String? risingTalent;

  factory FreelancerSkills.fromJson(Map<String, dynamic> json) =>
      FreelancerSkills(
        independent: json["independent"],
        agency: json["agency"],
        risingTalent: json["rising_talent"],
      );

  Map<String, dynamic> toJson() => {
        "independent": independent,
        "agency": agency,
        "rising_talent": risingTalent,
      };
}

class Jobs {
  Jobs({
    this.data,
    this.pagination,
  });

  List<Datum>? data;
  Pagination? pagination;

  factory Jobs.fromJson(Map<String, dynamic> json) => Jobs(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "pagination": pagination!.toJson(),
      };
}

class Datum {
  Datum(
      {this.id,
      this.employer,
      this.verifyStatus,
      this.title,
      this.slug,
      this.price,
      this.location,
      this.type,
      this.duration,
      this.isFeatured,
      this.isFavourite,
      this.paymentStatus,
      this.jobUrl});

  int? id;
  String? employer;
  bool? verifyStatus;
  String? title;
  String? slug;
  int? price;
  String? location;
  String? type;
  String? duration;
  bool? isFeatured;
  bool? isFavourite;
  int? paymentStatus;
  String? jobUrl;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
      id: json["id"],
      employer: json["employer"],
      verifyStatus: json["verify_status"],
      title: json["title"],
      slug: json["slug"],
      price: json["price"],
      location: json["location"],
      type: json["type"],
      duration: json["duration"],
      isFeatured: json["isFeatured"],
      isFavourite: json["isFavourite"],
      paymentStatus: json["payment_status"],
      jobUrl: json["job_url"]);
  Map<String, dynamic> toJson() => {
        "id": id,
        "employer": employer,
        "verify_status": verifyStatus,
        "title": title,
        "slug":slug,
        "price": price,
        "location": location,
        "type": type,
        "duration": duration,
        "isFeatured": isFeatured,
        "isFavourite": isFavourite,
        "payment_status": paymentStatus,
        "job_url": jobUrl
      };
}

class Pagination {
  Pagination({
    this.total,
    this.count,
    this.perPage,
    this.currentPage,
    this.totalPages,
  });

  int? total;
  int? count;
  int? perPage;
  int? currentPage;
  int? totalPages;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        count: json["count"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "count": count,
        "per_page": perPage,
        "current_page": currentPage,
        "total_pages": totalPages,
      };
}

class Language {
  Language({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.parent,
    this.flag,
  });

  int? id;
  String? title;
  String? slug;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? parent;
  String? flag;

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        parent: json["parent"] == null ? null : json["parent"],
        flag: json["flag"] == null ? null : json["flag"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "description": description,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "parent": parent == null ? null : parent,
        "flag": flag == null ? null : flag,
      };
}

class ProjectLength {
  ProjectLength({
    this.weekly,
    this.monthly,
    this.threeMonth,
    this.sixMonth,
    this.moreThanSix,
  });

  String? weekly;
  String? monthly;
  String? threeMonth;
  String? sixMonth;
  String? moreThanSix;

  factory ProjectLength.fromJson(Map<String, dynamic> json) => ProjectLength(
        weekly: json["weekly"],
        monthly: json["monthly"],
        threeMonth: json["three_month"],
        sixMonth: json["six_month"],
        moreThanSix: json["more_than_six"],
      );

  Map<String, dynamic> toJson() => {
        "weekly": weekly,
        "monthly": monthly,
        "three_month": threeMonth,
        "six_month": sixMonth,
        "more_than_six": moreThanSix,
      };
}
