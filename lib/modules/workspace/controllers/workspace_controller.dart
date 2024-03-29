import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trello_challenge/data/api/repository/project_repository.dart';
import 'package:trello_challenge/data/model/request/create_project_request.dart';
import 'package:trello_challenge/data/model/response/project_response.dart';
import 'package:trello_challenge/shared/constants/storage.dart';
import 'package:trello_challenge/shared/utils/common_widget.dart';

import '../../../shared/enums/dialog_type.dart';
import '../../../shared/widgets/custom_dialog.dart';

class WorkspaceController extends GetxController with StateMixin<ProjectResponse> {
  final ProjectRepository projectRepository;
  WorkspaceController({required this.projectRepository});

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController inviteLinkController = TextEditingController();

  RxBool private = RxBool(true);
  RxBool edit = RxBool(false);
  RxString projectId = RxString('');

  @override
  void onInit() {
    getProjects();
    super.onInit();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void getProjects() async {
    CommonWidget.showLoading();
    try {
      final response = await projectRepository.getProjects();
      change(response, status: RxStatus.success());
      CommonWidget.hideLoading();
    } catch (e) {
      CommonWidget.hideLoading();
      change(ProjectResponse(data: []), status: RxStatus.error(e.toString()));
    }
  }

  bool checkRole(List<ProjectMember> listMember){
    final currentUser = Get.find<SharedPreferences>().getString(StorageConstants.userID);
    for (int i=0 ; i < listMember.length; i++){
      if(listMember[i].user.id == currentUser){
        if(listMember[i].role == 'ADMIN'){
          return true;
        }
      }
    }
    return false;
  }

  void deleteProject(String projectID) async {
    CommonWidget.showLoading();
    try {
      await projectRepository.deleteProject(projectID: projectID);
      CommonWidget.hideLoading();
      getProjects();
    } catch (e) {
      CommonWidget.hideLoading();
    }
  }

  void createProject() async {
    if(nameController.text.isNotEmpty && nameController.text.length >= 3){
      CommonWidget.showLoading();
      try {
        await projectRepository.createProject(data: CreateProjectRequest(
            name: nameController.text,
            description: descriptionController.text,
            type: typeController.text
        ));
        CommonWidget.hideLoading();
        Get.back();
        getProjects();
      } catch (e) {
        CommonWidget.hideLoading();
        Get.dialog( CustomDialog(dialogType: DialogType.failed, message: e.toString()));
      }
    } else{
      CommonWidget.toast('Tên dự án chứa ít nhất 3 kí tự và không được để trống');
    }
  }

  void editProject({String? inviteCode}) async {
    if(nameController.text.isNotEmpty && nameController.text.length >= 3){
      CommonWidget.showLoading();
      try {
        await projectRepository.editProject(projectID: projectId.value, data: CreateProjectRequest(
            name: nameController.text,
            description: descriptionController.text,
            type: typeController.text,
            inviteCode: inviteCode
        ));
        CommonWidget.hideLoading();
        if(inviteCode != null ){
          Clipboard.setData(
              ClipboardData(text: 'https://chillo.stupd.dev/invite/${projectId.value}/$inviteCode'))
              .then((_) {
            CommonWidget.toast('Đã copy liên kết mời vào bộ nhớ tạm');
          });
        }
        Get.back();
        getProjects();
      } catch (e) {
        CommonWidget.hideLoading();
        Get.dialog( CustomDialog(dialogType: DialogType.failed, message: e.toString()));
      }
    } else{
      CommonWidget.toast('Tên dự án chứa ít nhất 3 kí tự và không được để trống');
    }
  }

  Future<void> joinProject({required String inviteLink}) async {
    CommonWidget.showLoading();
    try {
      List<String> temp = inviteLink.split('/');
      await projectRepository.joinProject(projectID: temp[temp.length - 2], inviteCode: temp[temp.length - 1]);
      CommonWidget.hideLoading();
      Get.back();
      getProjects();
    } catch (e) {
      CommonWidget.hideLoading();
      Get.dialog( CustomDialog(dialogType: DialogType.failed, message: e.toString()));
    }
  }

  void initCreateProject({
    required String name,
    required String description,
    required String type,
    bool isEdit = false,
    String projectID = '',
  }){
    edit.value = isEdit;
    projectId.value = projectID;
    nameController.text = name;
    descriptionController.text = description;
    typeController.text = type;
  }
}

