import 'package:get/get.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_screen.dart';
part 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: Routes.INITIAL,
        page: () => const HomePage(),
        binding: HomeBinding()),
    // GetPage(
    //     name: Routes.DETAILS,
    //     page: () => DetailsPage(),
    //     binding: DetailsBinding()),
  ];
}
