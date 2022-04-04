import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trello_challenge/routes/app_pages.dart';

import '../../../gen/assets.gen.dart';
import '../../../shared/constants/colors.dart';
import '../controllers/workspace_controller.dart';

class WorkspaceView extends GetView<WorkspaceController> {
  const WorkspaceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColor.primaryColor,
            // appBar: AppBar(
            //   title: const Text('My workspace'),
            //   actions: [
            //     IconButton(
            //         onPressed:(){
            //            Get.toNamed(Routes.ADD_PROJECT);
            //         },
            //         icon: const Icon(Icons.add_outlined),
            //         tooltip: 'Thêm project mới',
            //     ),
            //   ],
            // ),
            body: controller.obx(
                  (state) => RefreshIndicator(
                onRefresh: () async {
                  controller.getProjects();
                },
                child: ListView.builder(
                  itemCount: state!.data.length,
                  itemBuilder: (context, index){
                    return InkWell(
                      onTap: (){
                        Get.toNamed(Routes.PROJECT_DETAIL, arguments: state.data[index].id);
                      },
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: index.isEven?Colors.cyan.withOpacity(0.1):Colors.deepPurpleAccent.withOpacity(0.1)
                        ),
                        child: ListTile(
                            leading: Visibility(
                                visible: state.data[index].isPrivate,
                                child: const Icon(CupertinoIcons.lock)),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${state.data[index].name}'),
                                Text('${state.data[index].description}'),
                                Text('Thành viên: ${state.data[index].members.length}'),
                                const Divider(thickness: 2)
                              ],
                            )
                        ),
                      ),
                    );
                  },
                ),
              ),
              onLoading: const SizedBox(),
              onEmpty: const Text('No data found'),
              onError: (error) => RefreshIndicator(
                onRefresh: () async {
                  controller.getProjects();
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
