import 'dart:developer';

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
      log(storage.getString(StorageConstants.token).toString());
      if (storage.getString(StorageConstants.token) != null) {
        Get.offAllNamed(Routes.home);
      } else {
        Get.offAllNamed(Routes.login);
      }
    } catch (e) {
      Get.offAllNamed(Routes.login);
    }
  }
}