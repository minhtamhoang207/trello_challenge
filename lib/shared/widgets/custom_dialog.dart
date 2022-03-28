import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:trello_challenge/gen/assets.gen.dart';
import 'package:trello_challenge/shared/constants/colors.dart';
import 'package:trello_challenge/shared/enums/dialog_type.dart';

class CustomDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final DialogType dialogType;
  final bool showBackButton;

  const CustomDialog({Key? key, this.title, this.message, required this.dialogType, this.showBackButton = false})
      : super(key: key);

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
                SvgPicture.asset(
                  dialogType == DialogType.success?
                    Assets.svgs.icSuccess:Assets.svgs.icWarning,
                  height: 35,
                  width: 35,
                ),
                const Gap(10),
                title == null
                    ? const SizedBox()
                    : Text(
                  title!,
                  maxLines: null,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                  )
                ),
                const Gap(20),
                message == null
                    ? const SizedBox()
                    : Text(
                  message!,
                  maxLines: null,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColor.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  )
                ),
                Visibility(
                  visible: showBackButton,
                  child: NeumorphicButton(
                    margin: const EdgeInsets.only(left: 30, right: 30, top: 50),
                    style: NeumorphicStyle(
                      color: AppColor.primaryColor,
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                      depth: 4,
                      shadowLightColor: AppColor.darkGray.withOpacity(0.3),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: Center(
                      child: Text(
                        'Trở lại',
                        style: TextStyle(
                            color: AppColor.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}