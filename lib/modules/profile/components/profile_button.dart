import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gap/gap.dart';
import 'package:trello_challenge/shared/constants/colors.dart';

class ProfileButton extends StatelessWidget {
  final Widget leadingIcon;
  final String title;
  final bool showRightArrow;
  final Function()? onPressed;
  const ProfileButton({Key? key, required this.leadingIcon, required this.title, this.showRightArrow = true, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 23, top: 30, left: 23),
      child: NeumorphicButton(
        style: NeumorphicStyle(
            color: AppColor.white,
            depth: 4,
            shadowLightColor: AppColor.white,
            intensity: 100,
            lightSource: LightSource.topLeft),
        onPressed: onPressed,
        child: Row(
          children: [
            leadingIcon,
            const Gap(10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColor.darkLiver),
              ),
            ),
            const Gap(15),
            Visibility(
              visible: showRightArrow,
                child: const Icon(Icons.arrow_forward_ios_rounded, size: 15)
            )
          ],
        ),),
    );
  }
}
