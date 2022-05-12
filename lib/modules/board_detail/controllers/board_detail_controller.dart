import 'package:get/get.dart';
import 'package:trello_challenge/data/api/repository/board_repository.dart';
import 'package:trello_challenge/data/model/params/board_detail_params.dart';
import 'package:trello_challenge/data/model/response/board_column_response.dart';
import 'package:trello_challenge/routes/app_pages.dart';

import '../../../data/api/repository/project_repository.dart';
import '../../../shared/utils/common_widget.dart';
import '../../project_detail/controllers/project_detail_controller.dart';
import '../views/board_detail_view.dart';

class BoardDetailController extends GetxController {

  final ProjectRepository projectRepository;
  final BoardRepository boardRepository;
  BoardDetailController({required this.projectRepository, required this.boardRepository});

  final BoardDetailParams arguments = Get.arguments;

  @override
  void onInit() {
    boardRepository.getBoardColumn(boardID: arguments.boardID);
    super.onInit();
  }

  List<BoardListObject> listData = [];

  Future<void> getColumn() async {
    final res = await boardRepository.getBoardColumn(boardID: arguments.boardID);
    listData = res.data;
  }

  Future<void> addColumn({required String columnName, required int seqNo}) async {
    await boardRepository.addBoardColumn(
        boardID: arguments.boardID,
        columnName: columnName,
        seqNo: seqNo
    );
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

  @override
  void onClose() {}
}
