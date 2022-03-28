import 'package:get/get.dart';
import 'package:trello_challenge/modules/profile/profile_controller.dart';

class ProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController(userRepository: Get.find()));
  }
}