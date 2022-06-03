import 'package:trello_challenge/data/api/provider/project_provider.dart';
import 'package:trello_challenge/data/model/request/create_board_request.dart';
import 'package:trello_challenge/data/model/request/create_project_request.dart';
import 'package:trello_challenge/data/model/response/project_response.dart';
import '../../model/response/board_response.dart';
import '../base_provider.dart';

class ProjectRepository extends RestClient{
  ProjectRepository({required this.projectProvider});
  final ProjectProvider projectProvider;

  Future<ProjectResponse> getProjects() async {
    final res = await projectProvider.getProjects(path: 'projects');
    return ProjectResponse.fromJson(res.data);
  }

  Future<void> createProject({required CreateProjectRequest data}) async {
    await projectProvider.createProject(path: 'projects', data: data);
  }

  Future<void> editProject({required CreateProjectRequest data, required String projectID}) async {
    await projectProvider.editProject(path: 'projects/$projectID', data: data);
  }

  Future<void> deleteProject({required String projectID}) {
    return projectProvider.deleteProject(path: 'projects/$projectID');
  }

  Future<void> joinProject({required String projectID, required String inviteCode}) {
    return projectProvider.joinProject(path: 'projects/$projectID/join', inviteCode: inviteCode);
  }

  Future<void> leaveProject({required String projectID}) {
    return projectProvider.leaveProject(path: 'projects/$projectID/leave');
  }

  Future<BoardResponse> getBoards({required String projectID}) async {
    final res = await projectProvider.getBoards(path: 'boards', projectID: projectID);
    return BoardResponse.fromJson(res.data);
  }

  Future<void> createBoard({required CreateBoardRequest data}) async {
    await projectProvider.createBoard(path: 'boards', data: data);
  }

  Future<void> updateBoard({required CreateBoardRequest data, required String boardID}) async {
    await projectProvider.updateBoard(path: 'boards/$boardID', data: data);
  }

  Future<void> deleteBoard({required String boardID}) {
    return projectProvider.deleteBoard(path: 'boards/$boardID');
  }


}