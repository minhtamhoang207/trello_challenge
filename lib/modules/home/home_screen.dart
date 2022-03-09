import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:trello_challenge/routes/app_pages.dart';
import '../../shared/constants/colors.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController>{
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(),
        body: Container(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.offAllNamed(Routes.login);
          },
          backgroundColor: AppColor.primaryColor,
          elevation: 1,
          child: Icon(Icons.developer_board_outlined, color: AppColor.white),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 5,
          color: AppColor.primaryColor,
          child: SizedBox(
            height: 55,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Gap(10),
                      Icon(Icons.notifications_active_outlined, size: 20, color: AppColor.white),
                      Text('Thông báo', style: TextStyle(
                       color: AppColor.white,fontSize: 12
                      ))
                    ],
                  ),
                ),
                const Spacer(),
                Expanded(
                  child: Column(
                    children: [
                      const Gap(10),
                      Icon(Icons.person_outline, size: 20, color: AppColor.white),
                      Text('Cá nhân', style: TextStyle(
                          color: AppColor.white,fontSize: 12
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
