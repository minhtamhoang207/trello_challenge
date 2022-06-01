import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:trello_challenge/routes/app_pages.dart';
import 'package:trello_challenge/shared/constants/storage.dart';
import 'package:trello_challenge/shared/utils/common_widget.dart';

class SplashController extends GetxController {

  Socket socket = Get.find();
  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(const Duration(seconds: 2));
    final storage = Get.find<SharedPreferences>();
    try {
      log(storage.getString(StorageConstants.token).toString());
      if (storage.getString(StorageConstants.token) != null) {
        final token = storage.getString(StorageConstants.token)!;
        connectAndListen(token: token);
        Get.offAllNamed(Routes.home);
      } else {
        Get.offAllNamed(Routes.login);
      }
    } catch (e) {
      Get.offAllNamed(Routes.login);
    }
  }
  connectAndListen({required String token}) {
    try{
      socket.emit('login', {
        "accessToken": token
      });
      socket.on('login', (data) => log('login socket data : $data'));
      socket.onError((err){
        log('LOGIN SOCKET ERR: $err');
        throw err;
      });
    } catch (e){
      CommonWidget.toast(e.toString());
    }
  }
}