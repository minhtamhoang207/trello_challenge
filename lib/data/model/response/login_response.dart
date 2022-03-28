import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.message,
    required this.data,
    required this.meta,
    required this.time,
  });

  final String message;
  final Data data;
  final Meta meta;
  final DateTime time;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    message: json["message"]??'',
    data: Data.fromJson(json["data"]),
    meta: Meta.fromJson(json["meta"]),
    time: DateTime.parse(json["time"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
    "meta": meta.toJson(),
    "time": time.toIso8601String(),
  };
}

class Data {
  Data({
    required this.accessToken,
    required this.user,
  });

  final String accessToken;
  final User user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accessToken: json["accessToken"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "user": user.toJson(),
  };
}

class User {
  User({
    required this.id,
    required this.active,
    required this.email,
    required this.username,
    required this.bio,
    required this.nickname,
  });

  final String id;
  final bool active;
  final String email;
  final String username;
  final String bio;
  final String nickname;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    active: json["active"],
    email: json["email"]??'',
    username: json["username"]??'',
    bio: json["bio"]??'',
    nickname: json["nickname"]??'',
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "active": active,
    "email": email,
    "username": username,
    "bio": bio,
    "nickname": nickname,
  };
}

class Meta {
  Meta();

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
  );

  Map<String, dynamic> toJson() => {
  };
}
