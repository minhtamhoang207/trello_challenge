import 'package:flutter/cupertino.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:get/get.dart';
import 'package:trello_challenge/shared/utils/date_time.dart';

import '../../../shared/constants/colors.dart';
import '../../../shared/utils/focus.dart';
import '../../../shared/widgets/input_field.dart';
import '../controllers/create_board_controller.dart';

class CreateBoardView extends GetView<CreateBoardController> {
  const CreateBoardView({Key? key}) : super(key: key);


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
                    controller.create?
                    'Thêm bảng mới':'Chỉnh sửa thông tin bảng',
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
                    'Tên bảng: ',
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
                    controller: controller.boardNameController,
                    color: AppColor.black,
                    prefix:
                    const Icon(CupertinoIcons.rectangle_stack_person_crop),
                    placeholder: 'Nhập tên bảng',
                    fontSize: 15,
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 23, top: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Ngày hết hạn: ',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColor.darkLiver),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  AppFocus.unFocus(context);
                  final DateTime? picked  = await showDatePicker(
                    context: context,
                    initialDatePickerMode: DatePickerMode.day,
                    initialEntryMode: DatePickerEntryMode.calendar,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2099),
                  );
                  if (picked != null && picked != controller.expireDate) {
                    controller.expireDate = picked;
                    controller.expireDateController.text = AppDateTime.formatDate(picked.toIso8601String());
                  }
                },
                child: AbsorbPointer(
                  child: Neumorphic(
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
                        controller: controller.expireDateController,
                        color: AppColor.black,
                        prefix: const Icon(CupertinoIcons.calendar_today),
                        placeholder: 'Chọn ngày đóng bảng',
                        fontSize: 15,
                      )),
                ),
              ),
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
                  controller.create?
                  controller.createBoards():controller.editBoards();
                },
                child: Center(
                  child: Text(
                    controller.create?
                    'Tạo bảng':'Chỉnh sửa',
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
