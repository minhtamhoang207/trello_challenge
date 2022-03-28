import 'package:flutter/gestures.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:trello_challenge/modules/sign_up/sign_up_controller.dart';
import 'package:trello_challenge/shared/constants/colors.dart';
import 'package:trello_challenge/shared/utils/common_widget.dart';
import 'package:trello_challenge/shared/widgets/input_field.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: AppColor.primaryColor,
        body: _buildWidget(context),
      ),
    );
  }

  Widget _buildWidget(BuildContext context) {
    return ListView(
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
                shadowLightColor: AppColor.darkGray.withOpacity(0.3),
              ),
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
              'Đăng ký',
              style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: AppColor.darkLiver),
            ),
          ),
        ),
        Neumorphic(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            style: NeumorphicStyle(
              color: AppColor.primaryColor,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
              depth: -3,
              shadowLightColorEmboss: AppColor.darkGray.withOpacity(0.4),
            ),
            child: InputField(
              //  Scrollable.ensureVisible(dataKey.currentContext!, alignment: 0.8);
              controller: controller.emailController,
              color: AppColor.black,
              prefix: const Icon(Icons.alternate_email),
              placeholder: 'Email',
              fontSize: 15,
            )),
        Neumorphic(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            style: NeumorphicStyle(
              color: AppColor.primaryColor,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
              depth: -3,
              shadowLightColorEmboss: AppColor.darkGray.withOpacity(0.4),
            ),
            child: InputField(
              controller: controller.userNameController,
              color: AppColor.black,
              prefix: const Icon(Icons.person),
              placeholder: 'Tên đăng nhập',
              fontSize: 15,
            )),
        Neumorphic(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            style: NeumorphicStyle(
              color: AppColor.primaryColor,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
              depth: -3,
              shadowLightColorEmboss: AppColor.darkGray.withOpacity(0.4),
            ),
            child: InputField(
              //  Scrollable.ensureVisible(dataKey.currentContext!, alignment: 0.8);
              controller: controller.passwordController,
              color: AppColor.black,
              prefix: const Icon(Icons.lock),
              placeholder: 'Mật khẩu',
              password: true,
              fontSize: 15,
            )),
        Neumorphic(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            style: NeumorphicStyle(
              color: AppColor.primaryColor,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
              depth: -3,
              shadowLightColorEmboss: AppColor.darkGray.withOpacity(0.4),
            ),
            child: InputField(
              controller: controller.reEnterPasswordController,
              color: AppColor.black,
              prefix: const Icon(Icons.lock),
              password: true,
              placeholder: 'Nhập lại mật khẩu',
              fontSize: 15,
            )),
        NeumorphicButton(
          margin: const EdgeInsets.only(left: 50, right: 50, top: 50),
          style: NeumorphicStyle(
            color: AppColor.primaryColor,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
            depth: 4,
            shadowLightColor: AppColor.darkGray.withOpacity(0.3),
          ),
          onPressed: () async {
            await controller.register();
          },
          child: Center(
            child: Text(
              'Đăng ký',
              style: TextStyle(
                  color: AppColor.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.5),
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
                  TextSpan(text: 'Đã có tài khoản? ', children: <InlineSpan>[
                    TextSpan(
                      text: 'Đăng nhập',
                      recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColor.darkLiver),
                    )
                  ])),
            ),
          ),
        ),
      ],
    );
  }
}
