import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:trello_challenge/data/model/params/board_detail_params.dart';
import 'package:trello_challenge/data/model/request/create_board_request.dart';
import 'package:trello_challenge/modules/project_detail/controllers/project_detail_controller.dart';
import 'package:trello_challenge/shared/utils/common_widget.dart';
import '../../../data/api/repository/project_repository.dart';


class CreateBoardController extends GetxController {

  final ProjectRepository projectRepository;
  CreateBoardController({required this.projectRepository});

  final List<String> listImage =  [
    'https://i.ibb.co/XkznH9K/85-original-png-1000h.png',
    'https://i.ibb.co/k8SxBMy/kitty-simple-cat-minimalism-wallpaper-thumb.jpg',
    'https://i.ibb.co/xMHtrdJ/photo-1653233871814-7e7b75102e3c.jpg',
    'https://i.ibb.co/vPSqz1n/Windows-Backgrounds-Mountain-Stock-Photos-Backgroundnature.jpg',
  ];

  final List<String> listColor = [
    '#0079bf',
    '#d29034',
    '#519839',
    '#b04632',
    '#89609e',
    '#cd5a91',
    '#4bbf6b',
    '#00aecc',
    '#838c91',
  ];

  RxString background = RxString('#0079bf');

  TextEditingController boardNameController = TextEditingController();
  bool create = true;
  BoardDetailParams? argument;
  @override
  void onInit() {
    if(Get.arguments != null){
      argument = Get.arguments;
      create = false;
      boardNameController.text = argument!.boardName;
      background.value = argument!.background;
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
          projectID: Get.find<ProjectDetailController>().argument.projectId,
          background: background.value
      ));
      CommonWidget.hideLoading();
      Get.back();
      Get.find<ProjectDetailController>().getBoards();
    } catch (e) {
      CommonWidget.toast(e.toString());
      CommonWidget.hideLoading();
    }
  }

  void editBoards() async {
    CommonWidget.showLoading();
    try {
      await projectRepository.updateBoard(data: CreateBoardRequest(
          boardName: boardNameController.text,
          background: background.value,
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
