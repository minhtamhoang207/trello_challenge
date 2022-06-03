import 'dart:convert';

import 'package:trello_challenge/data/model/response/user_model.dart';

ProjectResponse projectResponseFromJson(String str) => ProjectResponse.fromJson(json.decode(str));

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
}

class ProjectModel {
  ProjectModel({
    required this.id,
    this.name,
    this.description,
    required this.type,
    required this.members,
  });

  String id;
  String? name;
  String? description;
  String? type;
  List<ProjectMember> members;

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
    id: json["_id"],
    name: json["name"]??'',
    description: json["description"]??'',
    type: json["type"],
    members: json["members"] != null? List<ProjectMember>.from(json["members"].map((x) => ProjectMember.fromJson(x))):[],
  );
}

class ProjectMember {
  ProjectMember({
    required this.user,
    this.role,
    this.updateDate,
  });

  User user;
  String? role;
  DateTime? updateDate;

  factory ProjectMember.fromJson(Map<String, dynamic> json) => ProjectMember(
    user: User.fromJson(json["user"]),
    role: json["role"],
    updateDate: DateTime.parse(json["updateDate"]),
  );
}

class User {
  User({
    required this.id,
    this.username,
    this.email,
    this.active,
    this.bio,
    this.nickname,
    this.avatar,
    this.role
  });

  String id;
  String? username;
  String? email;
  bool? active;
  String? bio;
  String? nickname;
  String? avatar;
  String? role;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    username: json["username"]??'',
    email: json["email"]??'',
    active: json["active"]??false,
    bio: json["bio"]??'',
    nickname: json["nickname"]??'',
    avatar: json["avatar"]??'',
    role: json["role"]??''
  );
}

class Meta {
  Meta();

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
  );

  Map<String, dynamic> toJson() => {
  };
}
