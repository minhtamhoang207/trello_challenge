import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trello_challenge/modules/profile/components/profile_button.dart';
import 'package:trello_challenge/modules/profile/profile_controller.dart';
import 'package:trello_challenge/routes/app_pages.dart';
import 'package:trello_challenge/shared/constants/colors.dart';
import 'package:trello_challenge/shared/constants/storage.dart';
import 'package:trello_challenge/shared/utils/common_widget.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: controller.obx(
        (state)=>RefreshIndicator(
          onRefresh: () async {
            controller.loadUser();
          },
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 20, bottom: 8),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: NeumorphicButton(
                    style: NeumorphicStyle(
                        color: AppColor.primaryColor,
                        boxShape: const NeumorphicBoxShape.circle(),
                        depth: 3,
                        shadowLightColor: AppColor.white,
                        intensity: 20,
                        lightSource: LightSource.topLeft),
                    onPressed: () {

                    },
                    child: const Icon(Icons.edit_outlined),
                  ),
                ),
              ),
              Center(
                child: NeumorphicButton(
                    style: NeumorphicStyle(
                        color: AppColor.primaryColor,
                        boxShape: const NeumorphicBoxShape.circle(),
                        depth: 4,
                        shadowLightColor: AppColor.white,
                        intensity: 100,
                        lightSource: LightSource.topLeft),
                    onPressed: () {},
                    child: const SizedBox(
                      height: 100,
                      width: 100,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://i.guim.co.uk/img/media/26392d05302e02f7bf4eb143bb84c80'
                              '97d09144b/446_167_3683_2210/master/3683.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=49ed3252c0b2ffb49cf8b508892e452d',
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 23, top: 10, left: 23),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    controller.name.value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColor.darkLiver),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 23, top: 8, left: 23),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '( Tom paid )',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                        color: AppColor.darkLiver.withOpacity(0.8)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 23, top: 20, left: 23),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '" Yêu màu hồng ghét sự giả dối"',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 13.5,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                        color: AppColor.darkLiver),
                  ),
                ),
              ),
              const Divider(thickness: 2),

              ProfileButton(
                leadingIcon: const Icon(CupertinoIcons.at),
                title: 'minhtamhoang207@gmail.com',
                showRightArrow: true,
                onPressed: (){
                  Clipboard.setData(const ClipboardData(text: 'minhtamhoang207@gmail.com')).then((_){
                    CommonWidget.toast('Đã copy email vào bộ nhớ tạm');
                  });
                },
              ),
              ProfileButton(
                leadingIcon: const Icon(CupertinoIcons.square_list),
                title: 'Công việc của tôi',
                showRightArrow: true,
                onPressed: (){},
              ),
              ProfileButton(
                leadingIcon: const Icon(CupertinoIcons.list_bullet),
                title: 'Hoạt động',
                showRightArrow: true,
                onPressed: (){},
              ),
              ProfileButton(
                leadingIcon: const Icon(CupertinoIcons.lock_rotation),
                title: 'Đổi mật khẩu',
                showRightArrow: true,
                onPressed: (){},
              ),
              ProfileButton(
                leadingIcon: const Icon(Icons.logout_outlined),
                title: 'Đăng xuất',
                showRightArrow: false,
                onPressed: () => controller.logout(),
              ),
            ],
          ),
        ),
        onLoading: const Center(child: CircularProgressIndicator()),
        onEmpty: const Text('No data found'),
        onError: (error)=>Text(error.toString()),
      )
    ));
  }
}
