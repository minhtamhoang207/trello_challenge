import 'package:get/get.dart';
import 'package:trello_challenge/modules/login/login_controller.dart';

class LoginBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(authRepository: Get.find()));
  }
}