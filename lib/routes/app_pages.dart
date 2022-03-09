import 'package:get/get.dart';
import 'package:trello_challenge/modules/login/login_binding.dart';
import 'package:trello_challenge/modules/login/login_screen.dart';
import 'package:trello_challenge/modules/sign_up/sign_up_binding.dart';
import 'package:trello_challenge/modules/sign_up/sign_up_screen.dart';
import 'package:trello_challenge/modules/splash/splash_binding.dart';
import 'package:trello_challenge/modules/splash/splash_screen.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_screen.dart';
part 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: Routes.splash,
        page: () => const SplashScreen(),
        binding: SplashBinding()
    ),
    GetPage(
        name: Routes.login,
        page: () => LoginScreen(),
        binding: LoginBinding()
    ),
    GetPage(
        name: Routes.home,
        page: () => const HomePage(),
        binding: HomeBinding()
    ),
    GetPage(
        name: Routes.singUp,
        page: () => const SignUpScreen(),
        binding: SignUpBinding()
    ),
  ];
}
