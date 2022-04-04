import 'dart:developer';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:trello_challenge/data/api/repository/user_repository.dart';
import 'package:trello_challenge/modules/profile/profile_binding.dart';
import 'package:trello_challenge/modules/workspace/bindings/workspace_binding.dart';
import '../../data/api/repository/auth_repository.dart';
import '../../data/model/response/user_model.dart';

class HomeController extends GetxController {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  HomeController({required this.authRepository, required this.userRepository});

  final PersistentTabController tabController = PersistentTabController(initialIndex: 0);


 // var user = Rxn<UserResponse>();
  var status = RxStatus.empty();

  @override
  void onInit() {
    log('INIT HOME');
    WorkspaceBinding().dependencies();
    ProfileBinding().dependencies();
    super.onInit();
    // loadUsers();
  }

  // Future<void> loadUsers() async {
  //   try{
  //     user.value = await authRepository.getUser();
  //   } catch(e){
  //     status = RxStatus.error(e.toString());
  //
  //   }
  // }
}