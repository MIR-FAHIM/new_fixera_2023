// To parse this JSON data, do
//
//     final vendorSearchModel = vendorSearchModelFromJson(jsonString);

import 'dart:convert';

VendorSearchModel vendorSearchModelFromJson(String str) => VendorSearchModel.fromJson(json.decode(str));

String vendorSearchModelToJson(VendorSearchModel data) => json.encode(data.toJson());

class VendorSearchModel {
    VendorSearchModel({
        this.error,
        this.results,
    });

    bool? error;
    Results? results;

    factory VendorSearchModel.fromJson(Map<String, dynamic> json) => VendorSearchModel(
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
        this.users,
        this.locations,
        this.languages,
        this.freelancerSkills,
        this.projectLength,
        this.keyword,
        this.type,
        this.usersTotalRecords,
        this.saveEmployer,
        this.currentDate,
    });

    Users? users;
    List<Language>? locations;
    List<Language>? languages;
    FreelancerSkills? freelancerSkills;
    ProjectLength? projectLength;
    String? keyword;
    String? type;
    int? usersTotalRecords;
    Map<String, dynamic>? saveEmployer;
    DateTime? currentDate;

    factory Results.fromJson(Map<String, dynamic> json) => Results(
        users: Users.fromJson(json["users"]),
        locations: List<Language>.from(json["locations"].map((x) => Language.fromJson(x))),
        languages: List<Language>.from(json["languages"].map((x) => Language.fromJson(x))),
        freelancerSkills: FreelancerSkills.fromJson(json["freelancer_skills"]),
        projectLength: ProjectLength.fromJson(json["project_length"]),
        keyword: json["keyword"],
        type: json["type"],
        usersTotalRecords: json["users_total_records"],
        saveEmployer: Map.from(json["save_employer"]).map((k, v) => MapEntry<String, dynamic>(k, v)),
        currentDate: DateTime.parse(json["current_date"]),
    );

    Map<String, dynamic> toJson() => {
        "users": users!.toJson(),
        "locations": List<dynamic>.from(locations!.map((x) => x.toJson())),
        "languages": List<dynamic>.from(languages!.map((x) => x.toJson())),
        "freelancer_skills": freelancerSkills!.toJson(),
        "project_length": projectLength!.toJson(),
        "keyword": keyword,
        "type": type,
        "users_total_records": usersTotalRecords,
        "save_employer": Map.from(saveEmployer!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "current_date": currentDate!.toIso8601String(),
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

    factory FreelancerSkills.fromJson(Map<String, dynamic> json) => FreelancerSkills(
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

class Users {
    Users({
        this.data,
        this.pagination,
    });

    List<Datum>? data;
    Pagination? pagination;

    factory Users.fromJson(Map<String, dynamic> json) => Users(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "pagination": pagination!.toJson(),
    };
}

class Datum {
    Datum({
        this.id,
        this.avatar,
        this.banner,
        this.name,
        this.tagline,
        this.verifyStatus,
        this.isFavourite,
    });

    int? id;
    String? avatar;
    String? banner;
    String? name;
    String? tagline;
    bool? verifyStatus;
    bool? isFavourite;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        avatar: json["avatar"],
        banner: json["banner"],
        name: json["name"],
        tagline: json["tagline"],
        verifyStatus: json["verify_status"],
        isFavourite: json["isFavourite"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "avatar": avatar,
        "banner": banner,
        "name": name,
        "tagline": tagline,
        "verify_status": verifyStatus,
        "isFavourite": isFavourite,
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
