// To parse this JSON data, do
//
//     final contractorPageModel = contractorPageModelFromJson(jsonString);

import 'dart:convert';

ContractorPageModel contractorPageModelFromJson(String str) =>
    ContractorPageModel.fromJson(json.decode(str));

String contractorPageModelToJson(ContractorPageModel data) =>
    json.encode(data.toJson());

class ContractorPageModel {
  ContractorPageModel({
    this.error,
    this.results,
  });

  bool? error;
  Results? results;

  factory ContractorPageModel.fromJson(Map<String, dynamic> json) =>
      ContractorPageModel(
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
    this.type,
    this.users,
    this.categories,
    this.locations,
    this.languages,
    this.skills,
    this.projectLength,
    this.keyword,
    this.usersTotalRecords,
    // this.saveFreelancer,
    this.symbol,
    this.currentDate,
    this.hourlyRates,
    this.contractorType,
    this.englishLevel,
  });

  String? type;
  Users? users;
  List<Category>? categories;
  List<Language>? locations;
  List<Language>? languages;
  List<Language>? skills;
  ProjectLength? projectLength;
  String? keyword;
  int? usersTotalRecords;


  //List<String> saveFreelancer;
  Symbol? symbol;
  DateTime? currentDate;
  HourlyRates? hourlyRates;
  ContractorType? contractorType;
  EnglishLevel? englishLevel;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        type: json["type"],
        users: Users.fromJson(json["users"]),
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        locations: List<Language>.from(
            json["locations"].map((x) => Language.fromJson(x))),
        languages: List<Language>.from(
            json["languages"].map((x) => Language.fromJson(x))),
        skills: List<Language>.from(
            json["skills"].map((x) => Language.fromJson(x))),
        projectLength: ProjectLength.fromJson(json["project_length"]),
        keyword: json["keyword"],
        usersTotalRecords: json["users_total_records"],
        // saveFreelancer:
        //     List<String>.from(json["save_freelancer"].map((x) => x)),
        symbol: Symbol.fromJson(json["symbol"]),
        currentDate: DateTime.parse(json["current_date"]),
        hourlyRates: HourlyRates.fromJson(json["hourly_rates"]),
        contractorType: ContractorType.fromJson(json["contractor_type"]),
        englishLevel: EnglishLevel.fromJson(json["english_level"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "users": users!.toJson(),
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
        "locations": List<dynamic>.from(locations!.map((x) => x.toJson())),
        "languages": List<dynamic>.from(languages!.map((x) => x.toJson())),
        "skills": List<dynamic>.from(skills!.map((x) => x.toJson())),
        "project_length": projectLength!.toJson(),
        "keyword": keyword,
        "users_total_records": usersTotalRecords,
        // "save_freelancer": List<dynamic>.from(saveFreelancer.map((x) => x)),
        "symbol": symbol!.toJson(),
        "current_date": currentDate!.toIso8601String(),
        "hourly_rates": hourlyRates!.toJson(),
        "contractor_type": contractorType!.toJson(),
        "english_level": englishLevel!.toJson(),
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

class ContractorType {
  ContractorType({
    this.independent,
    this.agency,
    this.risingTalent,
  });

  String? independent;
  String? agency;
  String? risingTalent;

  factory ContractorType.fromJson(Map<String, dynamic> json) => ContractorType(
        independent: json["3"],
        agency: json["4"],
        risingTalent: json["5"],
      );

  Map<String, dynamic> toJson() => {
        "3": independent,
        "4": agency,
        "5": risingTalent,
      };

  List get contractorTypeValue {
    return [independent, agency, risingTalent];
  }

  List get contractorTypeKey {
    return [
      "3",
      "4",
      "5",
    ];
  }
}

class EnglishLevel {
  EnglishLevel({
    this.basic,
    this.conversational,
    this.fluent,
    this.native,
    this.professional,
  });

  String? basic;
  String? conversational;
  String? fluent;
  String? native;
  String? professional;

  factory EnglishLevel.fromJson(Map<String, dynamic> json) => EnglishLevel(
        basic: json["basic"],
        conversational: json["conversational"],
        fluent: json["fluent"],
        native: json["native"],
        professional: json["professional"],
      );

  Map<String, dynamic> toJson() => {
        "basic": basic,
        "conversational": conversational,
        "fluent": fluent,
        "native": native,
        "professional": professional,
      };

  List get englishLevelValue {
    return [
      basic,
      conversational,
      fluent,
      native,
      professional,
    ];
  }

  List get englishLevelKey {
    return [
      "basic",
      "conversational",
      "fluent",
      "native",
      "professional",
    ];
  }
}

class HourlyRates {
  HourlyRates({
    this.the05,
    this.the510,
    this.the1020,
    this.the2030,
    this.the3040,
    this.the4050,
    this.the5060,
    this.the6070,
    this.the7080,
    this.the900,
  });

  String? the05;
  String? the510;
  String? the1020;
  String? the2030;
  String? the3040;
  String? the4050;
  String? the5060;
  String? the6070;
  String? the7080;
  String? the900;

  factory HourlyRates.fromJson(Map<String, dynamic> json) => HourlyRates(
        the05: json["0-5"],
        the510: json["5-10"],
        the1020: json["10-20"],
        the2030: json["20-30"],
        the3040: json["30-40"],
        the4050: json["40-50"],
        the5060: json["50-60"],
        the6070: json["60-70"],
        the7080: json["70-80"],
        the900: json["90-0"],
      );

  Map<String, dynamic> toJson() => {
        "0-5": the05,
        "5-10": the510,
        "10-20": the1020,
        "20-30": the2030,
        "30-40": the3040,
        "40-50": the4050,
        "50-60": the5060,
        "60-70": the6070,
        "70-80": the7080,
        "90-0": the900,
      };

  List get hourlyRatesValue {
    return [
      the05,
      the510,
      the1020,
      the2030,
      the3040,
      the4050,
      the5060,
      the6070,
      the7080,
      the900,
    ];
  }

  List get hourlyRatesKey {
    return [
      "0-5",
      "5-10",
      "10-20",
      "20-30",
      "30-40",
      "40-50",
      "50-60",
      "60-70",
      "70-80",
      "90-0",
    ];
  }
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

class Symbol {
  Symbol({
    this.code,
    this.name,
    this.symbol,
  });

  String? code;
  String? name;
  String? symbol;
  String? rating;

  factory Symbol.fromJson(Map<String, dynamic> json) => Symbol(
        code: json["code"],
        name: json["name"],
        symbol: json["symbol"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "symbol": symbol,
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
    this.name,
    this.avatar,
    this.banner,
    this.tagline,
    this.hourlyRate,
    this.isFavourite,
    this.verifyStatus,
    this.rating,
  });

  var id;
  String? name;
  String? avatar;
  String? banner;
  String? tagline;
  var hourlyRate;
  bool? isFavourite;
  bool? verifyStatus;
  String? rating;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
        banner: json["banner"],
        tagline: json["tagline"],
        hourlyRate: json["hourly_rate"],
        isFavourite: json["isFavourite"],
        verifyStatus: json["verify_status"],
    rating: json["rating"]
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
    "rating": rating
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
