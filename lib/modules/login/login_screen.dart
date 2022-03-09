import 'package:flutter/gestures.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:trello_challenge/gen/assets.gen.dart';
import 'package:trello_challenge/modules/login/login_controller.dart';
import 'package:trello_challenge/routes/app_pages.dart';
import 'package:trello_challenge/shared/constants/colors.dart';
import 'package:trello_challenge/shared/utils/common_widget.dart';
import 'package:trello_challenge/shared/widgets/input_field.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: AppColor.authColor,
        body: _buildWidget(context),
      ),
    );
  }

  Widget _buildWidget(BuildContext context) {
    return ListView(
      children: [
        Image.asset(
          Assets.images.imgLogin.path,
          height: Get.height / 3.3,
          width: Get.width,
          fit: BoxFit.fill,
        ),
        InkWell(
          onTap: () {
            //Scrollable.ensureVisible(dataKey.currentContext!);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 23, top: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Đăng nhập',
                style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor),
              ),
            ),
          ),
        ),
        Neumorphic(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            style: NeumorphicStyle(
              color: AppColor.authColor,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
              depth: -3,
              shadowLightColorEmboss: AppColor.darkGray.withOpacity(0.4),
            ),
            child: InputField(
              //  Scrollable.ensureVisible(dataKey.currentContext!, alignment: 0.8);
              controller: controller.userNameController,
              color: AppColor.black,
              prefix: const Icon(Icons.person),
              placeholder: 'Tên đăng nhập',
              fontSize: 15,
            )),
        Neumorphic(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            style: NeumorphicStyle(
              color: AppColor.authColor,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
              depth: -3,
              shadowLightColorEmboss: AppColor.darkGray.withOpacity(0.4),
            ),
            child: InputField(
              controller: controller.passwordController,
              color: AppColor.black,
              prefix: const Icon(Icons.lock),
              password: true,
              placeholder: 'Mật khẩu',
              fontSize: 15,
            )),
        Padding(
          padding: const EdgeInsets.only(right: 23, top: 20),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Quên mật khẩu?',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primaryColor),
            ),
          ),
        ),
        NeumorphicButton(
          margin: const EdgeInsets.only(left: 50, right: 50, top: 30),
          style: NeumorphicStyle(
            color: AppColor.authColor,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
            depth: 4,
            shadowLightColor: AppColor.darkGray.withOpacity(0.3),
          ),
          onPressed: () async {
            CommonWidget.showLoading();
            await Future.delayed(const Duration(seconds: 3));
            Get.toNamed(Routes.home);
            CommonWidget.hideLoading();
          },
          child: Center(
            child: Text(
              'Đăng nhập',
              style: TextStyle(
                  color: AppColor.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
          ),
        ),
        const Gap(130),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: SizedBox(
            height: 40,
            child: Align(
              alignment: Alignment.center,
              child: Text.rich(
                  TextSpan(text: 'Chưa có tài khoản? ', children: <InlineSpan>[
                TextSpan(
                  text: 'Đăng kí ngay',
                  recognizer: TapGestureRecognizer()..onTap = () => Get.toNamed(Routes.singUp),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primaryColor),
                )
              ])),
            ),
          ),
        ),
      ],
    );
  }
}
