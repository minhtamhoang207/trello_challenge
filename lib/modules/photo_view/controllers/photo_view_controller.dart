import 'package:get/get.dart';

class PhotoViewController extends GetxController {

  String url = '';
  @override
  void onInit() {
    url = Get.arguments;
    super.onInit();
  }
}
