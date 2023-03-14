// To parse this JSON data, do
//
//     final jobPrivatePublicModel = jobPrivatePublicModelFromJson(jsonString);

import 'dart:convert';

JobPrivatePublicModel jobPrivatePublicModelFromJson(String str) => JobPrivatePublicModel.fromJson(json.decode(str));

String jobPrivatePublicModelToJson(JobPrivatePublicModel data) => json.encode(data.toJson());

class JobPrivatePublicModel {
    JobPrivatePublicModel({
        this.error,
        this.results,
    });

    bool? error;
    Results? results;

    factory JobPrivatePublicModel.fromJson(Map<String, dynamic> json) => JobPrivatePublicModel(
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
        this.jobUrl,
    });

    int? paymentStatus;
    String? jobUrl;

    factory Results.fromJson(Map<String, dynamic> json) => Results(
        paymentStatus: json["payment_status"],
        jobUrl: json["job_url"],
    );

    Map<String, dynamic> toJson() => {
        "payment_status": paymentStatus,
        "job_url": jobUrl,
    };
}
