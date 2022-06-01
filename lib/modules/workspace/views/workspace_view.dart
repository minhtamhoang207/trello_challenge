import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trello_challenge/data/model/params/project_detail_params.dart';
import 'package:trello_challenge/routes/app_pages.dart';
import 'package:trello_challenge/shared/widgets/empty_list.dart';

import '../../../gen/assets.gen.dart';
import '../../../shared/constants/colors.dart';
import '../controllers/workspace_controller.dart';

class WorkspaceView extends GetView<WorkspaceController> {
  const WorkspaceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColor.white,
            appBar: AppBar(
              backgroundColor: AppColor.appBlue,
              title: const Text('Workspace'),
              actions: [
                IconButton(
                    onPressed:(){
                      controller.initCreateProject(name: '', description: '', type: '');
                      Get.toNamed(Routes.ADD_PROJECT);
                    },
                    icon: const Icon(Icons.add_outlined),
                    tooltip: 'Thêm project mới',
                ),
              ],
            ),
            body: controller.obx(
                  (state) => RefreshIndicator(
                onRefresh: () async {
                  controller.getProjects();
                },
                child: state!.data.isEmpty?
                    const EmptyList(message: 'Chưa có dự án nào được tạo'):
                    ListView.separated(
                  padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 20
                  ),
                  itemCount: state.data.length,
                  separatorBuilder: (context, index) => const Gap(15),
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: InkWell(
                        onTap: (){
                          Get.toNamed(Routes.PROJECT_DETAIL, arguments: ProjectDetailParams(projectId:  state.data[index].id, projectName:  state.data[index].name??''));
                        },
                        borderRadius: BorderRadius.circular(10),
                        splashColor: AppColor.appBlue.withOpacity(0.1),
                        child: Ink (
                            padding: const EdgeInsets.only(left: 10, right: 0, top: 0, bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Gap(20),
                                      Text(
                                        '${state.data[index].name}',
                                        style: TextStyle(
                                            color: AppColor.darkLiver,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15
                                        ),
                                      ),
                                      const Gap(8),
                                      Text(
                                        '${state.data[index].description}',
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: AppColor.darkLiver,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 13
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 20),
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                        decoration: BoxDecoration(
                                          color: Colors.lightBlue.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(8)
                                        ),
                                        child: Text(
                                          '${state.data[index].type}'
                                        ),
                                      ),
                                      const Gap(12),
                                      Wrap(
                                          children: List.generate(3, (i) =>
                                          i == 0?
                                          Transform(
                                            transform: Matrix4.translationValues(0, 0, 0),
                                            child: CachedNetworkImage(
                                              imageUrl: state.data[index].members[0].user.avatar??'',
                                              errorWidget: (context, url, error) => Icon(
                                                  CupertinoIcons.person_circle_fill,
                                                  size: 25,
                                                  color: AppColor.darkGray),
                                              placeholder: (context, url) => Icon(
                                                  CupertinoIcons.person_circle_fill,
                                                  size: 25,
                                                  color: AppColor.darkGray),
                                              imageBuilder: (context, imageProvider) => SizedBox(
                                                  height: 25,
                                                  width: 25,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: AppColor.white, width: 2),
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                            fit: BoxFit.fill,
                                                            image: imageProvider
                                                        )
                                                    ),
                                                  )
                                              ),
                                            ),
                                          ):
                                          Transform(
                                            transform: Matrix4.translationValues(i * -5, 0, 0),
                                            child: CachedNetworkImage(
                                              imageUrl: state.data[index].members[0].user.avatar??'',
                                              errorWidget: (context, url, error) =>  Transform(
                                                transform: Matrix4.translationValues(i * -5, 0, 0),
                                                child: Icon(
                                                    CupertinoIcons.person_circle_fill,
                                                    size: 25,
                                                    color: AppColor.darkGray),
                                              ),
                                              placeholder: (context, url) =>
                                                  Transform(
                                                    transform: Matrix4.translationValues(i * -5, 0, 0),
                                                    child: Icon(
                                                        CupertinoIcons.person_circle_fill,
                                                        size: 25,
                                                        color: AppColor.darkGray),
                                                  ),
                                              imageBuilder: (context, imageProvider) => SizedBox(
                                                  height: 25,
                                                  width: 25,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: AppColor.white, width: 2),
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                            fit: BoxFit.fill,
                                                            image: imageProvider
                                                        )
                                                    ),
                                                  )
                                              ),
                                            ),
                                          ),
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                                const Gap(20),
                                PopupMenuButton<String>(
                                  icon: SvgPicture.asset(
                                    Assets.svgs.icDotMenu,
                                    height: 12,
                                    width: 12,
                                  ),
                                  onSelected: (String result) {
                                    switch (result) {
                                      case 'delete':
                                        controller.deleteProject(state.data[index].id);
                                        break;
                                      case 'edit':
                                        controller.initCreateProject(
                                            name: state.data[index].name??'',
                                            description: state.data[index].description??'',
                                            type: state.data[index].type??'',
                                            isEdit: true,
                                            projectID: state.data[index].id
                                        );
                                        Get.toNamed(Routes.ADD_PROJECT);
                                        break;
                                      default:
                                    }
                                  },
                                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                    PopupMenuItem<String>(
                                        value: 'edit',
                                        child: Row(
                                          children: const [
                                            Icon(Icons.edit, size: 15),
                                            Gap(15),
                                            Text('Chỉnh sửa dự án'),
                                          ],
                                        )
                                    ),
                                    PopupMenuItem<String>(
                                        value: 'delete',
                                        child: Row(
                                          children: [
                                            Icon(CupertinoIcons.delete, size: 15, color: AppColor.red),
                                            const Gap(15),
                                            const Text('Xóa dự án'),
                                          ],
                                        )
                                    ),
                                  ],
                                ),
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
            ),
        )
    );
  }
}
