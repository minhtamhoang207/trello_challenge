import 'dart:convert';

BoardDetailModel boardDetailModelFromJson(String str) => BoardDetailModel.fromJson(json.decode(str));

String boardDetailModelToJson(BoardDetailModel data) => json.encode(data.toJson());

class BoardDetailModel {
  BoardDetailModel({
    required this.message,
    required this.data,
    required this.meta,
    required this.time,
  });

  final String message;
  final List<BoardListObject> data;
  final Meta meta;
  final DateTime time;

  factory BoardDetailModel.fromJson(Map<String, dynamic> json) => BoardDetailModel(
    message: json["message"],
    data: List<BoardListObject>.from(json["data"].map((x) => BoardListObject.fromJson(x))),
    meta: Meta.fromJson(json["meta"]),
    time: DateTime.parse(json["time"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "meta": meta.toJson(),
    "time": time.toIso8601String(),
  };
}

class BoardListObject {
  BoardListObject({
    required this.id,
    required this.name,
    required this.seqNo,
    required this.board,
    required this.createdAt,
    required this.updatedAt,
    required this.tasks,
    required this.datumId,
  });

  final String id;
  final String name;
  final int seqNo;
  final String board;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Task> tasks;
  final String datumId;

  factory BoardListObject.fromJson(Map<String, dynamic> json) => BoardListObject(
    id: json["_id"],
    name: json["name"],
    seqNo: json["seq_no"],
    board: json["board"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    tasks: List<Task>.from(json["tasks"].map((x) => Task.fromJson(x))),
    datumId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "seq_no": seqNo,
    "board": board,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "tasks": List<dynamic>.from(tasks.map((x) => x.toJson())),
    "id": datumId,
  };
}

class Task {
  Task({
    required this.id,
    required this.name,
    required this.seqNo,
    required this.members,
    required this.column,
    required this.done,
    required this.checklist,
    required this.labels,
    required this.attachments,
    required this.createdAt,
    required this.updatedAt,
    required this.taskId,
  });

  final String id;
  final String name;
  final int seqNo;
  final List<dynamic> members;
  final String column;
  final bool done;
  final List<dynamic> checklist;
  final List<dynamic> labels;
  final List<dynamic> attachments;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String taskId;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json["_id"],
    name: json["name"],
    seqNo: json["seq_no"],
    members: List<dynamic>.from(json["members"].map((x) => x)),
    column: json["column"],
    done: json["done"],
    checklist: List<dynamic>.from(json["checklist"].map((x) => x)),
    labels: List<dynamic>.from(json["labels"].map((x) => x)),
    attachments: List<dynamic>.from(json["attachments"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    taskId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "seq_no": seqNo,
    "members": List<dynamic>.from(members.map((x) => x)),
    "column": column,
    "done": done,
    "checklist": List<dynamic>.from(checklist.map((x) => x)),
    "labels": List<dynamic>.from(labels.map((x) => x)),
    "attachments": List<dynamic>.from(attachments.map((x) => x)),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "id": taskId,
  };
}

class Meta {
  Meta();

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
  );

  Map<String, dynamic> toJson() => {
  };
}
