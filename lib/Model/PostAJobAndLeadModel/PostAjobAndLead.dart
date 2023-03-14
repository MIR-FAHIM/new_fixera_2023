// To parse this JSON data, do
//
//     final postAJobAndLeadModel = postAJobAndLeadModelFromJson(jsonString);

import 'dart:convert';

PostAJobAndLeadModel postAJobAndLeadModelFromJson(String str) => PostAJobAndLeadModel.fromJson(json.decode(str));

String postAJobAndLeadModelToJson(PostAJobAndLeadModel data) => json.encode(data.toJson());

class PostAJobAndLeadModel {
    PostAJobAndLeadModel({
        this.error,
        this.results,
    });

    bool? error;
    Results? results;

    factory PostAJobAndLeadModel.fromJson(Map<String, dynamic> json) => PostAJobAndLeadModel(
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
        this.message,
    });

    String? message;

    factory Results.fromJson(Map<String, dynamic> json) => Results(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
