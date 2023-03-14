// To parse this JSON data, do
//
//     final jobDialogModel = jobDialogModelFromJson(jsonString);

import 'dart:convert';

JobDialogModel jobDialogModelFromJson(String str) => JobDialogModel.fromJson(json.decode(str));

String jobDialogModelToJson(JobDialogModel data) => json.encode(data.toJson());

class JobDialogModel {
    JobDialogModel({
        this.error,
        this.results,
    });

    bool? error;
    Results? results;

    factory JobDialogModel.fromJson(Map<String, dynamic> json) => JobDialogModel(
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
        this.paymentStatus,
        this.modalHeader,
        this.modalBodyMessageOne,
        this.modalBodyMessageTwo,
        this.modalBodyMessageThree,
        this.url,
    });

    int? paymentStatus;
    String? modalHeader;
    String? modalBodyMessageOne;
    String? modalBodyMessageTwo;
    String? modalBodyMessageThree;
    String? url;

    factory Results.fromJson(Map<String, dynamic> json) => Results(
        paymentStatus: json["payment_status"],
        modalHeader: json["modal_header"],
        modalBodyMessageOne: json["modal_body_message_one"],
        modalBodyMessageTwo: json["modal_body_message_two"],
        modalBodyMessageThree: json["modal_body_message_three"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "payment_status": paymentStatus,
        "modal_header": modalHeader,
        "modal_body_message_one": modalBodyMessageOne,
        "modal_body_message_two": modalBodyMessageTwo,
        "modal_body_message_three": modalBodyMessageThree,
        "url": url,
    };
}
