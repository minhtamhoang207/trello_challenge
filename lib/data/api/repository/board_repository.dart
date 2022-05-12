import 'package:trello_challenge/data/api/provider/board_provider.dart';
import 'package:trello_challenge/data/model/response/board_column_response.dart';
import '../base_provider.dart';

class BoardRepository extends RestClient{
  BoardRepository({required this.boardProvider});
  final BoardProvider boardProvider;


  Future<BoardDetailModel> getBoardColumn({required String boardID}) async {
    final response = await boardProvider.getBoardColumn(path: 'board-columns', boardID: boardID);
    return BoardDetailModel.fromJson(response.data);
  }

  Future<void> addBoardColumn({
    required String boardID,
    required String columnName,
    required int seqNo
  }) async {
    await boardProvider.addBoardColumn(
        path: 'board-columns',
        boardID: boardID,
        seqNo: seqNo,
        columnName: columnName
    );
  }

  Future<void> addTask({
    required String columnID,
    required String taskName,
    required int seqNo
  }) async {
    await boardProvider.addTask(
        path: 'tasks',
        columnID: columnID,
        seqNo: seqNo,
        taskName: taskName
    );
  }

}