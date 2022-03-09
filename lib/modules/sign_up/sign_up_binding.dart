import 'package:get/get.dart';
import 'package:trello_challenge/modules/sign_up/sign_up_controller.dart';

class SignUpBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController(authRepository: Get.find()));
  }
}