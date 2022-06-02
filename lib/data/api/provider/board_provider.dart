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

  Future<Response> deleteTask({required String path}){
    return restClient.request(url: path, method: Method.DELETE);
  }

  Future<Response> moveColumn({required String path, required int toIndex}) {
    return restClient.request(url: path, method: Method.PUT, params: {
      "to": toIndex
    });
  }

  Future<Response> editColumn({required String path, required String columnName, required int seqNo, required boardID}) {
    return restClient.request(url: path, method: Method.PUT, params: {
      "name": columnName,
      "seq_no": seqNo,
      "board": boardID
    });
  }

  Future<Response> deleteColumn({required String path}) {
    return restClient.request(url: path, method: Method.DELETE);
  }

  Future<Response> moveTask({required String path, required int toSeq, required String toColumn}) {
    return restClient.request(url: path, method: Method.PUT, params: {
      "toColumn": toColumn,
      "toSeq": toSeq
    });
  }
}
