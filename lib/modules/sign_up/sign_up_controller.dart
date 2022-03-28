import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:trello_challenge/data/model/request/register_request.dart';
import 'package:trello_challenge/shared/enums/dialog_type.dart';
import 'package:trello_challenge/shared/utils/common_widget.dart';
import 'package:trello_challenge/shared/widgets/custom_dialog.dart';
import '../../data/api/repository/auth_repository.dart';

class SignUpController extends GetxController{
  final AuthRepository authRepository;
  SignUpController({required this.authRepository});

  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController reEnterPasswordController = TextEditingController();

  register() async {
    CommonWidget.showLoading();
    try{
      await authRepository.register(data: RegisterRequest(
          email: emailController.text,
          userName: userNameController.text,
          password: passwordController.text
      ));
      CommonWidget.hideLoading();
      // CommonWidget.showLottie('https://assets7.lottiefiles.com/packages/lf20_y2hxPc.json');
      // await Future.delayed(const Duration(seconds: 2));
      // CommonWidget.hideLoading();
      Get.dialog(const CustomDialog(dialogType: DialogType.success, message: 'Đăng kí thành công'));
    } catch(e){
      log(e.toString());
      CommonWidget.hideLoading();
      Get.dialog(CustomDialog(dialogType: DialogType.failed, message: e.toString()));
    }
  }

}