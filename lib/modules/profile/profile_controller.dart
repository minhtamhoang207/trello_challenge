import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trello_challenge/data/api/repository/user_repository.dart';
import 'package:trello_challenge/routes/app_pages.dart';
import 'package:trello_challenge/shared/constants/storage.dart';

class ProfileController extends GetxController with StateMixin{

  final UserRepository userRepository;
  ProfileController({required this.userRepository});

  RxString name = ''.obs;

  @override
  void onInit() {
    log("ININTITITNTI PROFILE");
    loadUser();
    super.onInit();
  }

  void loadUser() async {
    print('log');
    await Future.delayed(Duration(seconds: 2));
    name.value = 'Hoang Minh Tam';
    change(null, status: RxStatus.success());
  }

  Future<dynamic> logout() async{
    await Get.find<SharedPreferences>().remove(StorageConstants.token);
    Get.offAllNamed(Routes.login);
  }
}