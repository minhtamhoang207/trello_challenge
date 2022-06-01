import 'dart:developer';

import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:trello_challenge/data/api/repository/board_repository.dart';
import 'package:trello_challenge/data/model/params/board_detail_params.dart';
import 'package:trello_challenge/data/model/response/board_column_response.dart';

import '../../../data/api/repository/project_repository.dart';
import '../../../shared/utils/common_widget.dart';
import '../../project_detail/controllers/project_detail_controller.dart';

class BoardDetailController extends GetxController {

  final ProjectRepository projectRepository;
  final BoardRepository boardRepository;
  BoardDetailController({required this.projectRepository, required this.boardRepository});
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
    // for(int i = 0; i < res.data.length; i ++){
    //   res.data[i].tasks.sort((a, b) => a.seqNo.compareTo(b.seqNo));
    // }
    //someObjects.sort((a, b) => a.someProperty.compareTo(b.someProperty));
    listData = res.data;
  }

  Future<void> addColumn({required String columnName, required int seqNo}) async {
    await boardRepository.addBoardColumn(
        boardID: arguments.boardID,
        columnName: columnName,
        seqNo: seqNo
    );
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
    await boardRepository.addTask(
        columnID: columnID,
        taskName: taskName,
        seqNo: seqNo
    );
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
    }
  }

  Future<void> moveColumn({required String columnID, required int toIndex}) async{
    CommonWidget.showLoading();
    try {
      await boardRepository.moveColumn(columnID: columnID, toIndex: toIndex);
      CommonWidget.hideLoading();
    } catch (e) {
      CommonWidget.hideLoading();
    }
  }

  Future<void> moveTask({required String taskID, required int toSeq, required String toColumn}) async{
    CommonWidget.showLoading();
    try {
      await boardRepository.moveTask(taskID: taskID, toSeq: toSeq, toColumn: toColumn);
      CommonWidget.hideLoading();
    } catch (e) {
      CommonWidget.hideLoading();
    }
  }

  @override
  void onClose() {}
}
