import 'package:get/get.dart';
import 'package:trello_challenge/app/data/api/base_provider.dart';
import 'package:trello_challenge/app/data/api/provider/auth_provider.dart';
import 'package:trello_challenge/app/data/api/repository/auth_repository.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put(AuthProvider(), permanent: true);
    Get.put(AuthRepository(authProvider: Get.find()), permanent: true);
  }
}