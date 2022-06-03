import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:trello_challenge/data/api/repository/board_repository.dart';
import 'package:trello_challenge/data/model/params/board_detail_params.dart';
import 'package:trello_challenge/data/model/request/update_task_request.dart';
import 'package:trello_challenge/data/model/response/board_column_response.dart';
import 'package:trello_challenge/shared/enums/dialog_type.dart';

import '../../../data/api/repository/project_repository.dart';
import '../../../shared/utils/common_widget.dart';
import '../../../shared/widgets/custom_dialog.dart';
import '../../project_detail/controllers/project_detail_controller.dart';

class BoardDetailController extends GetxController {

  final ProjectRepository projectRepository;
  final BoardRepository boardRepository;
  final ImagePicker _imagePicker = ImagePicker();

  BoardDetailController({required this.projectRepository, required this.boardRepository});
  List<TextEditingController> checkListControllers = [];
  final BoardDetailParams arguments = Get.arguments;
  IO.Socket socket = Get.find();


  @override
  void onInit() async {
   // await boardRepository.getBoardColumn(boardID: arguments.boardID);
   //  await boardRepository.getBoardColumn(boardID: '6283cf98b1a3e6f7ae54f5a9');
    super.onInit();
  }

  List<BoardListObject> listData = [];

  Future<void> getColumn() async {
    final res = await boardRepository.getBoardColumn(boardID: arguments.boardID);
    // final res = await boardRepository.getBoardColumn(boardID: '6283cf98b1a3e6f7ae54f5a9');
    res.data.sort((a,b) => a.seqNo.compareTo(b.seqNo));
    for(int i = 0; i < res.data.length; i ++){
      res.data[i].tasks.sort((a, b) => a.seqNo.compareTo(b.seqNo));
    }
    //someObjects.sort((a, b) => a.someProperty.compareTo(b.someProperty));
    listData = res.data;
  }

  Future<void> addColumn({required String columnName, required int seqNo}) async {
    try{
      await boardRepository.addBoardColumn(
          boardID: arguments.boardID,
          columnName: columnName,
          seqNo: seqNo
      );
    } catch (e){
      CommonWidget.toast(e.toString());
    }
  }

  Future<void> editColumn({required String columnName, required int seqNo, required String columnID}) async {
    CommonWidget.showLoading();
    try {
      await boardRepository.editColumn(columnName: columnName, seqNo: seqNo, boardID: arguments.boardID, columnID: columnID);
      CommonWidget.hideLoading();
    } catch (e) {
      CommonWidget.toast(e.toString());
      CommonWidget.hideLoading();
    }
  }

  Future<void> deleteColumn({required String columnID}) async {
    CommonWidget.showLoading();
    try {
      await boardRepository.deleteColumn(columnID: columnID);
      CommonWidget.hideLoading();
    } catch (e) {
      CommonWidget.toast(e.toString());
      CommonWidget.hideLoading();
    }
  }

  Future<void> addTask({required String columnID, required int seqNo, required taskName}) async {
    try{
      await boardRepository.addTask(
          columnID: columnID,
          taskName: taskName,
          seqNo: seqNo
      );
    } catch (e){
      CommonWidget.toast(e.toString());
    }
  }

  Future<void> deleteTask({required String taskID}) async {
    CommonWidget.showLoading();
    try {
      await boardRepository.deleteTask(taskID: taskID);
      CommonWidget.hideLoading();
      Get.back();
      Get.find<ProjectDetailController>().getBoards();
    } catch (e) {
      CommonWidget.hideLoading();
      CommonWidget.toast(e.toString());
    }
  }

  Future<void> updateTaskImage({required String taskID}) async {
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      CommonWidget.showLoading();
      try {
        await boardRepository.updateTaskImage(file: image, taskID: taskID);
        CommonWidget.hideLoading();
        Get.back();
      } catch (e) {
        CommonWidget.hideLoading();
        Get.dialog(CustomDialog(dialogType: DialogType.failed, message: e.toString()));
      }
    }
  }

  Future<void> updateTask({required String taskID, required UpdateTaskRequest updateTaskRequest}) async {
    CommonWidget.showLoading();
    try {
      await boardRepository.updateTask(
          taskID: taskID,
          updateTaskRequest: updateTaskRequest
      );
      CommonWidget.hideLoading();
      Get.back();
    } catch (e) {
      CommonWidget.hideLoading();
      Get.dialog(CustomDialog(dialogType: DialogType.failed, message: e.toString()));
    }
  }

  Future<void> deleteTaskImage({required String taskID}) async {
    CommonWidget.showLoading();
      try {
        await boardRepository.deleteTaskImage(taskID: taskID);
        CommonWidget.hideLoading();
        Get.back();
      } catch (e) {
        CommonWidget.hideLoading();
        Get.dialog(CustomDialog(dialogType: DialogType.failed, message: e.toString()));
      }
  }




  void deleteBoard() async {
    CommonWidget.showLoading();
    try {
      await projectRepository.deleteBoard(boardID: arguments.boardID);
      CommonWidget.hideLoading();
      Get.back();
      Get.find<ProjectDetailController>().getBoards();
    } catch (e) {
      CommonWidget.hideLoading();
      CommonWidget.toast(e.toString());
    }
  }

  Future<void> moveColumn({required String columnID, required int toIndex}) async{
    CommonWidget.showLoading();
    try {
      await boardRepository.moveColumn(columnID: columnID, toIndex: toIndex);
      CommonWidget.hideLoading();
    } catch (e) {
      CommonWidget.hideLoading();
      CommonWidget.toast(e.toString());
    }
  }

  Future<void> moveTask({required String taskID, required int toSeq, required String toColumn}) async{
    CommonWidget.showLoading();
    try {
      await boardRepository.moveTask(taskID: taskID, toSeq: toSeq, toColumn: toColumn);
      CommonWidget.hideLoading();
    } catch (e) {
      CommonWidget.hideLoading();
      CommonWidget.toast(e.toString());
    }
  }

  @override
  void onClose() {}
}
