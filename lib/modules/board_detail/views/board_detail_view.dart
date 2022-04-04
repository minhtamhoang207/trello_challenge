import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:trello_challenge/shared/constants/colors.dart';

import '../controllers/board_detail_controller.dart';

class BoardDetailView extends GetView<BoardDetailController> {
  const BoardDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitHeight,
            image: NetworkImage(
              '${controller.background}',
            )
          )
        ),
        child: BoardViewExample(background: controller.background),
      )
    );
  }
}


class BoardViewExample extends StatefulWidget {
  final String background;
  const BoardViewExample({Key? key, required this.background}) : super(key: key);

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
        backgroundColor: AppColor.darkLiver,
        background: widget.background,
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
      headerBackgroundColor: Colors.deepPurpleAccent,
      backgroundColor: Colors.orangeAccent,
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

