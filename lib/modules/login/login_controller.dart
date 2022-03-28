import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trello_challenge/data/api/repository/auth_repository.dart';
import 'package:trello_challenge/data/model/request/login_request.dart';
import 'package:trello_challenge/routes/app_pages.dart';
import 'package:trello_challenge/shared/constants/storage.dart';
import 'package:trello_challenge/shared/enums/dialog_type.dart';
import 'package:trello_challenge/shared/utils/common_widget.dart';
import 'package:trello_challenge/shared/widgets/custom_dialog.dart';

class LoginController extends GetxController {
  final AuthRepository authRepository;
  LoginController({required this.authRepository});

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  final SharedPreferences _sharedPreferences = Get.find();

  login() async {
    CommonWidget.showLoading();
    try{
      final response = await authRepository.login(data: LoginRequest(
          userName: userNameController.text,
          password: passwordController.text
      ));
      _sharedPreferences.setString(StorageConstants.token, response.data.accessToken);
      CommonWidget.hideLoading();
      Get.toNamed(Routes.home);
    } catch (e){
      log(e.toString());
      CommonWidget.hideLoading();
      Get.dialog(CustomDialog(dialogType: DialogType.failed, message: e.toString()));
    }
  }
}