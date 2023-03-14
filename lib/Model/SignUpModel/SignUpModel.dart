// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

SignUpModel signUpModelFromJson(String str) => SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
    SignUpModel({
        this.error,
        this.results,
    });

    bool? error;
    SignUpResults? results;

    factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        error: json["error"],
        results: SignUpResults.fromJson(json["results"]),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "results": results!.toJson(),
    };
}

class SignUpResults {
    SignUpResults({
        this.employeeCount,
        this.departments,
        this.locations,
        this.categories,
        this.roles,
    });

    Map<String, SignUpEmployeeCount>? employeeCount;
    List<SignUpDepartment>? departments;
    Map? locations;
    Map<String, String>? categories;
    List<SignUpRole>? roles;

    factory SignUpResults.fromJson(Map<String, dynamic> json) => SignUpResults(
        employeeCount: Map.from(json["employee_count"]).map((k, v) => MapEntry<String, SignUpEmployeeCount>(k, SignUpEmployeeCount.fromJson(v))),
        departments: List<SignUpDepartment>.from(json["departments"].map((x) => SignUpDepartment.fromJson(x))),
        locations: Map.from(json["locations"]).map((k, v) => MapEntry<String, String>(k, v)),
        categories: Map.from(json["categories"]).map((k, v) => MapEntry<String, String>(k, v)),
        roles: List<SignUpRole>.from(json["roles"].map((x) => SignUpRole.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "employee_count": Map.from(employeeCount!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "departments": List<dynamic>.from(departments!.map((x) => x.toJson())),
        "locations": Map.from(locations!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "categories": Map.from(categories!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "roles": List<dynamic>.from(roles!.map((x) => x.toJson())),
    };
}

class SignUpDepartment {
    SignUpDepartment({
        this.id,
        this.title,
        this.slug,
    });

    int? id;
    String? title;
    String? slug;

    factory SignUpDepartment.fromJson(Map<String, dynamic> json) => SignUpDepartment(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
    };
}

class SignUpEmployeeCount {
    SignUpEmployeeCount({
        this.title,
        this.searchTitle,
        this.value,
    });

    String? title;
    String? searchTitle;
    int? value;

    factory SignUpEmployeeCount.fromJson(Map<dynamic, dynamic> json) => SignUpEmployeeCount(
        title: json["title"],
        searchTitle: json["search_title"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "search_title": searchTitle,
        "value": value,
    };
}

class SignUpRole {
    SignUpRole({
        this.id,
        this.name,
        this.roleType,
    });

    int? id;
    String? name;
    String? roleType;

    factory SignUpRole.fromJson(Map<String, dynamic> json) => SignUpRole(
        id: json["id"],
        name: json["name"],
        roleType: json["role_type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "role_type": roleType,
    };
}
