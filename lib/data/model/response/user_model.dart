import 'dart:convert';

UserResponseModel userFromJson(String str) => UserResponseModel.fromJson(json.decode(str));

class UserResponseModel {
  UserResponseModel({
    this.message,
    this.data,
    this.meta,
    this.time,
  });

  String? message;
  Data? data;
  Meta? meta;
  DateTime? time;

  factory UserResponseModel.fromJson(Map<String, dynamic> json) => UserResponseModel(
    message: json["message"],
    data: Data.fromJson(json["data"]),
    meta: Meta.fromJson(json["meta"]),
    time: DateTime.parse(json["time"]),
  );
}

class Data {
  Data({
    this.id,
    this.username,
    this.email,
    this.active,
    this.bio,
    this.nickname,
    this.avatar,
  });

  String? id;
  String? username;
  String? email;
  bool? active;
  String? bio;
  String? nickname;
  String? avatar;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"]??0,
    username: json["username"]??'',
    email: json["email"]??'',
    active: json["active"]??false,
    bio: json["bio"]??'',
    nickname: json["nickname"]??'',
    avatar: json["avatar"]??'',
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
    "email": email,
    "active": active,
    "bio": bio,
    "nickname": nickname,
    "avatar": avatar,
  };
}

class Meta {
  Meta();

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
  );

  Map<String, dynamic> toJson() => {
  };
}
