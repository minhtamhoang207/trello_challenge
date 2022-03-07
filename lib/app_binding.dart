import 'package:get/get.dart';
import 'package:trello_challenge/app/data/api/repository/auth_repository.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put(AuthRepository(), permanent: true);
  }
}