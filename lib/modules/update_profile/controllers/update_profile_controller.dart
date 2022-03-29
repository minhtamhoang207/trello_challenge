import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:trello_challenge/data/api/repository/user_repository.dart';
import 'package:trello_challenge/data/model/params/update_profile_params.dart';
import 'package:trello_challenge/data/model/request/update_profile_request.dart';
import 'package:trello_challenge/modules/profile/profile_controller.dart';
import 'package:trello_challenge/shared/enums/dialog_type.dart';
import 'package:trello_challenge/shared/utils/common_widget.dart';
import 'package:trello_challenge/shared/widgets/custom_dialog.dart';

class UpdateProfileController extends GetxController {
  final UserRepository userRepository;
  UpdateProfileController({required this.userRepository});

  TextEditingController nicknameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  var oldNickname = '';
  var oldBio = '';
  UpdateProfileParams argument = Get.arguments;

  @override
  void onInit() {
    nicknameController.text = argument.nickname;
    bioController.text = argument.bio;
    oldNickname = argument.nickname;
    oldBio = argument.bio;
    super.onInit();
  }

  void updateProfile() async {
    if ((nicknameController.text != oldNickname ||
            bioController.text != oldBio) &&
        (nicknameController.text.isNotEmpty || bioController.text.isNotEmpty)) {
      CommonWidget.showLoading();
      try {
        await userRepository.updateProfile(
            data: UpdateProfileRequest(
                nickname: nicknameController.text, bio: bioController.text));
        Get.back();
        Get.find<ProfileController>().loadUser();
        CommonWidget.hideLoading();
      } catch (e) {
        log(e.toString());
        CommonWidget.hideLoading();
        Get.dialog(
            CustomDialog(dialogType: DialogType.failed, message: e.toString()));
      }
    }
  }

  @override
  void dispose() {
    nicknameController.dispose();
    bioController.dispose();
    super.dispose();
  }
}
