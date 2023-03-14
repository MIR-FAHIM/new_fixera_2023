// To parse this JSON data, do
//
//     final favouritePostModel = favouritePostModelFromJson(jsonString);

import 'dart:convert';

FavouritePostModel favouritePostModelFromJson(String str) => FavouritePostModel.fromJson(json.decode(str));

String favouritePostModelToJson(FavouritePostModel data) => json.encode(data.toJson());

class FavouritePostModel {
    FavouritePostModel({
        this.error,
        this.results,
    });

    bool? error;
    Results? results;

    factory FavouritePostModel.fromJson(Map<String, dynamic> json) => FavouritePostModel(
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
        this.isRemove,
    });

    String? message;
    int? isRemove;

    factory Results.fromJson(Map<String, dynamic> json) => Results(
        message: json["message"],
        isRemove: json["isRemove"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "isRemove": isRemove,
    };
}
