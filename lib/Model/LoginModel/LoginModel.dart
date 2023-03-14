// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.error,
    this.accessToken,
    this.tokenType,
    this.expiryTime,
    this.userInfo,
  });

  bool? error;
  String? accessToken;
  String? tokenType;
  var expiryTime;
  UserInfo? userInfo;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        error: json["error"],
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiryTime: json["expiry_time"],
        userInfo: UserInfo.fromJson(json["user_info"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "access_token": accessToken,
        "token_type": tokenType,
        "expiry_time": expiryTime,
        "user_info": userInfo!.toJson(),
      };
}

class UserInfo {
  UserInfo({
    this.id,
    this.firstName,
    this.lastName,
    this.hourlyRate,
    this.tagline,
    this.locationId,
    this.country,
    this.address,
    this.longitude,
    this.latitude,
    this.avatar,
    this.banner,
    this.roleId,
    this.roleName,
    this.profile_completion_status
  });

  var id;
  String? firstName;
  String? lastName;
  var hourlyRate;
  var tagline;
  var locationId;
  String? country;
  String? address;
  var longitude;
  var latitude;
  String? avatar;
  String? banner;
  var roleId;
  String? roleName;
  var profile_completion_status;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        hourlyRate: json["hourly_rate"],
        tagline: json["tagline"],
        locationId: json["location_id"],
        country: json["country"],
        address: json["address"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        avatar: json["avatar"],
        banner: json["banner"],
        roleId: json["role_id"],
        roleName: json["role_name"],
    profile_completion_status:   json["profile_completion_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "hourly_rate": hourlyRate,
        "tagline": tagline,
        "location_id": locationId,
        "country": country,
        "address": address,
        "longitude": longitude,
        "latitude": latitude,
        "avatar": avatar,
        "banner": banner,
        "role_id": roleId,
        "role_name": roleName,
    "profile_completion_status" : profile_completion_status
      };
}
