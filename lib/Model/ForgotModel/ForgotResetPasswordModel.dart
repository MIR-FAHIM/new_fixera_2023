// To parse this JSON data, do
//
//     final forgotResetPasswordModel = forgotResetPasswordModelFromJson(jsonString);

import 'dart:convert';

ForgotResetPasswordModel forgotResetPasswordModelFromJson(String str) => ForgotResetPasswordModel.fromJson(json.decode(str));

String forgotResetPasswordModelToJson(ForgotResetPasswordModel data) => json.encode(data.toJson());

class ForgotResetPasswordModel {
    ForgotResetPasswordModel({
        this.error,
        this.results,
    });

    bool? error;
    ForgotResetPassResults? results;

    factory ForgotResetPasswordModel.fromJson(Map<String, dynamic> json) => ForgotResetPasswordModel(
        error: json["error"],
        results: ForgotResetPassResults.fromJson(json["results"]),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "results": results!.toJson(),
    };
}

class ForgotResetPassResults {
    ForgotResetPassResults({
        this.message,
    });

    String? message;

    factory ForgotResetPassResults.fromJson(Map<String, dynamic> json) => ForgotResetPassResults(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
