class UserProfileModel {
  bool? error;
  UserInfo? userInfo;

  UserProfileModel(String responseString, {this.error, this.userInfo});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    userInfo = json['user_info'] != null
        ? new UserInfo.fromJson(json['user_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.userInfo != null) {
      data['user_info'] = this.userInfo!.toJson();
    }
    return data;
  }
}

class UserInfo {
  int? id;
  String? firstName;
  String? lastName;
  String? hourlyRate;
  String? tagline;
  int? locationId;
  String? country;
  String? address;
  String? longitude;
  String? latitude;
  String? avatar;
  String? banner;
  int? roleId;
  String? roleName;
  int? profileCompletionStatus;

  UserInfo(
      {this.id,
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
        this.profileCompletionStatus});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    hourlyRate = json['hourly_rate'];
    tagline = json['tagline'];
    locationId = json['location_id'];
    country = json['country'];
    address = json['address'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    avatar = json['avatar'];
    banner = json['banner'];
    roleId = json['role_id'];
    roleName = json['role_name'];
    profileCompletionStatus = json['profile_completion_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['hourly_rate'] = this.hourlyRate;
    data['tagline'] = this.tagline;
    data['location_id'] = this.locationId;
    data['country'] = this.country;
    data['address'] = this.address;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['avatar'] = this.avatar;
    data['banner'] = this.banner;
    data['role_id'] = this.roleId;
    data['role_name'] = this.roleName;
    data['profile_completion_status'] = this.profileCompletionStatus;
    return data;
  }
}
