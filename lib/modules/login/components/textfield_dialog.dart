import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:trello_challenge/modules/login/login_controller.dart';
import 'package:trello_challenge/shared/constants/colors.dart';
import 'package:trello_challenge/shared/enums/verify_email_type.dart';
import 'package:trello_challenge/shared/utils/focus.dart';
import 'package:trello_challenge/shared/widgets/input_field.dart';

class TextFieldDialog extends GetView<LoginController> {
  final VerifyEmailType verifyEmailType;
  const TextFieldDialog({Key? key, required this.verifyEmailType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      backgroundColor: Colors.transparent,
      child: Container(
          width: Get.width / 1.2,
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 50),
          decoration: BoxDecoration(
              color: AppColor.primaryColor, borderRadius: BorderRadius.circular(10)
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 23, top: 20),
                  child: Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: (){},
                      child: Text(
                        'Vui lòng nhập email bạn đã đăng ký',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColor.darkLiver),
                      ),
                    ),
                  ),
                ),
                Neumorphic(
                    margin: const EdgeInsets.only(top: 50, bottom: 30),
                    style: NeumorphicStyle(
                      color: AppColor.primaryColor,
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
                      depth: -3,
                      shadowLightColorEmboss: AppColor.darkGray.withOpacity(0.4),
                    ),
                    child: InputField(
                      controller: controller.emailController,
                      color: AppColor.black,
                      prefix: const Icon(CupertinoIcons.at),
                      placeholder: 'Nhập email của bạn',
                      fontSize: 15,
                    )),
                NeumorphicButton(
                  margin: const EdgeInsets.only(bottom: 20),
                  style: NeumorphicStyle(
                      color: AppColor.primaryColor,
                      depth: 4,
                      shadowLightColor: AppColor.white,
                      intensity: 100,
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                      lightSource: LightSource.topLeft),
                  onPressed: () async {
                    AppFocus.unFocus(context);
                    await controller.verifyEmail(verifyEmailType);
                  },
                  child: Center(
                    child: Text(
                      'Xác nhận',
                      style: TextStyle(
                          color: AppColor.darkLiver,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.5),
                    ),
                  ),
                ),
                NeumorphicButton(
                  margin: const EdgeInsets.only(bottom: 0),
                  style: NeumorphicStyle(
                      color: AppColor.primaryColor,
                      depth: 4,
                      shadowLightColor: AppColor.white,
                      intensity: 100,
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                      lightSource: LightSource.topLeft),
                  onPressed:(){
                    controller.emailController.clear();
                    Get.back();
                  },
                  child: Center(
                    child: Text(
                      'Trở lại',
                      style: TextStyle(
                          color: AppColor.darkLiver,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.5),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}