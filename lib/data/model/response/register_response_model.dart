import 'dart:convert';

RegisterResponse registerResponseFromJson(String str) => RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) => json.encode(data.toJson());

class RegisterResponse {
  RegisterResponse({
    required this.message,
    required this.data,
    required this.meta,
    required this.time,
  });

  final String message;
  final Data data;
  final Meta meta;
  final DateTime time;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        message: json["message"],
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
    required this.username,
    required this.email,
    required this.active,
    required this.id,
  });

  final String username;
  final String email;
  final bool active;
  final String id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        username: json["username"],
        email: json["email"],
        active: json["active"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "active": active,
        "_id": id,
      };
}

class Meta {
  Meta();

  factory Meta.fromJson(Map<String, dynamic> json) => Meta();

  Map<String, dynamic> toJson() => {};
}
