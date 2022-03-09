import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trello_challenge/routes/app_pages.dart';
import 'package:trello_challenge/shared/constants/storage.dart';

class SplashController extends GetxController {
  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(const Duration(seconds: 2));
    final storage = Get.find<SharedPreferences>();
    try {
      print(storage.getString(StorageConstants.token));
      if (storage.getString(StorageConstants.token) != null) {
        Get.toNamed(Routes.home);
      } else {
        Get.offAll(Routes.login);
      }
    } catch (e) {
      Get.toNamed(Routes.login);
    }
  }
}