import 'package:get/get.dart';
import 'package:trello_challenge/routes/app_pages.dart';

import '../../../data/api/repository/project_repository.dart';
import '../../../shared/utils/common_widget.dart';
import '../../project_detail/controllers/project_detail_controller.dart';

class BoardDetailController extends GetxController {

  final ProjectRepository projectRepository;
  BoardDetailController({required this.projectRepository});

  final background = Get.arguments['background'];
  final boardID = Get.arguments['boardID'];

  @override
  void onInit() {
    super.onInit();
  }

  void deleteBoard() async {
    CommonWidget.showLoading();
    try {
      await projectRepository.deleteBoard(boardID: boardID);
      CommonWidget.hideLoading();
      Get.back();
      Get.find<ProjectDetailController>().getBoards();
    } catch (e) {
      CommonWidget.hideLoading();
    }
  }

  @override
  void onClose() {}
}
