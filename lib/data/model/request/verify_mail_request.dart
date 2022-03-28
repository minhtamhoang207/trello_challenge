class VerifyMailRequest{
  String email;
  String type;

  VerifyMailRequest({required this.email, required this.type});

  Map<String, dynamic> toJson() => {
    "email": email,
    "type": type,
  };
}