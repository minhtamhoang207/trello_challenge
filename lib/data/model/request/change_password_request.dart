class ChangePasswordRequest {
  String oldPassword;
  String newPassword;

  ChangePasswordRequest({required this.oldPassword, required this.newPassword});

  Map<String, dynamic> toJson() => {
        "oldPassword": oldPassword,
        "newPassword": newPassword,
      };
}
