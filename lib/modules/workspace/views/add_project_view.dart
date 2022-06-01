import 'package:flutter/cupertino.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:trello_challenge/modules/workspace/controllers/workspace_controller.dart';
import 'package:trello_challenge/shared/utils/focus.dart';
import 'package:trello_challenge/shared/widgets/input_field.dart';

import '../../../shared/constants/colors.dart';

class AddProjectView extends GetView<WorkspaceController> {
  const AddProjectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.primaryColor,
        body: KeyboardDismissOnTap(
          child: ListView(
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
                    'Thêm dự án mới',
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: AppColor.darkLiver),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 23, top: 40),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Tên dự án: ',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColor.darkLiver),
                  ),
                ),
              ),
              Neumorphic(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 30, top: 10),
                  style: NeumorphicStyle(
                    color: AppColor.primaryColor,
                    boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
                    depth: -3,
                    shadowLightColorEmboss: AppColor.darkGray.withOpacity(0.4),
                  ),
                  child: InputField(
                    maxLength: 45,
                    controller: controller.nameController,
                    color: AppColor.black,
                    prefix:
                    const Icon(CupertinoIcons.rectangle_stack_person_crop),
                    placeholder: 'Nhập tên dự án',
                    fontSize: 15,
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 23, top: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Thêm mô tả về dự án:',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColor.darkLiver),
                  ),
                ),
              ),
              Neumorphic(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 30, top: 8),
                  style: NeumorphicStyle(
                    color: AppColor.primaryColor,
                    boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
                    depth: -3,
                    shadowLightColorEmboss: AppColor.darkGray.withOpacity(0.4),
                  ),
                  child: InputField(
                    controller: controller.descriptionController,
                    color: AppColor.black,
                    maxLength: 225,
                    maxLine: null,
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    prefix: const Icon(CupertinoIcons.today_fill),
                    placeholder: 'Thêm mô tả ...',
                    fontSize: 15,
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 23, top: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Loại dự án',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColor.darkLiver),
                  ),
                ),
              ),
              Neumorphic(
                  margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 8),
                  style: NeumorphicStyle(
                    color: AppColor.primaryColor,
                    boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
                    depth: -3,
                    shadowLightColorEmboss: AppColor.darkGray.withOpacity(0.4),
                  ),
                  child: InputField(
                    controller: controller.typeController,
                    color: AppColor.black,
                    maxLength: 225,
                    maxLine: null,
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    prefix: const Icon(CupertinoIcons.selection_pin_in_out),
                    placeholder: 'Loại dự án ...',
                    fontSize: 15,
                  )),
              NeumorphicButton(
                margin: const EdgeInsets.only(left: 50, right: 50, top: 30, bottom: 30),
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
                  controller.edit.value?controller.editProject():controller.createProject();
                },
                child: Center(
                  child: Text(
                    controller.edit.value?'Chỉnh sửa thông tin':'Tạo dự án',
                    style: TextStyle(
                        color: AppColor.darkGray,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.5),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
