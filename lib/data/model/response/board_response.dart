import 'dart:convert';

BoardResponse boardResponseFromJson(String str) => BoardResponse.fromJson(json.decode(str));

class BoardResponse {
  BoardResponse({
    this.message,
    required this.data,
    this.meta,
    this.time,
  });

  String? message;
  List<BoardModel> data;
  Meta? meta;
  DateTime? time;

  factory BoardResponse.fromJson(Map<String, dynamic> json) => BoardResponse(
    message: json["message"]??'',
    data: json["data"] != null ? List<BoardModel>.from(json["data"].map((x) => BoardModel.fromJson(x))): [],
    meta: Meta.fromJson(json["meta"]),
    time: DateTime.parse(json["time"]),
  );
}

class BoardModel {
  BoardModel({
    required this.id,
    this.name,
    this.background,
    this.project,
    this.createdAt,
    this.updatedAt,
    this.closedAt,
  });

  String id;
  String? name;
  String? background;
  String? project;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? closedAt;

  factory BoardModel.fromJson(Map<String, dynamic> json) => BoardModel(
    id: json["_id"],
    name: json["name"]??'',
    background: json["background"]??'',
    project: json["project"]??'',
    createdAt: json["createdAt"] == null ? null: DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null: DateTime.parse(json["updatedAt"]),
    closedAt: json["closed_at"] == null ? null : DateTime.parse(json["closed_at"]),
  );
}

class Meta {
  Meta();

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
  );

  Map<String, dynamic> toJson() => {
  };
}
