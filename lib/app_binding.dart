import 'package:get/get.dart';

import 'data/api/provider/auth_provider.dart';
import 'data/api/repository/auth_repository.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put(AuthProvider(), permanent: true);
    Get.put(AuthRepository(authProvider: Get.find()), permanent: true);
  }
}