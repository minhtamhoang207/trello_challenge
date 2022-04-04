import 'package:get/get.dart';
import 'package:trello_challenge/data/api/provider/project_provider.dart';
import 'package:trello_challenge/data/api/provider/user_provider.dart';
import 'package:trello_challenge/data/api/repository/project_repository.dart';
import 'package:trello_challenge/data/api/repository/user_repository.dart';

import 'data/api/provider/auth_provider.dart';
import 'data/api/repository/auth_repository.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put(AuthProvider(restClient: Get.find()), permanent: true);
    Get.put(AuthRepository(authProvider: Get.find()), permanent: true);
    Get.put(UserProvider(restClient: Get.find()), permanent: true);
    Get.put(UserRepository(userProvider: Get.find()), permanent: true);
    Get.put(ProjectProvider(restClient: Get.find()), permanent: true);
    Get.put(ProjectRepository(projectProvider: Get.find()), permanent: true);
  }
}