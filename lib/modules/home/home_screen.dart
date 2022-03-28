import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:trello_challenge/modules/profile/profile_controller.dart';
import 'package:trello_challenge/modules/profile/profile_screen.dart';
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
      const SafeArea(child: BoardViewExample()),
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

class BoardViewExample extends StatefulWidget {


  const BoardViewExample({Key? key}) : super(key: key);

  @override
  State<BoardViewExample> createState() => _BoardViewExampleState();
}

class _BoardViewExampleState extends State<BoardViewExample> {
  final List<BoardListObject> _listData = [
    BoardListObject(title: "List title 1",
        items: [BoardItemObject(title: 'it me Tom hehe 1'),
          BoardItemObject(title: 'it me Tom hehe 2') ,
          BoardItemObject(title: 'it me Tom hehe 3')]
    ),
    BoardListObject(title: "List title 2"),
    BoardListObject(title: "List title 3")
  ];

  //Can be used to animate to different sections of the BoardView
  BoardViewController boardViewController = BoardViewController();

  @override
  Widget build(BuildContext context) {
    List<BoardList> _lists = [];
    for (int i = 0; i < _listData.length; i++) {
      _lists.add(_createBoardList(_listData[i], i) as BoardList);
    }
    return Scaffold(
      body: BoardView(
        lists: _lists,
        onTapAddList: (){
          setState(() {
            _listData.add(BoardListObject(title: "List title ${_listData.length}"));
          });
        },
        boardViewController: boardViewController,
        bottomPadding: 100,
      ),
    );
  }

  Widget buildBoardItem(BoardItemObject itemObject) {
    return BoardItem(
        onStartDragItem: (int? listIndex, int? itemIndex, BoardItemState? state) {

        },
        onDropItem: (int? listIndex, int? itemIndex, int? oldListIndex,
            int? oldItemIndex, BoardItemState? state) {
          //Used to update our local item data
          var item = _listData[oldListIndex!].items![oldItemIndex!];
          _listData[oldListIndex].items!.removeAt(oldItemIndex);
          _listData[listIndex!].items!.insert(itemIndex!, item);
        },
        onTapItem: (int? listIndex, int? itemIndex, BoardItemState? state) async {

        },
        item: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(itemObject.title! + 'hehe'),
          ),
        ));
  }

  Widget _createBoardList(BoardListObject list, int index) {
    List<BoardItem> items = [];
    for (int i = 0; i < list.items!.length; i++) {
      items.insert(i, buildBoardItem(list.items![i]) as BoardItem);
    }
    return BoardList(
      onStartDragList: (int? listIndex) {

      },
      onTapList: (int? listIndex) async {
        //print(listIndex.toString() + 'kkkkkkk');
      },
      onDropList: (int? listIndex, int? oldListIndex) {
        //Update our local list data
        var list = _listData[oldListIndex!];
        _listData.removeAt(oldListIndex);
        _listData.insert(listIndex!, list);
      },
      headerBackgroundColor: const Color.fromARGB(255, 235, 236, 240),
      backgroundColor: const Color.fromARGB(255, 235, 236, 240),
      header: [
        Expanded(
            child: Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  list.title!,
                  style: const TextStyle(fontSize: 20),
                ))),
      ],
      footer: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: InkWell(
          onTap: (){
           // print('Day la index $index');
            setState(() {
              _listData[index].items?.add(BoardItemObject(title: 'it me Tom hehe 2'));
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('add task'),
              Icon(Icons.add)
            ],
          ),
        ),
      ),
      items: items,
    );
  }
}

class BoardItemObject{

  String? title;

  BoardItemObject({this.title}){
    title ??= "";
  }

}

class BoardListObject{

  String? title;
  List<BoardItemObject>? items;

  BoardListObject({this.title,this.items}){
    title ??= "";
    items ??= [];
  }
}