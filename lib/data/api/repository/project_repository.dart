import 'package:trello_challenge/data/api/provider/project_provider.dart';
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

  Future<BoardResponse> getBoards({required String projectID}) async {
    final res = await projectProvider.getBoards(path: 'boards', projectID: projectID);
    return BoardResponse.fromJson(res.data);
  }


}