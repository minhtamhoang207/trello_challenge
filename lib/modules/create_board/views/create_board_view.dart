import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:trello_challenge/shared/utils/color_extension.dart';
import 'package:trello_challenge/shared/utils/date_time.dart';
import 'package:trello_challenge/shared/widgets/custom_image_view.dart';

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
          child: Obx(() =>
              ListView(
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
                    padding: const EdgeInsets.only(left: 23, top: 20, bottom: 15),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Phông nền:',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColor.darkLiver),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 100,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(left: 10),
                        itemCount: controller.listImage.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index){
                          return Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: (){
                                    controller.background.value = controller.listImage[index];
                                  },
                                  child: AspectRatio(
                                    aspectRatio: 16/9,
                                    child: CachedNetworkImage(
                                      imageUrl: controller.listImage[index],
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                          Center(
                                            child: SizedBox(
                                                height: 15,
                                                width: 15,
                                                child: CircularProgressIndicator(value: downloadProgress.progress)),
                                          ),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: controller.background.value == controller.listImage[index],
                                child: AspectRatio(
                                    aspectRatio: 16/9,
                                    child: Center(
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.7),
                                            shape: BoxShape.circle
                                        ),
                                        child: const Icon(Icons.check, color: Colors.white),
                                      ),
                                    )
                                ),
                              ),
                            ],
                          );
                        },
                      )
                  ),
                  const Gap(15),
                  Center(
                    child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: List.generate(controller.listColor.length, (index) =>
                            Stack(
                              children: [
                                InkWell(
                                  onTap:(){
                                    controller.background.value = controller.listColor[index];
                                  },
                                  child: Container(
                                    height: Get.width/9,
                                    width: Get.width/9,
                                    //margin: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: HexColor(controller.listColor[index]),
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: controller.background.value == controller.listColor[index],
                                  child: SizedBox(
                                    height: Get.width/9,
                                    width: Get.width/9,
                                    child: Center(
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.7),
                                            shape: BoxShape.circle
                                        ),
                                        child: const Icon(Icons.check, color: Colors.white, size: 13),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                        )
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
              ))
        ));
  }
}
