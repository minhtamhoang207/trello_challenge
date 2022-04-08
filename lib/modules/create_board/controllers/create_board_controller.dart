import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:trello_challenge/data/model/request/create_board_request.dart';
import 'package:trello_challenge/modules/project_detail/controllers/project_detail_controller.dart';
import 'package:trello_challenge/shared/utils/common_widget.dart';

import '../../../data/api/repository/project_repository.dart';

class CreateBoardController extends GetxController {

  final ProjectRepository projectRepository;
  CreateBoardController({required this.projectRepository});

  TextEditingController boardNameController = TextEditingController();
  TextEditingController expireDateController = TextEditingController();
  DateTime? expireDate;


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {}



  void createBoards() async {
    CommonWidget.showLoading();
    try {
      await projectRepository.createBoard(data: CreateBoardRequest(
          boardName: boardNameController.text,
          expireDate: expireDate??DateTime.now(),
          projectID: Get.find<ProjectDetailController>().argument.projectId
      ));
      CommonWidget.hideLoading();
      Get.back();
      Get.find<ProjectDetailController>().getBoards();
    } catch (e) {
      CommonWidget.hideLoading();
    }
  }
}
