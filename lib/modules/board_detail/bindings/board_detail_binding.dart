import 'package:get/get.dart';

import '../controllers/board_detail_controller.dart';

class BoardDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BoardDetailController>(
      () => BoardDetailController(projectRepository: Get.find(), boardRepository: Get.find()),
    );
  }
}
