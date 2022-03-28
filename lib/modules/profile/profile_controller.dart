import 'dart:developer';

import 'package:get/get.dart';
import 'package:trello_challenge/data/api/repository/user_repository.dart';

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
}