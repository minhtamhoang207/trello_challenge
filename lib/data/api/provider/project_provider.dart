import 'package:dio/dio.dart';
import 'package:trello_challenge/data/model/request/create_board_request.dart';
import 'package:trello_challenge/data/model/request/create_project_request.dart';
import '../base_provider.dart';

class ProjectProvider {
  final RestClient restClient;
  ProjectProvider({required this.restClient});

  Future<Response> getProjects({required String path}) {
    return restClient.request(url: path, method: Method.GET, params: null);
  }

  Future<Response> createProject(
      {required String path, required CreateProjectRequest data}) {
    return restClient.request(
        url: path, method: Method.POST, params: data.toJson());
  }

  Future<Response> editProject(
      {required String path, required CreateProjectRequest data}) {
    return restClient.request(
        url: path, method: Method.PUT, params: data.toJson());
  }

  Future<Response> deleteProject({required String path}) {
    return restClient.request(url: path, method: Method.DELETE);
  }

  Future<Response> getBoards(
      {required String path, required String projectID}) {
    return restClient
        .request(url: path, method: Method.GET, params: {'project': projectID});
  }

  Future<Response> createBoard(
      {required String path, required CreateBoardRequest data}) {
    return restClient.request(
        url: path, method: Method.POST, params: data.toJson());
  }

  Future<Response> updateBoard({required String path, required CreateBoardRequest data}) {
    return restClient.request(url: path, method: Method.PUT, params: data.toJson());
  }

  Future<Response> deleteBoard({required String path}) {
    return restClient.request(url: path, method: Method.DELETE);
  }
}
