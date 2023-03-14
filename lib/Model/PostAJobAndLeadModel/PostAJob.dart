// To parse this JSON data, do
//
//     final postAJobModel = postAJobModelFromJson(jsonString);

import 'dart:convert';

import 'package:new_fixera/Model/ContractorModel/ContractorPageModel.dart';

PostAJobModel postAJobModelFromJson(String str) =>
    PostAJobModel.fromJson(json.decode(str));

String postAJobModelToJson(PostAJobModel data) => json.encode(data.toJson());

class PostAJobModel {
  PostAJobModel({
    this.error,
    this.results,
  });

  bool? error;
  Results? results;

  factory PostAJobModel.fromJson(Map<String, dynamic> json) => PostAJobModel(
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
   // this.insuranceCompany,
    //this.leadInsurance,
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
 // Map<String, String> insuranceCompany;
 // Map<String, String> leadInsurance;
  List customCategories = [];

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        priceType: Map.from(json["price_type"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        projectDuration: Map.from(json["project_duration"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        freelancerLevel: Map.from(json["freelancer_level"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        measurement: Map.from(json["measurement"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        // Measurement.fromJson(json["measurement"]),

        categories: Map.from(json["categories"]).map((k, v) {
          return MapEntry<String, String>(k, v);
        }),
        subCategories: Map.from(json["sub_categories"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        languages: Map.from(json["languages"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        skills: Map.from(json["skills"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        locations: Map.from(json["locations"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        // insuranceCompany: Map.from(json["insurance_company"])
        //     .map((k, v) => MapEntry<String, String>(k, v)),
        // leadInsurance: Map.from(json["lead_insurance"])
        //     .map((k, v) => MapEntry<String, String>(k, v)),
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
        //measurement.toJson(),

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
        // "insurance_company": Map.from(insuranceCompany)
        //     .map((k, v) => MapEntry<String, dynamic>(k, v)),
        // "lead_insurance": Map.from(insuranceCompany)
        //     .map((k, v) => MapEntry<String, dynamic>(k, v)),
      };

  // categories.forEach((k,v)=>customCategories.add(CustomeCategories(k,v)));

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

  List get freelancerLevelValue {
    return [independent, agency, risingTalent];
  }

  List get freelancerLevelKey {
    return [
      "independent",
      "agency",
      "rising_talent",
    ];
  }
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
  List get measureMentValue {
    return [
      da,
      bf,
      bg,
      bundle,
      bx,
      cf,
      cr,
      cy,
      ea,
      ft,
      hr,
      lb,
      lf,
      ly,
      mb,
      ml,
      mn,
      mo,
      pl,
      pt,
      qt,
      rl,
      rm,
      sf,
      sq,
      sy,
      tb,
      tn,
      un,
      wk,
      mth,
      yr,
    ];
  }

  List get mesurementKey {
    return [
      "DA",
      "BF",
      "BG",
      "Bundle",
      "BX",
      "CF",
      "CR",
      "EA",
      "FT",
      "HR",
      "LB",
      "LF",
      "LY",
      "MB",
      "ML",
      "MN",
      "MO",
      "PL",
      "PT",
      "QT",
      "RL",
      "RM",
      "SF",
      "SQ",
      "SY",
      "TB",
      "TN",
      "UN",
      "WK",
      "MTH",
      "YR"
    ];
  }
}

// class Categories {
//   Categories({
//     this.da,
//     this.bf,
//     this.bg,
//     this.bundle,
//     this.bx,
//     this.cf,
//     this.cr,
//     this.cy,
//     this.ea,
//     this.ft,
//     this.hr,
//     this.lb,
//     this.lf,
//     this.ly,
//     this.mb,
//     this.ml,
//     this.mn,
//     this.mo,
//     this.pl,
//     this.pt,
//     this.qt,
//     this.rl,
//     this.rm,
//     this.sf,
//     this.sq,
//     this.sy,
//     this.tb,
//     this.tn,
//     this.un,
//     this.wk,
//     this.mth,
//     this.yr,
//   });

//   String one;
//   String two;
//   String three;
//   String four;
//   String five;
//   String six;
//   String seven;
//   String eight;
//   String nine;
//   String ten;
//   String eleven;
//   String twelev;
//   String thirteen;
//   String fourteen;
//   String fifteen;
//   String sixteen;
//   String seventeen;
//   String eighteen;
//   String ninteen;
//   String twenty;
//   String twentyone;
//   String twentytwo;
//   String twentythree;
//   String sf;
//   String sq;
//   String sy;
//   String tb;
//   String tn;
//   String un;
//   String wk;
//   String mth;
//   String yr;

//   factory Categories.fromJson(Map<String, dynamic> json) => Categories(
//         da: json["DA"],
//         bf: json["BF"],
//         bg: json["BG"],
//         bundle: json["Bundle"],
//         bx: json["BX"],
//         cf: json["CF"],
//         cr: json["CR"],
//         cy: json["CY"],
//         ea: json["EA"],
//         ft: json["FT"],
//         hr: json["HR"],
//         lb: json["LB"],
//         lf: json["LF"],
//         ly: json["LY"],
//         mb: json["MB"],
//         ml: json["ML"],
//         mn: json["MN"],
//         mo: json["MO"],
//         pl: json["PL"],
//         pt: json["PT"],
//         qt: json["QT"],
//         rl: json["RL"],
//         rm: json["RM"],
//         sf: json["SF"],
//         sq: json["SQ"],
//         sy: json["SY"],
//         tb: json["TB"],
//         tn: json["TN"],
//         un: json["UN"],
//         wk: json["WK"],
//         mth: json["MTH"],
//         yr: json["YR"],
//       );

//   Map<String, dynamic> toJson() => {
//         "DA": da,
//         "BF": bf,
//         "BG": bg,
//         "Bundle": bundle,
//         "BX": bx,
//         "CF": cf,
//         "CR": cr,
//         "CY": cy,
//         "EA": ea,
//         "FT": ft,
//         "HR": hr,
//         "LB": lb,
//         "LF": lf,
//         "LY": ly,
//         "MB": mb,
//         "ML": ml,
//         "MN": mn,
//         "MO": mo,
//         "PL": pl,
//         "PT": pt,
//         "QT": qt,
//         "RL": rl,
//         "RM": rm,
//         "SF": sf,
//         "SQ": sq,
//         "SY": sy,
//         "TB": tb,
//         "TN": tn,
//         "UN": un,
//         "WK": wk,
//         "MTH": mth,
//         "YR": yr,
//       };
//   List get measureMentValue {
//     return [
//       da,
//       bf,
//       bg,
//       bundle,
//       bx,
//       cf,
//       cr,
//       cy,
//       ea,
//       ft,
//       hr,
//       lb,
//       lf,
//       ly,
//       mb,
//       ml,
//       mn,
//       mo,
//       pl,
//       pt,
//       qt,
//       rl,
//       rm,
//       sf,
//       sq,
//       sy,
//       tb,
//       tn,
//       un,
//       wk,
//       mth,
//       yr,
//     ];
//   }

//   List get mesurementKey {
//     return [
//       "DA",
//       "BF",
//       "BG",
//       "Bundle",
//       "BX",
//       "CF",
//       "CR",
//       "EA",
//       "FT",
//       "HR",
//       "LB",
//       "LF",
//       "LY",
//       "MB",
//       "ML",
//       "MN",
//       "MO",
//       "PL",
//       "PT",
//       "QT",
//       "RL",
//       "RM",
//       "SF",
//       "SQ",
//       "SY",
//       "TB",
//       "TN",
//       "UN",
//       "WK",
//       "MTH",
//       "YR"
//     ];
//   }

// }
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
  List get priceTypeValue {
    return [hourly, production, daily, flatRate, bid];
  }

  List get priceTypeKey {
    return ["hourly", "production", "daily", "flat_rate", "bid"];
  }
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
  List get projectDurationValue {
    return [weekly, monthly, threeMonth, sixMonth, moreThanSix];
  }

  List get projectDurationKey {
    return ["weekly", "monthly", "three_month", "six_month", "more_than_six"];
  }
}
