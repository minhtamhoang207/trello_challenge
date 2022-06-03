import 'package:get/get.dart';
import 'package:trello_challenge/data/model/params/project_detail_params.dart';
import 'package:trello_challenge/data/model/response/board_response.dart';
import 'package:trello_challenge/modules/workspace/controllers/workspace_controller.dart';

import '../../../data/api/repository/project_repository.dart';
import '../../../shared/utils/common_widget.dart';

class ProjectDetailController extends GetxController with StateMixin<BoardResponse>{

  final ProjectRepository projectRepository;
  ProjectDetailController({required this.projectRepository});

  late ProjectDetailParams argument;
  @override
  void onInit() {
    argument = Get.arguments;
    getBoards();
    super.onInit();
  }


  void getBoards() async {
    CommonWidget.showLoading();
    try {
      final response = await projectRepository.getBoards(projectID: argument.projectId);
      change(response, status: RxStatus.success());
      CommonWidget.hideLoading();
    } catch (e) {
      CommonWidget.hideLoading();
      change(BoardResponse(data: []), status: RxStatus.error(e.toString()));
    }
  }

  void leaveProject() async {
    CommonWidget.showLoading();
    try {
      await projectRepository.leaveProject(projectID: argument.projectId);
      Get.back();
      CommonWidget.hideLoading();
      Get.find<WorkspaceController>().getProjects();
    } catch (e) {
      CommonWidget.hideLoading();
      change(BoardResponse(data: []), status: RxStatus.error(e.toString()));
    }
  }


  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
