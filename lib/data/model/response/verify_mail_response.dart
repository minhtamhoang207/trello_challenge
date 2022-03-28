import 'dart:convert';

VerifyMailResponse verifyMailResponseFromJson(String str) => VerifyMailResponse.fromJson(json.decode(str));

String verifyMailResponseToJson(VerifyMailResponse data) => json.encode(data.toJson());

class VerifyMailResponse {
  VerifyMailResponse({
    required this.message,
    required this.meta,
    required this.time,
  });

  final String message;
  final Meta meta;
  final DateTime time;

  factory VerifyMailResponse.fromJson(Map<String, dynamic> json) => VerifyMailResponse(
    message: json["message"],
    meta: Meta.fromJson(json["meta"]),
    time: DateTime.parse(json["time"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "meta": meta.toJson(),
    "time": time.toIso8601String(),
  };
}

class Meta {
  Meta();

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
  );

  Map<String, dynamic> toJson() => {
  };
}
