import 'package:get/get.dart';
import '../../data/api/repository/auth_repository.dart';
import '../../data/model/response/user_model.dart';

class HomeController extends GetxController {
  final AuthRepository authRepository;
  HomeController({required this.authRepository});

  var user = Rxn<UserResponse>();
  var status = RxStatus.empty();

  @override
  void onInit() {
    super.onInit();
    loadUsers();
  }

  Future<void> loadUsers() async {
    try{
      user.value = await authRepository.getUser();
    } catch(e){
      status = RxStatus.error(e.toString());

    }
  }
}