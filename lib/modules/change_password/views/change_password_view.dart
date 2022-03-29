import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:trello_challenge/shared/constants/colors.dart';
import 'package:trello_challenge/shared/utils/focus.dart';
import 'package:trello_challenge/shared/widgets/input_field.dart';
import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.primaryColor,
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: NeumorphicButton(
                  margin: const EdgeInsets.only(bottom: 30),
                  style: NeumorphicStyle(
                      color: AppColor.primaryColor,
                      boxShape: const NeumorphicBoxShape.circle(),
                      depth: 4,
                      shadowLightColor: AppColor.white,
                      intensity: 100,
                      lightSource: LightSource.topLeft),
                  onPressed: () {
                    Get.back();
                  },
                  child: const Icon(Icons.arrow_back_outlined),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 23, top: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Thay đổi mật khẩu',
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: AppColor.darkLiver),
                ),
              ),
            ),
            Neumorphic(
                margin: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 30, top: 30),
                style: NeumorphicStyle(
                  color: AppColor.primaryColor,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
                  depth: -3,
                  shadowLightColorEmboss: AppColor.darkGray.withOpacity(0.4),
                ),
                child: InputField(
                  password: true,
                  controller: controller.oldPassword,
                  color: AppColor.black,
                  prefix: const Icon(CupertinoIcons.lock),
                  placeholder: 'Nhập mật khẩu cũ',
                  fontSize: 15,
                )),
            Neumorphic(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                style: NeumorphicStyle(
                  color: AppColor.primaryColor,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
                  depth: -3,
                  shadowLightColorEmboss: AppColor.darkGray.withOpacity(0.4),
                ),
                child: Obx(
                  () => InputField(
                    password: !controller.showPassword.value,
                    controller: controller.passwordController,
                    color: AppColor.black,
                    prefix: const Icon(CupertinoIcons.lock_rotation_open),
                    suffix: GestureDetector(
                      onTap: () {
                        controller.showPassword.toggle();
                      },
                      child: Icon(
                          controller.showPassword.value
                              ? CupertinoIcons.eye_slash
                              : CupertinoIcons.eye,
                          color: AppColor.black.withOpacity(0.8)),
                    ),
                    placeholder: 'Nhập mật khẩu mới',
                    fontSize: 15,
                  ),
                )),
            Neumorphic(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                style: NeumorphicStyle(
                  color: AppColor.primaryColor,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
                  depth: -3,
                  shadowLightColorEmboss: AppColor.darkGray.withOpacity(0.4),
                ),
                child: Obx(
                  () => InputField(
                    password: !controller.showConfirmPassword.value,
                    controller: controller.confirmPasswordController,
                    color: AppColor.black,
                    prefix: const Icon(CupertinoIcons.lock_rotation_open),
                    suffix: GestureDetector(
                      onTap: () {
                        controller.showConfirmPassword.toggle();
                      },
                      child: Icon(
                          controller.showConfirmPassword.value
                              ? CupertinoIcons.eye_slash
                              : CupertinoIcons.eye,
                          color: AppColor.black.withOpacity(0.8)),
                    ),
                    placeholder: 'Nhập lại mật khẩu mới',
                    fontSize: 15,
                  ),
                )),
            NeumorphicButton(
              margin: const EdgeInsets.only(left: 50, right: 50, top: 50),
              style: NeumorphicStyle(
                  color: AppColor.primaryColor,
                  depth: 4,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                  shadowLightColor: AppColor.white,
                  intensity: 100,
                  lightSource: LightSource.topLeft),
              onPressed: () async {
                AppFocus.unFocus(context);
                controller.changePassword();
              },
              child: Center(
                child: Text(
                  'Đổi mật khẩu',
                  style: TextStyle(
                      color: AppColor.darkGray,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.5),
                ),
              ),
            ),
          ],
        ));
  }
}
