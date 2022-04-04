import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:trello_challenge/data/api/repository/project_repository.dart';
import 'package:trello_challenge/data/model/request/create_project_request.dart';
import 'package:trello_challenge/data/model/response/project_response.dart';
import 'package:trello_challenge/shared/utils/common_widget.dart';

import '../../../shared/enums/dialog_type.dart';
import '../../../shared/widgets/custom_dialog.dart';

class WorkspaceController extends GetxController with StateMixin<ProjectResponse> {
  final ProjectRepository projectRepository;
  WorkspaceController({required this.projectRepository});

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  RxBool private = RxBool(true);
  RxBool public = RxBool(false);

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

  void createProject() async {
    if(nameController.text.isNotEmpty && nameController.text.length >= 3){
      CommonWidget.showLoading();
      try {
        await projectRepository.createProject(data: CreateProjectRequest(
            name: nameController.text,
            description: descriptionController.text,
            private: private.value
        ));
        CommonWidget.hideLoading();
        resetState();
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

  void resetState(){
    nameController.text = '';
    descriptionController.text = '';
    private.value = true;
    public.value = false;
  }
}

