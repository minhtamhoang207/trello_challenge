import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:trello_challenge/data/model/request/register_request.dart';
import 'package:trello_challenge/shared/enums/dialog_type.dart';
import 'package:trello_challenge/shared/utils/common_widget.dart';
import 'package:trello_challenge/shared/utils/regex.dart';
import 'package:trello_challenge/shared/widgets/custom_dialog.dart';
import '../../data/api/repository/auth_repository.dart';

class SignUpController extends GetxController{
  final AuthRepository authRepository;
  SignUpController({required this.authRepository});

  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController reEnterPasswordController = TextEditingController();

  bool validInformation(){
    if(emailController.text.trim().isNotEmpty
    && userNameController.text.trim().isNotEmpty
    && passwordController.text.trim().isNotEmpty
    && userNameController.text.trim().length >= 6
    && passwordController.text.trim().length >=6
    && !userNameController.text.trim().contains(' ')
    && !passwordController.text.trim().contains(' ')
    && passwordController.text == reEnterPasswordController.text){
      return true;
    }
    return false;
  }

  void showError(){
    if(emailController.text.trim().isEmpty){
      CommonWidget.toast('Email không được để trống');
    }
    else if(!Regex.isEmail(emailController.text)){
      CommonWidget.toast('Email không hợp lệ');
    }
    else if(userNameController.text.trim().isEmpty){
      CommonWidget.toast('Tên đăng nhập không được để trống');
    } else if(passwordController.text.trim().isEmpty){
      CommonWidget.toast('Mật khẩu không được để trống');
    } else if(userNameController.text.trim().length < 6 || userNameController.text.contains(' ')){
      CommonWidget.toast('Tên đăng nhập phải chứa ít nhất 6 kí tự và không chứa khoảng trắng');
    } else if(passwordController.text.trim().length < 6 || passwordController.text.contains(' ')){
      CommonWidget.toast('Mật khẩu phải chứa ít nhất 6 kí tự và không chứa khoảng trắng');
    } else if(passwordController.text != reEnterPasswordController.text){
      CommonWidget.toast('Mật khẩu không khớp');
    } else{
      CommonWidget.toast('Đã xảy ra lỗi');
    }
  }

  register() async {
    if(validInformation()){
      CommonWidget.showLoading();
      try{
        await authRepository.register(data: RegisterRequest(
            email: emailController.text,
            userName: userNameController.text,
            password: passwordController.text
        ));
        CommonWidget.hideLoading();
        Get.dialog(const CustomDialog(dialogType: DialogType.success, message: 'Đăng ký thành công'));
      } catch(e){
        log(e.toString());
        CommonWidget.hideLoading();
        Get.dialog(CustomDialog(dialogType: DialogType.failed, message: e.toString()));
      }
    } else{
      showError();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    reEnterPasswordController.dispose();
    super.dispose();
  }
}