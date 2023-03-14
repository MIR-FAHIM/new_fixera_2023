// To parse this JSON data, do
//
//     final openJobsModel = openJobsModelFromJson(jsonString);

import 'dart:convert';

OpenJobsModel openJobsModelFromJson(String str) =>
    OpenJobsModel.fromJson(json.decode(str));

String openJobsModelToJson(OpenJobsModel data) => json.encode(data.toJson());

class OpenJobsModel {
  OpenJobsModel({
    this.error,
    this.results,
  });

  bool? error;
  List<Result>? results;

  factory OpenJobsModel.fromJson(Map<String, dynamic> json) => OpenJobsModel(
        error: json["error"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  Result(
      {this.id,
      this.employer,
      this.title,
      this.slug,
      this.price,
      this.location,
      this.type,
      this.duration,
      this.isFeatured,
      this.isFavourite,
      this.verifyStatus,
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
  bool? isFavourite;
  bool? verifyStatus;
  int? paymentstatus;
  String? jobUrl;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
      id: json["id"],
      employer: json["employer"],
      title: json["title"],
      slug:json["slug"],
      price: json["price"],
      location: json["location"],
      type: json["type"],
      duration: json["duration"],
      isFeatured: json["isFeatured"],
      isFavourite: json["isFavourite"],
      paymentstatus: json["payment_status"],
      verifyStatus: json["verify_status"],
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
        "isFavourite": isFavourite,
        "verify_status": verifyStatus,
        "payment_status": paymentstatus,
        "job_url": jobUrl
      };
}
