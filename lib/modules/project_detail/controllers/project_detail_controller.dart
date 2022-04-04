import 'package:get/get.dart';
import 'package:trello_challenge/data/model/response/board_response.dart';

import '../../../data/api/repository/project_repository.dart';
import '../../../shared/utils/common_widget.dart';

class ProjectDetailController extends GetxController with StateMixin<BoardResponse>{

  final ProjectRepository projectRepository;
  ProjectDetailController({required this.projectRepository});

  late final String projectID;
  @override
  void onInit() {
    projectID = Get.arguments;
    getBoards();
    super.onInit();
  }


  void getBoards() async {
    CommonWidget.showLoading();
    try {
      final response = await projectRepository.getBoards(projectID: projectID);
      change(response, status: RxStatus.success());
      CommonWidget.hideLoading();
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
