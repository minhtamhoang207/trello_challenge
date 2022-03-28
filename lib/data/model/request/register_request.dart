class RegisterRequest{
  String email;
  String userName;
  String password;

  RegisterRequest({required this.email, required this.userName, required this.password});

  Map<String, dynamic> toJson() => {
    "username": userName,
    "password": password,
    "email": email
  };
}