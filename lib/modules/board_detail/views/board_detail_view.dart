import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:trello_challenge/data/model/response/board_column_response.dart';
import 'package:trello_challenge/routes/app_pages.dart';
import 'package:trello_challenge/shared/constants/colors.dart';
import '../../../data/model/params/board_detail_params.dart';
import '../controllers/board_detail_controller.dart';
import 'components/boardview/board_item.dart';
import 'components/boardview/board_list.dart';
import 'components/boardview/boardview.dart';
import 'components/boardview/boardview_controller.dart';

class BoardDetailView extends GetView<BoardDetailController> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  BoardDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
          backgroundColor: AppColor.appBlue,
          title: const Text('Kaban board'),
          leading: IconButton(
            onPressed: ()=> Get.back(),
            icon:Icon(Icons.adaptive.arrow_back),
          ),
          actions: [
            IconButton(
              onPressed:(){
                scaffoldKey.currentState!.openEndDrawer();
              },
              icon: const Icon(Icons.settings),
              tooltip: 'Thêm bảng mới',
            ),
          ],
        ),
      endDrawer: Container(
        width: Get.width - 100,
        color: AppColor.white,
        child: ListView(
          children: [
            ListTile(
              onTap: (){},
              leading: const Icon(Icons.image),
              title: const Text('Chỉnh sửa hình nền')
            ),
            ListTile(
                onTap: () async {
                  Get.back();
                  await Get.toNamed(Routes.CREATE_BOARD, arguments: BoardDetailParams(
                    backGround: controller.arguments.backGround,
                    boardID: controller.arguments.boardID,
                    boardName: controller.arguments.boardName,
                    expireDate: controller.arguments.expireDate,
                  ));
                },
                leading: const Icon(Icons.edit),
                title: const Text('Chỉnh sửa thông tin bảng')
            ),
            ListTile(
              onTap: (){
                controller.deleteBoard();
                Get.back();
              },
              leading: const Icon(Icons.delete),
              title: const Text('Xóa bảng'),
            ),
            ListTile(
              onTap: (){},
              leading: const Icon(Icons.info_outline),
              title: const Text('Thông tin bảng'),
            )
          ],
        ),
      ),
      body: BoardViewExample(background: controller.arguments.backGround)
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

  //Can be used to animate to different sections of the BoardView
  BoardViewController boardViewController = BoardViewController();
  final controller = Get.find<BoardDetailController>();
  TextEditingController textController = TextEditingController();
  final Socket socket = Get.find();


  @override
  void initState() {
    connectAndListen();
  }
  void connectAndListen() async {
    try{
      socket.emit('subscribe', {
        "type": "Board",
        // "targetId": controller.arguments.boardID
        "targetId": '6283cf98b1a3e6f7ae54f5a9'
      });
      socket.on('subscribe', (data) => log('>>>>>>>>>>>>>>>>>>>>>>>>>>> subscribe board data: $data'));
      // log('connect socket status" ${socket.connected}');
      // log('subscribed to board ${arguments.boardID}');
      socket.onError((data) => log('SOCKET ERR: $data'));
      socket.on('create_task', (data) async{
        log('>>>>>> create_task  ${data.toString()}');
        await controller.getColumn();
        setState(() {});
      });
      socket.on('create_column', (data) async{
        log('>>>>>> create_column  ${data.toString()}');
        await controller.getColumn();
        setState(() {});
      });
      socket.on('move_column', (data) async{
        log('>>>>>> move_column  ${data.toString()}');
        await controller.getColumn();
        setState(() {});
      });
      socket.on('update_column', (data) async{
        log('>>>>>> update_column  ${data.toString()}');
        await controller.getColumn();
        setState(() {});
      });
      socket.on('delete_column', (data) async{
        log('>>>>>> delete_column  ${data.toString()}');
        await controller.getColumn();
        setState(() {});
      });
      socket.on('move_task', (data) async{
        log('>>>>>> move_task  ${data.toString()}');
        await controller.getColumn();
        setState(() {});
      });
      socket.on('update_task', (data) async{
        log('>>>>>> update_task  ${data.toString()}');
        await controller.getColumn();
        setState(() {});
      });
      socket.on('board_update', (data) async{
        log('>>>>>> board_update  ${data.toString()}');
        await controller.getColumn();
        setState(() {});
      });
      // socket.on('create_column', (data) => log('tom oi o day nek ${data.toString()}'));
      // socket.on('move_column', (data) => log('tom oi o day nek ${data.toString()}'));
      // socket.on('update_column', (data) => log('tom oi o day nek ${data.toString()}'));
      // socket.on('delete_column', (data) => log('tom oi o day nek ${data.toString()}'));
      // socket.on('move_task', (data) => log('tom oi o day nek ${data.toString()}'));
      // socket.on('update_task', (data) => log('tom oi o day nek ${data.toString()}'));
      // socket.on('board_update', (data) => log('tom oi o day nek ${data.toString()}'));
    } catch (e){
      print(':::::::: ${e.toString()}');
    }

  }


  @override
  void didChangeDependencies() async {
    await controller.getColumn();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    List<BoardList> _lists = [];
    for (int i = 0; i < controller.listData.length; i++) {
      _lists.add(_createBoardList(controller.listData[i], i) as BoardList);
    }
    return Scaffold(
      body: BoardView(
        backgroundColor: AppColor.darkLiver,
        background: 'https://www.imgacademy.com/sites/default/files/2009-stadium-about.jpg',
        //background: widget.background,
        lists: _lists,
        onTapAddList: () {
          _displayDialog(context, hint: 'Tên cột', title: 'Nhập tên cột', onPress: () async {
            await controller.addColumn(columnName: textController.text, seqNo: controller.listData.length);
            Navigator.pop(context);
            textController.clear();
            await controller.getColumn();
            setState(() {});
          });
        },
        boardViewController: boardViewController,
        bottomPadding: 100,
      ),
    );
  }

  Widget buildBoardItem(Task itemObject) {
    return BoardItem(
        onStartDragItem: (int? listIndex, int? itemIndex, BoardItemState? state) {
          log('>>>>>> onStartDragItem: listIndex: $listIndex - itemIndex: $itemIndex - oldListIndex: $itemIndex');

        },
        onDropItem: (int? listIndex, int? itemIndex, int? oldListIndex,
            int? oldItemIndex, BoardItemState? state) async {
          //Used to update our local item data
          var item = controller.listData[oldListIndex!].tasks[oldItemIndex!];
          controller.listData[oldListIndex].tasks.removeAt(oldItemIndex);
          controller.listData[listIndex!].tasks.insert(itemIndex!, item);

          log('>>>>>> onDropItem: listIndex: $listIndex - itemIndex: $itemIndex - oldListIndex: $oldListIndex');

          await controller.moveTask(
            toSeq: itemIndex,
            taskID: controller.listData[listIndex].tasks[itemIndex].id,
            toColumn: controller.listData[listIndex].id
          );
          setState(() {});

        },
        onTapItem: (int? listIndex, int? itemIndex, BoardItemState? state) async {
          // print('dasdasdasdasdasd');
          // print(controller.listData[listIndex!].id);
          log('>>>>>> onTapItem: listIndex: $listIndex - itemIndex: $itemIndex');
        },
        item: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(itemObject.name),
          ),
        ));
  }

  Widget _createBoardList(BoardListObject list, int index) {
    List<BoardItem> items = [];
    for (int i = 0; i < list.tasks.length; i++) {
      items.insert(i, buildBoardItem(list.tasks[i]) as BoardItem);
    }
    return BoardList(
      onStartDragList: (int? listIndex) {
        log('>>>>>> onStartDragList: listIndex: $listIndex');
      },
      onTapList: (int? listIndex) async {
        log('>>>>>> onTapList: listIndex: $listIndex');
      },
      onDropList: (int? listIndex, int? oldListIndex) async {
        //Update our local list data
        var list = controller.listData[oldListIndex!];
        controller.listData.removeAt(oldListIndex);
        controller.listData.insert(listIndex!, list);

        log('>>>>>> onDropList: listIndex: $listIndex - oldIndex: $oldListIndex');

        await controller.moveColumn(columnID: controller.listData[oldListIndex].id, toIndex: listIndex);
        await controller.getColumn();
        setState(() {});
      },
      headerBackgroundColor: Colors.deepPurpleAccent,
      backgroundColor: Colors.orangeAccent,
      header: [
        Expanded(
            child: Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  list.name,
                  style: const TextStyle(fontSize: 20),
                ))),
      ],
      footer: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: InkWell(
          onTap: () {
            log('------->>>>> Column index: $index');
            _displayDialog(context, hint: 'Tên task', title: 'Nhập tên task', onPress: () async {
              await controller.addTask(
                  columnID: controller.listData[index].id,
                  seqNo: controller.listData[index].tasks.length,
                  taskName: textController.text
              );
              textController.clear();
              Navigator.pop(context);
              await controller.getColumn();
              setState(() {});
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Add task'),
              Icon(Icons.add)
            ],
          ),
        ),
      ),
      items: items,
    );
  }

  _displayDialog(BuildContext context, {required String title, required String hint, Function()? onPress}) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: TextField(
              controller: textController,
              textInputAction: TextInputAction.go,
              decoration: InputDecoration(hintText: hint),
            ),
            actions: <Widget>[
               TextButton(
                child:  const Text('Trở lại'),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
               TextButton(
                child:  const Text('Xác nhận'),
                onPressed: onPress
              )
            ],
          );
        });
  }
}