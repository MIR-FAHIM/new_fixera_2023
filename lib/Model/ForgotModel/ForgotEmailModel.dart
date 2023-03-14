// To parse this JSON data, do
//
//     final forgotEmail = forgotEmailFromJson(jsonString);

import 'dart:convert';

ForgotEmail forgotEmailFromJson(String str) => ForgotEmail.fromJson(json.decode(str));

String forgotEmailToJson(ForgotEmail data) => json.encode(data.toJson());

class ForgotEmail {
    ForgotEmail({
        this.error,
        this.results,
    });

    bool? error;
    ForgotResults? results;

    factory ForgotEmail.fromJson(Map<String, dynamic> json) => ForgotEmail(
        error: json["error"],
        results: ForgotResults.fromJson(json["results"]),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "results": results!.toJson(),
    };
}

class ForgotResults {
    ForgotResults({
        this.message,
        this.userId,
    });

    String? message;
    int? userId;

    factory ForgotResults.fromJson(Map<String, dynamic> json) => ForgotResults(
        message: json["message"],
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "user_id": userId,
    };
}
