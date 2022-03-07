import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:trello_challenge/app/data/api/repository/auth_repository.dart';

class HomeController extends GetxController {
  final AuthRepository authRepository;
  HomeController({required this.authRepository});

  var user = RxString('');
  var status = RxStatus.empty();

  @override
  void onInit() {
    super.onInit();
    loadUsers();
  }

  Future<void> loadUsers() async {
    try{
      EasyLoading.show();
      user.value = await authRepository.getUser();
      EasyLoading.dismiss();
    } catch(e){
      status = RxStatus.error(e.toString());

    }
  }
}