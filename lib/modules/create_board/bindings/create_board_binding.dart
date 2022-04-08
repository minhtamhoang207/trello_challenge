import 'package:get/get.dart';

import '../controllers/create_board_controller.dart';

class CreateBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateBoardController>(
      () => CreateBoardController(projectRepository: Get.find()),
    );
  }
}
