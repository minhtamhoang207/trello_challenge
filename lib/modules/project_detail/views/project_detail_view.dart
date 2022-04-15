import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trello_challenge/routes/app_pages.dart';
import 'package:trello_challenge/shared/widgets/empty_list.dart';

import '../../../data/model/params/board_detail_params.dart';
import '../../../gen/assets.gen.dart';
import '../../../shared/constants/colors.dart';
import '../controllers/project_detail_controller.dart';

class ProjectDetailView extends GetView<ProjectDetailController> {
  const ProjectDetailView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: AppColor.appBlue,
              title: Text(controller.argument.projectName),
              automaticallyImplyLeading: true,
              actions: [
                IconButton(
                  onPressed:(){
                    Get.toNamed(Routes.CREATE_BOARD);
                  },
                  icon: const Icon(Icons.add_outlined),
                  tooltip: 'Thêm bảng mới',
                ),
              ],
            ),
            body: controller.obx(
                  (state) => RefreshIndicator(
                  onRefresh: () async {
                    controller.getBoards();
                  },
                  child: state!.data.isEmpty?
                      const EmptyList(message: 'Chưa có bảng nào được tạo'):
                  GridView.builder(
                    itemCount: state.data.length,
                    padding: const EdgeInsets.all(20),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 6/4.5,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10
                    ),
                    itemBuilder: (BuildContext context, int index){
                      return GestureDetector(
                        onTap: (){
                          Get.toNamed(Routes.BOARD_DETAIL, arguments: BoardDetailParams(
                            backGround: state.data[index].background!,
                            boardID: state.data[index].id,
                            boardName: state.data[index].name!,
                            expireDate: state.data[index].closedAt,
                          ));
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: state.data[index].background!.isEmpty?
                              BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColor.appBlue.withOpacity(0.8)
                              ):
                              BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        '${state.data[index].background}',
                                      )
                                  )
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)
                                    )
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                          '${state.data[index].name}',
                                          maxLines: 1, overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: AppColor.white
                                          ),
                                        )
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )
              ),
              onLoading: const SizedBox(),
              onEmpty: const Text('No data found'),
              onError: (error) => RefreshIndicator(
                onRefresh: () async {
                  controller.getBoards();
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
            )
        )
    );
  }
}