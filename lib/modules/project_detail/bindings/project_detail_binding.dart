import 'package:get/get.dart';

import '../controllers/project_detail_controller.dart';

class ProjectDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectDetailController>(
      () => ProjectDetailController(projectRepository: Get.find()),
    );
  }
}
