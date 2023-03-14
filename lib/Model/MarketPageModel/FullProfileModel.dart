// To parse this JSON data, do
//
//     final fullProfileModel = fullProfileModelFromJson(jsonString);

import 'dart:convert';

FullProfileModel fullProfileModelFromJson(String str) =>
    FullProfileModel.fromJson(json.decode(str));

String fullProfileModelToJson(FullProfileModel data) =>
    json.encode(data.toJson());

class FullProfileModel {
  FullProfileModel({
    this.error,
    this.results,
  });

  bool? error;
  Results? results;

  factory FullProfileModel.fromJson(Map<String, dynamic> json) =>
      FullProfileModel(
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
    this.id,
    this.avatar,
    this.banner,
    this.name,
    this.tagline,
    this.isFavourite,
    this.about,
    this.role,
    this.verifyStatus,
    this.jobs,
  });

  int? id;
  String? avatar;
  String? banner;
  String? name;
  String? tagline;
  bool? isFavourite;
  String? about;
  String? role;
  bool? verifyStatus;
  List<Job>? jobs;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        id: json["id"],
        avatar: json["avatar"],
        banner: json["banner"],
        name: json["name"],
        tagline: json["tagline"],
        isFavourite: json["isFavourite"],
        about: json["about"],
        role: json["role"],
        verifyStatus: json["verify_status"],
        jobs: List<Job>.from(json["jobs"].map((x) => Job.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "avatar": avatar,
        "banner": banner,
        "name": name,
        "tagline": tagline,
        "isFavourite": isFavourite,
        "about": about,
        "role": role,
        "verify_status": verifyStatus,
        "jobs": List<dynamic>.from(jobs!.map((x) => x.toJson())),
      };
}

class Job {
  Job(
      {this.id,
      this.employer,
      this.title,
      this.slug,
      this.price,
      this.location,
      this.type,
      this.duration,
      this.isFeatured,
      this.verifyStatus,
      this.isFavourite,
      this.paymentstatus,
      this.jobUrl});

  int? id;
  String? employer;
  String? title;
   String? slug;
  int? price;
  String? location;
  String? type;
  String? duration;
  bool? isFeatured;
  bool? verifyStatus;
  bool? isFavourite;
  int? paymentstatus;
  String? jobUrl;

  factory Job.fromJson(Map<String, dynamic> json) => Job(
      id: json["id"],
      employer: json["employer"],
      title: json["title"],
       slug:json["slug"],
      price: json["price"],
      location: json["location"],
      type: json["type"],
      duration: json["duration"],
      isFeatured: json["isFeatured"],
      verifyStatus: json["verify_status"],
      isFavourite: json["isFavourite"],
      paymentstatus: json["payment_status"],
      jobUrl: json["job_url"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "employer": employer,
        "title": title,
        "slug" : slug,
        "price": price,
        "location": location,
        "type": type,
        "duration": duration,
        "isFeatured": isFeatured,
        "verify_status": verifyStatus,
        "isFavourite": isFavourite,
        "payment_status": paymentstatus,
        "job_url": jobUrl
      };
}
