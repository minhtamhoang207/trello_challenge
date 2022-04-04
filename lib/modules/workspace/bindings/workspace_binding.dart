import 'package:get/get.dart';

import '../controllers/workspace_controller.dart';

class WorkspaceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WorkspaceController>(
      () => WorkspaceController(projectRepository: Get.find()),
    );
  }
}
