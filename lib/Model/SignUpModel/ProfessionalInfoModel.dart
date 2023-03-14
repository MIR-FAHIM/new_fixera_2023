// To parse this JSON data, do
//
//     final professionalInfoModel = professionalInfoModelFromJson(jsonString);

import 'dart:convert';

ProfessionalInfoModel professionalInfoModelFromJson(String str) => ProfessionalInfoModel.fromJson(json.decode(str));

String professionalInfoModelToJson(ProfessionalInfoModel data) => json.encode(data.toJson());

class ProfessionalInfoModel {
    ProfessionalInfoModel({
        this.error,
        this.results,
    });

    bool? error;
    ProfessionalInfoModelResults? results;

    factory ProfessionalInfoModel.fromJson(Map<String, dynamic> json) => ProfessionalInfoModel(
        error: json["error"],
        results: ProfessionalInfoModelResults.fromJson(json["results"]),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "results": results!.toJson(),
    };
}

class ProfessionalInfoModelResults {
    ProfessionalInfoModelResults({
        this.message,
        this.userId,
    });

    String? message;
    int? userId;

    factory ProfessionalInfoModelResults.fromJson(Map<String, dynamic> json) => ProfessionalInfoModelResults(
        message: json["message"],
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "user_id": userId,
    };
}
