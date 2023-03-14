// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  HomeModel({
    this.error,
    this.results,
  });

  bool? error;
  HomeResults? results;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        error: json["error"],
        results: HomeResults.fromJson(json["results"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "results": results!.toJson(),
      };
}

class HomeResults {
  HomeResults({
    this.categories,
    this.featuredContractors,
    this.latestJobs,
  });

  List<HomeCategory>? categories;
  List<HomeFeaturedContractor>? featuredContractors;
  List<HomeLatestJob>? latestJobs;

  factory HomeResults.fromJson(Map<String, dynamic> json) => HomeResults(
        categories: List<HomeCategory>.from(
            json["categories"].map((x) => HomeCategory.fromJson(x))),
        featuredContractors: List<HomeFeaturedContractor>.from(
            json["featured_contractors"]
                .map((x) => HomeFeaturedContractor.fromJson(x))),
        latestJobs: List<HomeLatestJob>.from(
            json["latest_jobs"].map((x) => HomeLatestJob.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
        "featured_contractors":
            List<dynamic>.from(featuredContractors!.map((x) => x.toJson())),
        "latest_jobs": List<dynamic>.from(latestJobs!.map((x) => x.toJson())),
      };
}

class HomeCategory {
  HomeCategory({
    this.image,
    this.link,
    this.name,
    this.slug,
    this.termId,
    this.description,
    this.items,
  });

  String? image;
  String? link;
  String? name;
  String? slug;
  int? termId;
  String? description;
  int? items;

  factory HomeCategory.fromJson(Map<String, dynamic> json) => HomeCategory(
        image: json["image"],
        link: json["link"],
        name: json["name"],
        slug: json["slug"],
        termId: json["term_id"],
        description: json["description"],
        items: json["items"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "link": link,
        "name": name,
        "slug": slug,
        "term_id": termId,
        "description": description,
        "items": items,
      };
}

class HomeFeaturedContractor {
  HomeFeaturedContractor({
    this.id,
    this.name,
    this.avatar,
    this.banner,
    this.tagline,
    this.hourlyRate,
    this.isFavourite,
    this.verifyStatus,
  });

  int? id;
  String? name;
  String? avatar;
  String? banner;
  var tagline;
  var hourlyRate;
  bool? isFavourite;
  bool? verifyStatus;

  factory HomeFeaturedContractor.fromJson(Map<String, dynamic> json) =>
      HomeFeaturedContractor(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
        banner: json["banner"],
        tagline: json["tagline"],
        hourlyRate: json["hourly_rate"],
        isFavourite: json["isFavourite"],
        verifyStatus: json["verify_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
        "banner": banner,
        "tagline": tagline,
        "hourly_rate": hourlyRate,
        "isFavourite": isFavourite,
        "verify_status": verifyStatus,
      };
}

class HomeLatestJob {
  HomeLatestJob(
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
      this.jobUrl,
      this.paymentStatus});

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

  factory HomeLatestJob.fromJson(Map<String, dynamic> json) => HomeLatestJob(
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
         jobUrl: json["job_url"],
        paymentStatus: json["payment_status"],
      );

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
        "job_url": jobUrl,
        "payment_status": paymentStatus
      };
}
