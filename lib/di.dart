import 'package:get/get.dart';
import 'package:trello_challenge/data/api/base_provider.dart';
import 'package:trello_challenge/shared/services/socket_service.dart';
import 'package:trello_challenge/shared/services/storage_service.dart';

class DependencyInjection {
  static Future<void> init() async {
    await Get.putAsync(() => RestClient().init());
    await Get.putAsync(() => StorageService().init());
  }
}