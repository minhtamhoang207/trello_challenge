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
  // final Socket socket = io('https://t.itptit.com/socket.io', <String, dynamic>{});


  @override
  void onInit() async {
    connectAndListen();
    await boardRepository.getBoardColumn(boardID: arguments.boardID);
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

  // void subscribeToBoard() {
  //   try {
  //     socket.connect();
  //     socket.emit('subscribe', {
  //       "type": "Board",
  //       "targetId": arguments.boardID
  //     });
  //     socket.on('create_task', (data) => log('tom oi o day nek ${data.toString()}'));
  //     socket.on('create_column', (data) => log('tom oi o day nek ${data.toString()}'));
  //     socket.on('move_column', (data) => log('tom oi o day nek ${data.toString()}'));
  //     socket.on('update_column', (data) => log('tom oi o day nek ${data.toString()}'));
  //     socket.on('delete_column', (data) => log('tom oi o day nek ${data.toString()}'));
  //     socket.on('move_task', (data) => log('tom oi o day nek ${data.toString()}'));
  //     socket.on('update_task', (data) => log('tom oi o day nek ${data.toString()}'));
  //     socket.on('board_update', (data) => log('tom oi o day nek ${data.toString()}'));
  //
  //     log('connect socket status" ${socket.connect().connected}');
  //
  //
  //     log('subscribed to board ${arguments.boardID}');
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  void connectAndListen() async {
    try{
      IO.Socket socket = IO.io("https://t.itptit.com/socket.io", <String, dynamic>{
        "transports": ["websocket"],
      });

      socket.onConnect((_) {
        print('connect hehe');
        socket.emit('subscribe', {
          "type": "Board",
          "targetId": arguments.boardID
        });
        socket.on('subscribe', (data) => log('subscribe board data: $data'));
        log('connect socket status" ${socket.connected}');
        log('subscribed to board ${arguments.boardID}');
      });
      socket.onError((data) => log('SOCKET ERR: $data'));
      socket.on('create_task', (data) => log('tom oi o day nek ${data.toString()}'));
      socket.on('create_column', (data) => log('tom oi o day nek ${data.toString()}'));
      socket.on('move_column', (data) => log('tom oi o day nek ${data.toString()}'));
      socket.on('update_column', (data) => log('tom oi o day nek ${data.toString()}'));
      socket.on('delete_column', (data) => log('tom oi o day nek ${data.toString()}'));
      socket.on('move_task', (data) => log('tom oi o day nek ${data.toString()}'));
      socket.on('update_task', (data) => log('tom oi o day nek ${data.toString()}'));
      socket.on('board_update', (data) => log('tom oi o day nek ${data.toString()}'));
    } catch (e){
      print('huhuhu hihi: ${e.toString()}');
    }

  }

  @override
  void onClose() {}
}
