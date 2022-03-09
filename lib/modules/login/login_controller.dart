import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../data/api/repository/auth_repository.dart';

class LoginController extends GetxController {
  final AuthRepository authRepository;
  LoginController({required this.authRepository});

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();


}