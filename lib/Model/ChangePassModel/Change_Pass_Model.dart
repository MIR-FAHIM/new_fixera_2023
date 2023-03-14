import 'dart:convert';

ChangePasswordModel changePasswordModelFromJson(String str) =>
    ChangePasswordModel.fromJson(json.decode(str));

String changePasswordModelToJson(ChangePasswordModel data) =>
    json.encode(data.toJson());

class ChangePasswordModel {
  ChangePasswordModel({
    this.error,
    this.results,
  });

  bool? error;
  ChangePasswordResult? results;

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) =>
      ChangePasswordModel(
        error: json["error"],
        results: ChangePasswordResult.fromJson(json["results"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "results": results!.toJson(),
      };
}

class ChangePasswordResult {
  ChangePasswordResult({
    this.message,
  });

  String? message;

  factory ChangePasswordResult.fromJson(Map<String, dynamic> json) =>
      ChangePasswordResult(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
