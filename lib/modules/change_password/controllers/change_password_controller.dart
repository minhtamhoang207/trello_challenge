import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:trello_challenge/data/api/repository/user_repository.dart';
import 'package:trello_challenge/data/model/request/change_password_request.dart';
import 'package:trello_challenge/routes/app_pages.dart';
import 'package:trello_challenge/shared/utils/common_widget.dart';
import 'package:trello_challenge/shared/widgets/custom_dialog.dart';

import '../../../shared/enums/dialog_type.dart';

class ChangePasswordController extends GetxController {
  final UserRepository userRepository;
  ChangePasswordController({required this.userRepository});

  @override
  void onInit() {
    super.onInit();
  }

  TextEditingController oldPassword = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final showPassword = RxBool(false);
  final showConfirmPassword = RxBool(false);

  void changePassword() async {
    if (validPassword()) {
      CommonWidget.showLoading();
      try {
        await userRepository.changePassword(
            data: ChangePasswordRequest(
                oldPassword: oldPassword.text,
                newPassword: passwordController.text));
        CommonWidget.hideLoading();
        Get.dialog(const CustomDialog(
                dialogType: DialogType.success,
                message:
                    'Đã thay đổi mật khẩu\nvui lòng đăng nhập lại để tiếp tục'))
            .then((value) => Get.offAllNamed(Routes.login));
      } catch (e) {
        log(e.toString());
        CommonWidget.hideLoading();
        Get.dialog(
            CustomDialog(dialogType: DialogType.failed, message: e.toString()));
      }
    } else {
      showError();
    }
  }

  bool validPassword() {
    if (passwordController.text.trim().length >= 6 &&
        passwordController.text.trim() ==
            confirmPasswordController.text.trim() &&
        oldPassword.text.trim().isNotEmpty) {
      return true;
    }
    return false;
  }

  showError() {
    if (passwordController.text.trim().length < 6) {
      CommonWidget.toast('Mật khẩu chứa ít nhất 6 kí tự');
    } else if (oldPassword.text.trim().isEmpty) {
      CommonWidget.toast('Vui lòng nhập mật khẩu cũ');
    } else if (passwordController.text.trim().contains(' ')) {
      CommonWidget.toast('Mật khẩu không được chưa khoảng trắng');
    } else if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      CommonWidget.toast('Mật khẩu không khớp');
    }
  }

  @override
  void dispose() {
    oldPassword.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
