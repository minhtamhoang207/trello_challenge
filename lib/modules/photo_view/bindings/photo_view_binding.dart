import 'package:get/get.dart';

import '../controllers/photo_view_controller.dart';

class PhotoViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhotoViewController>(
      () => PhotoViewController(),
    );
  }
}
