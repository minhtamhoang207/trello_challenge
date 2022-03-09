import 'package:get/get.dart';
import 'package:trello_challenge/modules/splash/splash_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
  }
}