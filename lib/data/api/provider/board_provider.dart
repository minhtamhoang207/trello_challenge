import 'package:dio/dio.dart';
import 'package:trello_challenge/data/model/request/create_board_request.dart';
import 'package:trello_challenge/data/model/request/create_project_request.dart';
import '../base_provider.dart';

class BoardProvider {
  final RestClient restClient;
  BoardProvider({required this.restClient});


  Future<Response> getBoardColumn({required String path, required String boardID}) {
    return restClient.request(url: path, method: Method.GET, params: {'board': boardID});
  }

  Future<Response> addBoardColumn({
    required String path,
    required String boardID,
    required String columnName,
    required int seqNo
  }){
    return restClient.request(url: path, method: Method.POST, params: {
      "name": columnName,
      "seq_no": seqNo,
      "board": boardID
    });
  }

  Future<Response> addTask({
    required String path,
    required String columnID,
    required String taskName,
    required int seqNo
  }){
    return restClient.request(url: path, method: Method.POST, params: {
      "name": taskName,
      "seq_no": seqNo,
      "column": columnID
    });
  }
}
