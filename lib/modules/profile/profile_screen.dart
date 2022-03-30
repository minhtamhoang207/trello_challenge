import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trello_challenge/data/model/params/update_profile_params.dart';
import 'package:trello_challenge/gen/assets.gen.dart';
import 'package:trello_challenge/modules/profile/components/profile_button.dart';
import 'package:trello_challenge/modules/profile/profile_controller.dart';
import 'package:trello_challenge/routes/app_pages.dart';
import 'package:trello_challenge/shared/constants/colors.dart';
import 'package:trello_challenge/shared/utils/common_widget.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColor.primaryColor,
            body: controller.obx(
              (state) => RefreshIndicator(
                onRefresh: () async {
                  controller.loadUser();
                },
                child: ListView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 10, top: 20, bottom: 8),
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
                          onPressed: () => Get.toNamed(Routes.UPDATE_PROFILE,
                              arguments: UpdateProfileParams(
                                nickname: state?.data?.nickname ?? '',
                                bio: state?.data?.bio ?? '',
                              )),
                          child: const Icon(Icons.edit_outlined),
                        ),
                      ),
                    ),
                    Center(
                      child: Stack(
                        children: [
                          NeumorphicButton(
                              style: NeumorphicStyle(
                                  color: AppColor.primaryColor,
                                  boxShape: const NeumorphicBoxShape.circle(),
                                  depth: 4,
                                  shadowLightColor: AppColor.white,
                                  intensity: 100,
                                  lightSource: LightSource.topLeft),
                              onPressed: () {
                                // controller.updateAvatar();
                                Get.toNamed(Routes.PHOTO_VIEW, arguments: state?.data?.avatar??'');
                              },
                              child: Hero(
                                tag: state?.data?.avatar??'',
                                child: CachedNetworkImage(
                                  imageUrl: state?.data?.avatar ?? '',
                                  errorWidget: (context, url, error) => Icon(
                                      CupertinoIcons.person,
                                      size: 100,
                                      color: AppColor.darkGray),
                                  placeholder: (context, url) => Icon(
                                      CupertinoIcons.person,
                                      size: 100,
                                      color: AppColor.darkGray),
                                  imageBuilder: (context, imageProvider) => SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: imageProvider,
                                    ),
                                  ),
                                ),
                              )
                          ),
                          Positioned(
                            bottom: 0,
                              right: 0,
                              child: NeumorphicButton(
                                style: NeumorphicStyle(
                                    color: AppColor.primaryColor,
                                    boxShape: const NeumorphicBoxShape.circle(),
                                    intensity: 10,
                                    disableDepth: true,
                                    border: const NeumorphicBorder()
                                ),
                                onPressed: ()=> controller.updateAvatar(),
                                child: Icon(CupertinoIcons.camera_rotate_fill, size: 18, color: AppColor.darkLiver),
                              ),
                          )
                        ],
                      )
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 23, top: 10, left: 23),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          state?.data?.username ?? '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColor.darkLiver),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: state!.data!.nickname!.isNotEmpty,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: 23, top: 8, left: 23),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '( ${state.data!.nickname!} )',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                                color: AppColor.darkLiver.withOpacity(0.8)),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: state.data!.bio!.isNotEmpty,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: 23, top: 20, left: 23),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '" ${state.data!.bio!} "',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 13.5,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                                color: AppColor.darkLiver),
                          ),
                        ),
                      ),
                    ),
                    const Divider(thickness: 2),
                    ProfileButton(
                      leadingIcon: const Icon(CupertinoIcons.at),
                      title: state.data?.email ?? '',
                      showRightArrow: true,
                      onPressed: () {
                        Clipboard.setData(
                                ClipboardData(text: state.data?.email ?? ''))
                            .then((_) {
                          CommonWidget.toast('Đã copy email vào bộ nhớ tạm');
                        });
                      },
                    ),
                    ProfileButton(
                      leadingIcon: const Icon(CupertinoIcons.square_list),
                      title: 'Công việc của tôi',
                      showRightArrow: true,
                      onPressed: () {},
                    ),
                    ProfileButton(
                      leadingIcon: const Icon(CupertinoIcons.list_bullet),
                      title: 'Hoạt động',
                      showRightArrow: true,
                      onPressed: () {},
                    ),
                    ProfileButton(
                        leadingIcon: const Icon(CupertinoIcons.lock_rotation),
                        title: 'Đổi mật khẩu',
                        showRightArrow: true,
                        onPressed: () => Get.toNamed(Routes.CHANGE_PASSWORD)),
                    ProfileButton(
                      leadingIcon: const Icon(Icons.logout_outlined),
                      title: 'Đăng xuất',
                      showRightArrow: false,
                      onPressed: () => controller.logout(),
                    ),
                  ],
                ),
              ),
              onLoading: const SizedBox(),
              onEmpty: const Text('No data found'),
              onError: (error) => RefreshIndicator(
                onRefresh: () async {
                  controller.loadUser();
                },
                child: ListView(
                  children: [
                    Gap(Get.height * 0.2),
                    Lottie.asset(Assets.lotties.lottieError, width: 100, height: 100),
                    const Gap(50),
                    Center(
                        child: Text(error.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColor.darkLiver,
                            fontSize: 16
                          ),
                        )
                    )
                  ],
                ),
              ),
            )));
  }
}
