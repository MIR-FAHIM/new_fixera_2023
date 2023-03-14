// To parse this JSON data, do
//
//     final contractorDetailsModel = contractorDetailsModelFromJson(jsonString);

import 'dart:convert';

ContractorDetailsModel contractorDetailsModelFromJson(String str) =>
    ContractorDetailsModel.fromJson(json.decode(str));

String contractorDetailsModelToJson(ContractorDetailsModel data) =>
    json.encode(data.toJson());

class ContractorDetailsModel {
  ContractorDetailsModel({
    this.error,
    this.results,
  });

  bool? error;
  Results? results;

  factory ContractorDetailsModel.fromJson(Map<String, dynamic> json) =>
      ContractorDetailsModel(
        error: json["error"],
        results: Results.fromJson(json["results"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "results": results!.toJson(),
      };
}

class Results {
  Results(
    this.id,
    this.name,
    this.avatar,
    this.banner,
    this.tagline,
    this.hourlyRate,
    this.isFavourite,
    this.verifyStatus,
    this.since,
    this.rating,
    this.feedback,
    this.about,
    this.locationFlag,
    this.location,
    this.ongoingJobs,
    this.completedJobs,
    this.canceledJobs,
    this.earning,
    this.skills,
    this.awards,
    this.awardImagePath,
    this.projects,
    this.projectImagePath,
    this.educations,
    this.experiences,
    this.feedbackLists,
    this.category,
  );

  int? id;
  String? name;
  String? avatar;
  String? banner;
  String? tagline;
  var hourlyRate;
  bool? isFavourite;
  bool? verifyStatus;
  String? since;
  var rating;
  String? category;
  var feedback;
  String? about;
  String? locationFlag;
  String? location;
  var ongoingJobs;
  var completedJobs;
  var canceledJobs;
  var earning;
  List<dynamic>? skills;
  List<Award>? awards;
  String? awardImagePath;
  List<Project>? projects;
  String? projectImagePath;
  List<Education>? educations;
  List<Experience>? experiences;
  List<FeedbackList>? feedbackLists;

  Results.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    avatar = json["avatar"];
    banner = json["banner"];
    tagline = json["tagline"];
    hourlyRate = json["hourly_rate"];
    isFavourite = json["isFavourite"];
    verifyStatus = json["verify_status"];
    since = json["since"];
    rating = json["rating"];
    category = json["category"];
    feedback = json["feedback"];
    about = json["about"];
    locationFlag = json["location_flag"];
    location = json["location"];
    ongoingJobs = json["ongoing_jobs"];
    completedJobs = json["completed_jobs"];
    canceledJobs = json["canceled_jobs"];
    earning = json["earning"];
    skills = List<dynamic>.from(json["skills"].map((x) => x));
    awards = List<Award>.from(json["awards"].map((x) => Award.fromJson(x)));
    awardImagePath = json["award_image_path"];
    projects =
        List<Project>.from(json["projects"].map((x) => Project.fromJson(x)));
    projectImagePath = json["project_image_path"];
    educations = List<Education>.from(
        json["educations"].map((x) => Education.fromJson(x)));
    experiences = List<Experience>.from(
        json["experiences"].map((x) => Experience.fromJson(x)));
    feedbackLists = List<FeedbackList>.from(
        json["feedback_lists"].map((x) => FeedbackList.fromJson(x)));
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
        "banner": banner,
        "tagline": tagline,
        "hourly_rate": hourlyRate,
        "isFavourite": isFavourite,
        "verify_status": verifyStatus,
        "since": since,
        "rating": rating,
    "category": category,
        "feedback": feedback,
        "about": about,
        "location_flag": locationFlag,
        "location": location,
        "ongoing_jobs": ongoingJobs,
        "completed_jobs": completedJobs,
        "canceled_jobs": canceledJobs,
        "earning": earning,
        "skills": List<dynamic>.from(skills!.map((x) => x)),
        "awards": List<dynamic>.from(awards!.map((x) => x.toJson())),
        "award_image_path": awardImagePath,
        "projects": List<dynamic>.from(projects!.map((x) => x.toJson())),
        "project_image_path": projectImagePath,
        "educations": List<dynamic>.from(educations!.map((x) => x.toJson())),
        "experiences": List<dynamic>.from(experiences!.map((x) => x.toJson())),
        "feedback_lists":
            List<dynamic>.from(feedbackLists!.map((x) => x.toJson())),
      };
}

class Award {
  Award({
    this.awardTitle,
    this.awardDate,
    this.awardHiddenImage,
  });

