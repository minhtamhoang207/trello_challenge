import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:trello_challenge/modules/profile/profile_controller.dart';
import 'package:trello_challenge/modules/profile/profile_screen.dart';
import 'package:trello_challenge/modules/workspace/views/workspace_view.dart';
import 'package:trello_challenge/shared/constants/colors.dart';
import 'home_controller.dart';
import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:flutter/material.dart';
import 'package:boardview/boardview.dart';

class HomePage extends GetView<HomeController>{
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller.tabController,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: AppColor.primaryColor,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      onItemSelected: (index){
        if(index == 3){
          Get.find<ProfileController>().loadUser();
        }
      },
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.neumorphic, // Choose the nav bar style with this property.
    );
  }

  List<Widget> _buildScreens() {
    return [
      const WorkspaceView(),
      Container(color: Colors.pink),
      Container(color: Colors.amberAccent),
      const ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        activeColorPrimary: AppColor.darkLiver,
        inactiveColorPrimary: AppColor.darkLiver.withOpacity(0.3),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.today),
        activeColorPrimary: AppColor.darkLiver,
        inactiveColorPrimary: AppColor.darkLiver.withOpacity(0.3),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.bell),
        activeColorPrimary: AppColor.darkLiver,
        inactiveColorPrimary: AppColor.darkLiver.withOpacity(0.3),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.profile_circled),
        activeColorPrimary: AppColor.darkLiver,
        inactiveColorPrimary: AppColor.darkLiver.withOpacity(0.3),
      ),
    ];
  }

}