// To parse this JSON data, do
//
//     final postALead = postALeadFromJson(jsonString);

import 'dart:convert';

PostALead postALeadFromJson(String str) => PostALead.fromJson(json.decode(str));

String postALeadToJson(PostALead data) => json.encode(data.toJson());

class PostALead {
  PostALead({
    this.error,
    this.results,
  });

  bool? error;
  Results? results;

  factory PostALead.fromJson(Map<String, dynamic> json) => PostALead(
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
    this.priceType,
    this.projectDuration,
    this.freelancerLevel,
    this.measurement,
    this.categories,
    this.subCategories,
    this.languages,
    this.skills,
    this.locations,
    this.leadExpiration,
    this.leadInsurance,
    this.insuranceCompany,
    this.noOfStories,
    this.ageOfRoof,
    this.typeOfRoof,
    this.propertyType,
  });

  Map<String, String>? priceType;
  Map<String, String>? projectDuration;
  Map<String, String>? freelancerLevel;
  Map<String, String>? measurement;
  Map<String, String>? categories;
  Map<String, String>? subCategories;
  Map<String, String>? languages;
  Map<String, String>? skills;
  Map<String, String>? locations;
  Map<String, int>? leadExpiration;
  Map<String, String>? leadInsurance;
  Map<String, String>? insuranceCompany;
  List<int>? noOfStories;
  List<String>? ageOfRoof;
  Map<String, String>? typeOfRoof;
  Map<String, String>? propertyType;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
         priceType: Map.from(json["price_type"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        projectDuration: Map.from(json["project_duration"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        freelancerLevel: Map.from(json["freelancer_level"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        measurement: Map.from(json["measurement"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        categories: Map.from(json["categories"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        subCategories: Map.from(json["sub_categories"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        languages: Map.from(json["languages"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        skills: Map.from(json["skills"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        locations: Map.from(json["locations"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        leadExpiration: Map.from(json["lead_expiration"])
            .map((k, v) => MapEntry<String, int>(k, v)),
        leadInsurance: Map.from(json["lead_insurance"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        insuranceCompany: Map.from(json["insurance_company"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        noOfStories: List<int>.from(json["no_of_stories"].map((x) => x)),
        ageOfRoof: List<String>.from(json["age_of_roof"].map((x) => x)),
        typeOfRoof: Map.from(json["type_of_roof"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        propertyType: Map.from(json["property_type"])
            .map((k, v) => MapEntry<String, String>(k, v)),
      );

  Map<String, dynamic> toJson() => {
          "price_type":
            Map.from(priceType!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "project_duration": Map.from(projectDuration!)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "freelancer_level": Map.from(freelancerLevel!)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "measurement": Map.from(measurement!)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "categories":
            Map.from(categories!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "sub_categories": Map.from(subCategories!)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "languages":
            Map.from(languages!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "skills":
            Map.from(skills!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "locations":
            Map.from(locations!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "lead_expiration": Map.from(leadExpiration!)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "lead_insurance": Map.from(leadInsurance!)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "insurance_company":  Map.from(insuranceCompany!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "no_of_stories": List<dynamic>.from(noOfStories!.map((x) => x)),
        "age_of_roof": List<dynamic>.from(ageOfRoof!.map((x) => x)),
        "type_of_roof":  Map.from(typeOfRoof!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "property_type":  Map.from(propertyType!).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

class FreelancerLevel {
  FreelancerLevel({
    this.independent,
    this.agency,
    this.risingTalent,
  });

  String? independent;
  String? agency;
  String? risingTalent;

  factory FreelancerLevel.fromJson(Map<String, dynamic> json) =>
      FreelancerLevel(
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

class InsuranceCompany {
  InsuranceCompany({
    this.stateFarm,
    this.allFarm,
    this.nationwide,
  });

  String? stateFarm;
  String? allFarm;
  String? nationwide;

  factory InsuranceCompany.fromJson(Map<String, dynamic> json) =>
      InsuranceCompany(
        stateFarm: json["state-farm"],
        allFarm: json["all-farm"],
        nationwide: json["nationwide"],
      );

  Map<String, dynamic> toJson() => {
        "state-farm": stateFarm,
        "all-farm": allFarm,
        "nationwide": nationwide,
      };
}

class Measurement {
  Measurement({
    this.da,
    this.bf,
    this.bg,
    this.bundle,
    this.bx,
    this.cf,
    this.cr,
    this.cy,
    this.ea,
    this.ft,
    this.hr,
    this.lb,
    this.lf,
    this.ly,
    this.mb,
    this.ml,
    this.mn,
    this.mo,
    this.pl,
    this.pt,
    this.qt,
    this.rl,
    this.rm,
    this.sf,
    this.sq,
    this.sy,
    this.tb,
    this.tn,
    this.un,
    this.wk,
    this.mth,
    this.yr,
  });

  String? da;
  String? bf;
  String? bg;
  String? bundle;
  String? bx;
  String? cf;
  String? cr;
  String? cy;
  String? ea;
  String? ft;
  String? hr;
  String? lb;
  String? lf;
  String? ly;
  String? mb;
  String? ml;
  String? mn;
  String? mo;
  String? pl;
  String? pt;
  String? qt;
  String? rl;
  String? rm;
  String? sf;
  String? sq;
  String? sy;
  String? tb;
  String? tn;
  String? un;
  String? wk;
  String? mth;
  String? yr;

  factory Measurement.fromJson(Map<String, dynamic> json) => Measurement(
        da: json["DA"],
        bf: json["BF"],
        bg: json["BG"],
        bundle: json["Bundle"],
        bx: json["BX"],
        cf: json["CF"],
        cr: json["CR"],
        cy: json["CY"],
        ea: json["EA"],
        ft: json["FT"],
        hr: json["HR"],
        lb: json["LB"],
        lf: json["LF"],
        ly: json["LY"],
        mb: json["MB"],
        ml: json["ML"],
        mn: json["MN"],
        mo: json["MO"],
        pl: json["PL"],
        pt: json["PT"],
        qt: json["QT"],
        rl: json["RL"],
        rm: json["RM"],
        sf: json["SF"],
        sq: json["SQ"],
        sy: json["SY"],
        tb: json["TB"],
        tn: json["TN"],
        un: json["UN"],
        wk: json["WK"],
        mth: json["MTH"],
        yr: json["YR"],
      );

  Map<String, dynamic> toJson() => {
        "DA": da,
        "BF": bf,
        "BG": bg,
        "Bundle": bundle,
        "BX": bx,
        "CF": cf,
        "CR": cr,
        "CY": cy,
        "EA": ea,
        "FT": ft,
        "HR": hr,
        "LB": lb,
        "LF": lf,
        "LY": ly,
        "MB": mb,
        "ML": ml,
        "MN": mn,
        "MO": mo,
        "PL": pl,
        "PT": pt,
        "QT": qt,
        "RL": rl,
        "RM": rm,
        "SF": sf,
        "SQ": sq,
        "SY": sy,
        "TB": tb,
        "TN": tn,
        "UN": un,
        "WK": wk,
        "MTH": mth,
        "YR": yr,
      };
}

class PriceType {
  PriceType({
    this.hourly,
    this.production,
    this.daily,
    this.flatRate,
    this.bid,
  });

  String? hourly;
  String? production;
  String? daily;
  String? flatRate;
  String? bid;

  factory PriceType.fromJson(Map<String, dynamic> json) => PriceType(
        hourly: json["hourly"],
        production: json["production"],
        daily: json["daily"],
        flatRate: json["flat_rate"],
        bid: json["bid"],
      );

  Map<String, dynamic> toJson() => {
        "hourly": hourly,
        "production": production,
        "daily": daily,
        "flat_rate": flatRate,
        "bid": bid,
      };
}

class ProjectDuration {
  ProjectDuration({
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

  factory ProjectDuration.fromJson(Map<String, dynamic> json) =>
      ProjectDuration(
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

class PropertyType {
  PropertyType({
    this.residential,
    this.commercial,
  });

  String? residential;
  String? commercial;

  factory PropertyType.fromJson(Map<String, dynamic> json) => PropertyType(
        residential: json["residential"],
        commercial: json["commercial"],
      );

  Map<String, dynamic> toJson() => {
        "residential": residential,
        "commercial": commercial,
      };
}

class TypeOfRoof {
  TypeOfRoof({
    this.metal,
    this.shingle,
    this.tpo,
    this.modifiedBit,
    this.wookShake,
  });

  String? metal;
  String? shingle;
  String? tpo;
  String? modifiedBit;
  String? wookShake;

  factory TypeOfRoof.fromJson(Map<String, dynamic> json) => TypeOfRoof(
        metal: json["metal"],
        shingle: json["shingle"],
        tpo: json["tpo"],
        modifiedBit: json["modified_bit"],
        wookShake: json["wook_shake"],
      );

  Map<String, dynamic> toJson() => {
        "metal": metal,
        "shingle": shingle,
        "tpo": tpo,
        "modified_bit": modifiedBit,
        "wook_shake": wookShake,
      };
}