  String? awardTitle;
  String? awardDate;
  String? awardHiddenImage;

  factory Award.fromJson(Map<String, dynamic> json) => Award(
        awardTitle: json["award_title"],
        awardDate: json["award_date"],
        awardHiddenImage: json["award_hidden_image"],
      );

  Map<String, dynamic> toJson() => {
        "award_title": awardTitle,
        "award_date": awardDate,
        "award_hidden_image": awardHiddenImage,
      };
}

class Education {
  Education({
    this.degreeTitle,
    this.startDate,
    this.endDate,
    this.instituteTitle,
    this.description,
  });

  String? degreeTitle;
  String? startDate;
  String? endDate;
  String? instituteTitle;
  String? description;

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        degreeTitle: json["degree_title"],
        startDate: json["start_date"],
        // DateTime.parse(),
        endDate: json["end_date"],
        // DateTime.parse(json["end_date"]),
        instituteTitle: json["institute_title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "degree_title": degreeTitle,
        "start_date": startDate,
        //"${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date": endDate,
        //"${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "institute_title": instituteTitle,
        "description": description,
      };
}

class Experience {
  Experience({
    this.jobTitle,
    this.startDate,
    this.endDate,
    this.companyTitle,
    this.description,
  });

  String? jobTitle;
  String? startDate;
  String? endDate;
  String? companyTitle;
  String? description;

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        jobTitle: json["job_title"],
        startDate: json["start_date"],
        //DateTime.parse(json["start_date"]),
        endDate: json["end_date"],
        //DateTime.parse(json["end_date"]),
        companyTitle: json["company_title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "job_title": jobTitle,
        "start_date": startDate,
        //"${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date": endDate,
        //"${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "company_title": companyTitle,
        "description": description,
      };
}

class FeedbackList {
  FeedbackList({
    this.clientName,
    this.verifyStatus,
    this.jobTitle,
    this.jobType,
    this.locationFlag,
    this.location,
    this.rating,
    this.feedback,
  });

  String? clientName;
  bool? verifyStatus;
  String? jobTitle;
  String? jobType;
  String? locationFlag;
  String? location;
  int? rating;
  String? feedback;

  factory FeedbackList.fromJson(Map<String, dynamic> json) => FeedbackList(
        clientName: json["client_name"],
        verifyStatus: json["verify_status"],
        jobTitle: json["job_title"],
        jobType: json["job_type"],
        locationFlag: json["location_flag"],
        location: json["location"],
        rating: json["rating"],
        feedback: json["feedback"],
      );

  Map<String, dynamic> toJson() => {
        "client_name": clientName,
        "verify_status": verifyStatus,
        "job_title": jobTitle,
        "job_type": jobType,
        "location_flag": locationFlag,
        "location": location,
        "rating": rating,
        "feedback": feedback,
      };
}

class Project {
  Project({
    this.projectTitle,
    this.projectUrl,
    this.projectHiddenImage,
  });

  String? projectTitle;
  String? projectUrl;
  String? projectHiddenImage;

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        projectTitle: json["project_title"],
        projectUrl: json["project_url"],
        projectHiddenImage: json["project_hidden_image"],
      );

  Map<String, dynamic> toJson() => {
        "project_title": projectTitle,
        "project_url": projectUrl,
        "project_hidden_image": projectHiddenImage,
      };
}
