import 'package:get/get.dart';
import 'package:trello_challenge/app/shared/services/storage_service.dart';

class DependencyInjection {
  static Future<void> init() async {
    await Get.putAsync(() => StorageService().init());
  }
}