import 'package:get/get.dart';

import '../modules/board_detail/bindings/board_detail_binding.dart';
import '../modules/board_detail/views/board_detail_view.dart';
import '../modules/change_password/bindings/change_password_binding.dart';
import '../modules/change_password/views/change_password_view.dart';
import '../modules/create_board/bindings/create_board_binding.dart';
import '../modules/create_board/views/create_board_view.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_screen.dart';
import '../modules/login/login_binding.dart';
import '../modules/login/login_screen.dart';
import '../modules/photo_view/bindings/photo_view_binding.dart';
import '../modules/photo_view/views/photo_view_view.dart';
import '../modules/project_detail/bindings/project_detail_binding.dart';
import '../modules/project_detail/views/project_detail_view.dart';
import '../modules/sign_up/sign_up_binding.dart';
import '../modules/sign_up/sign_up_screen.dart';
import '../modules/splash/splash_binding.dart';
import '../modules/splash/splash_screen.dart';
import '../modules/update_profile/bindings/update_profile_binding.dart';
import '../modules/update_profile/views/update_profile_view.dart';
import '../modules/workspace/bindings/workspace_binding.dart';
import '../modules/workspace/views/add_project_view.dart';
import '../modules/workspace/views/workspace_view.dart';

part 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: Routes.splash,
        page: () => const SplashScreen(),
        binding: SplashBinding()),
    GetPage(
        name: Routes.login,
        page: () => const LoginScreen(),
        binding: LoginBinding()),
    GetPage(
        name: Routes.home,
        page: () => const HomePage(),
        binding: HomeBinding()),
    GetPage(
        name: Routes.singUp,
        transition: Transition.leftToRightWithFade,
        page: () => const SignUpScreen(),
        binding: SignUpBinding()),
    GetPage(
      name: Routes.CHANGE_PASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: Routes.UPDATE_PROFILE,
      page: () => const UpdateProfileView(),
      binding: UpdateProfileBinding(),
    ),
    GetPage(
      name: Routes.PHOTO_VIEW,
      page: () => PhotoViewView(),
      binding: PhotoViewBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: Routes.WORKSPACE,
      page: () => const WorkspaceView(),
      binding: WorkspaceBinding(),
    ),
    GetPage(
      name: Routes.ADD_PROJECT,
      transition: Transition.cupertino,
      page: () => const AddProjectView(),
    ),
    GetPage(
      name: Routes.PROJECT_DETAIL,
      transition: Transition.cupertino,
      page: () => ProjectDetailView(),
      binding: ProjectDetailBinding(),
    ),
    GetPage(
      name: Routes.BOARD_DETAIL,
      transition: Transition.cupertino,
      page: () => BoardDetailView(),
      binding: BoardDetailBinding(),
    ),
    GetPage(
      name: Routes.CREATE_BOARD,
      transition: Transition.cupertino,
      page: () => CreateBoardView(),
      binding: CreateBoardBinding(),
    ),
  ];
}
