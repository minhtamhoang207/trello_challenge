import 'dart:convert';

ProjectResponse projectResponseFromJson(String str) => ProjectResponse.fromJson(json.decode(str));

String projectResponseToJson(ProjectResponse data) => json.encode(data.toJson());

class ProjectResponse {
  ProjectResponse({
    this.message,
    required this.data,
    this.meta,
    this.time,
  });

  String? message;
  List<ProjectModel> data;
  Meta? meta;
  DateTime? time;

  factory ProjectResponse.fromJson(Map<String, dynamic> json) => ProjectResponse(
    message: json["message"],
    data: json["data"] != null ?List<ProjectModel>.from(json["data"].map((x) => ProjectModel.fromJson(x))):[],
    meta: Meta.fromJson(json["meta"]),
    time: DateTime.parse(json["time"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "meta": meta?.toJson(),
    "time": time?.toIso8601String(),
  };
}

class ProjectModel {
  ProjectModel({
    required this.id,
    this.name,
    this.description,
    required this.isPrivate,
    required this.members,
  });

  String id;
  String? name;
  String? description;
  bool isPrivate;
  List<Member> members;

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
    id: json["_id"],
    name: json["name"]??'',
    description: json["description"]??'',
    isPrivate: json["is_private"],
    members: json["members"] != null? List<Member>.from(json["members"].map((x) => Member.fromJson(x))):[],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "description": description,
    "is_private": isPrivate,
    "members": List<dynamic>.from(members.map((x) => x.toJson())),
  };
}

class Member {
  Member({
    this.user,
    this.role,
    this.updateDate,
  });

  String? user;
  String? role;
  DateTime? updateDate;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    user: json["user"]??'',
    role: json["role"]??'',
    updateDate: DateTime.parse(json["updateDate"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "role": role,
    "updateDate": updateDate?.toIso8601String(),
  };
}

class Meta {
  Meta();

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
  );

  Map<String, dynamic> toJson() => {
  };
}
