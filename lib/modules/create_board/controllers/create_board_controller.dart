import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:trello_challenge/data/model/params/board_detail_params.dart';
import 'package:trello_challenge/data/model/request/create_board_request.dart';
import 'package:trello_challenge/modules/project_detail/controllers/project_detail_controller.dart';
import 'package:trello_challenge/shared/utils/common_widget.dart';
import 'package:trello_challenge/shared/utils/date_time.dart';

import '../../../data/api/repository/project_repository.dart';

class CreateBoardController extends GetxController {

  final ProjectRepository projectRepository;
  CreateBoardController({required this.projectRepository});

  TextEditingController boardNameController = TextEditingController();
  TextEditingController expireDateController = TextEditingController();
  DateTime? expireDate;
  bool create = true;
  BoardDetailParams? argument;
  @override
  void onInit() {
    if(Get.arguments != null){
      argument = Get.arguments;
      create = false;
      boardNameController.text = argument!.boardName;
      expireDateController.text = AppDateTime.formatDate(argument!.expireDate!.toIso8601String());
    }
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

  void editBoards() async {
    CommonWidget.showLoading();
    try {
      await projectRepository.updateBoard(data: CreateBoardRequest(
          boardName: boardNameController.text,
          expireDate: expireDate??DateTime.now(),
          projectID: Get.find<ProjectDetailController>().argument.projectId
      ), boardID: argument!.boardID);
      CommonWidget.hideLoading();
      Get.back();
      Get.find<ProjectDetailController>().getBoards();
    } catch (e) {
      CommonWidget.hideLoading();
    }
  }
}
