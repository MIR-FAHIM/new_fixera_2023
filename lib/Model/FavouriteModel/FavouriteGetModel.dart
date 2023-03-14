// To parse this JSON data, do
//
//     final favouriteGetModel = favouriteGetModelFromJson(jsonString);

import 'dart:convert';

FavouriteGetModel favouriteGetModelFromJson(String str) => FavouriteGetModel.fromJson(json.decode(str));

String favouriteGetModelToJson(FavouriteGetModel data) => json.encode(data.toJson());

class FavouriteGetModel {
    FavouriteGetModel({
        this.error,
        this.results,
    });

    bool? error;
    Results? results;

    factory FavouriteGetModel.fromJson(Map<String, dynamic> json) => FavouriteGetModel(
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
        this.savedFreelancers,
        this.savedEmployers,
    });

    List<Job>? jobs;
    List<SavedFreelancer>? savedFreelancers;
    List<SavedEmployer>? savedEmployers;

    factory Results.fromJson(Map<String, dynamic> json) => Results(
        jobs: List<Job>.from(json["jobs"].map((x) => Job.fromJson(x))),
        savedFreelancers: List<SavedFreelancer>.from(json["saved_freelancers"].map((x) => SavedFreelancer.fromJson(x))),
        savedEmployers: List<SavedEmployer>.from(json["saved_employers"].map((x) => SavedEmployer.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "jobs": List<dynamic>.from(jobs!.map((x) => x.toJson())),
        "saved_freelancers": List<dynamic>.from(savedFreelancers!.map((x) => x.toJson())),
        "saved_employers": List<dynamic>.from(savedEmployers!.map((x) => x.toJson())),
    };
}

class Job {
    Job({
        this.id,
        this.employer,
        this.title,
        this.price,
        this.location,
        this.type,
        this.verifyStatus,
        this.duration,
        this.jobUrl,
        this.slug,
        this.paymentStatus
    });

    int? id;
    String? employer;
    String? title;
    int? price;
    String? location;
    String? type;
    bool? verifyStatus;
    String? duration;
    String? jobUrl;
    String? slug;
    int? paymentStatus;

    factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["id"],
        employer: json["employer"],
        title: json["title"],
        price: json["price"],
        location: json["location"],
        type: json["type"],
        verifyStatus: json["verify_status"],
        duration: json["duration"],
        jobUrl: json["job_url"],
          slug: json["slug"],
        paymentStatus: json["payment_status"]

    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "employer": employer,
        "title": title,
        "price": price,
        "location": location,
        "type": type,
        "verify_status":verifyStatus,
        "duration": duration,
        "job_url" : jobUrl,
        "slug": slug,
        "payment_status":paymentStatus
    };
}

class SavedEmployer {
    SavedEmployer({
        this.id,
        this.avatar,
        this.banner,
        this.verifyStatus,
        this.name,
    });

    int? id;
    String? avatar;
    String? banner;
    String? name;
    bool? verifyStatus;

    factory SavedEmployer.fromJson(Map<String, dynamic> json) => SavedEmployer(
        id: json["id"],
        avatar: json["avatar"],
        banner: json["banner"],
        verifyStatus: json["verify_status"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "avatar": avatar,
        "banner": banner,
        "verify_status":verifyStatus,
        "name": name,
    };
}

class SavedFreelancer {
    SavedFreelancer({
        this.id,
        this.name,
        this.avatar,
        this.tagline,
        this.verifyStatus,
        this.hourlyRate,
    });

    int? id;
    String? name;
    String? avatar;
    String? tagline;
    bool? verifyStatus;
    dynamic hourlyRate;

    factory SavedFreelancer.fromJson(Map<String, dynamic> json) => SavedFreelancer(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
        tagline: json["tagline"],
        verifyStatus: json["verify_status"],
        hourlyRate: json["hourly_rate"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
        "tagline": tagline,
        "verify_status":verifyStatus,
        "hourly_rate": hourlyRate,
    };
}
