import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:trello_challenge/data/api/repository/auth_repository.dart';
import 'package:trello_challenge/data/model/request/login_request.dart';
import 'package:trello_challenge/data/model/request/verify_mail_request.dart';
import 'package:trello_challenge/routes/app_pages.dart';
import 'package:trello_challenge/shared/constants/storage.dart';
import 'package:trello_challenge/shared/enums/dialog_type.dart';
import 'package:trello_challenge/shared/enums/verify_email_type.dart';
import 'package:trello_challenge/shared/utils/common_widget.dart';
import 'package:trello_challenge/shared/utils/regex.dart';
import 'package:trello_challenge/shared/widgets/custom_dialog.dart';

class LoginController extends GetxController {
  final AuthRepository authRepository;
  LoginController({required this.authRepository});

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final SharedPreferences _sharedPreferences = Get.find();
  IO.Socket socket = Get.find();



  @override
  void onInit() {
    // connectToServer();
  }

  bool validInformation() {
    if (userNameController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty &&
        userNameController.text.trim().length >= 3 &&
        passwordController.text.trim().length >= 6 &&
        !userNameController.text.trim().contains(' ') &&
        !passwordController.text.trim().contains(' ')) {
      return true;
    }
    return false;
  }

  showError() {
    if (userNameController.text.trim().isEmpty) {
      CommonWidget.toast('Tên đăng nhập không được để trống');
    } else if (passwordController.text.trim().isEmpty) {
      CommonWidget.toast('Mật khẩu không được để trống');
    } else if (userNameController.text.trim().length < 3 ||
        userNameController.text.contains(' ')) {
      CommonWidget.toast(
          'Tên đăng nhập phải chứa ít nhất 3 kí tự và không chứa khoảng trắng');
    } else if (passwordController.text.trim().length < 6 ||
        passwordController.text.contains(' ')) {
      CommonWidget.toast(
          'Mật khẩu phải chứa ít nhất 6 kí tự và không chứa khoảng trắng');
    } else {
      CommonWidget.toast('Đã xảy ra lỗi');
    }
  }

  login() async {
    if (validInformation()) {
      CommonWidget.showLoading();
      try {
        final response = await authRepository.login(
            data: LoginRequest(
                userName: userNameController.text,
                password: passwordController.text));
        _sharedPreferences.setString(
            StorageConstants.token, response.data.accessToken
        );
        _sharedPreferences.setString(
            StorageConstants.userID, response.data.user.id
        );
        await connectAndListen(token: response.data.accessToken);
        CommonWidget.hideLoading();
        Get.offAllNamed(Routes.home);
      } catch (e) {
        log(e.toString());
        CommonWidget.hideLoading();
        Get.dialog(CustomDialog(dialogType: DialogType.failed, message: e.toString()));
      }
    } else {
      showError();
    }
  }
  

  verifyEmail(VerifyEmailType verifyEmailType) async {
    if (Regex.isEmail(emailController.text)) {
      CommonWidget.showLoading();
      try {
        await authRepository.verifyMail(
            data: VerifyMailRequest(
                email: emailController.text, type: verifyEmailType.value));
        CommonWidget.hideLoading();
        emailController.clear();
        Get.back();
        Get.dialog(const CustomDialog(
            dialogType: DialogType.success,
            message: 'Vui lòng kiểm tra email của bạn'));
      } catch (e) {
        log(e.toString());
        CommonWidget.hideLoading();
        Get.dialog(
            CustomDialog(dialogType: DialogType.failed, message: e.toString()));
      }
    } else {
      CommonWidget.toast('Email không hợp lệ');
    }
  }

  connectAndListen({required String token}) {
    try{
      socket.emit('login', {
        "accessToken": token
      });
      socket.on('login', (data) => log('login socket data : $data'));
      socket.onError((err){
        log('LOGIN SOCKET ERR: $err');
        throw err;
      });
    } catch (e){
      CommonWidget.toast(e.toString());
    }
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
