import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../constants/colors.dart';

class CommonWidget {
  static AppBar appBar(BuildContext context, String title, IconData? backIcon, Color color,
      {void Function()? callback}) {
    return AppBar(
      leading: backIcon == null
          ? null
          : IconButton(
              icon: Icon(backIcon, color: color),
              onPressed: () {
                if (callback != null) {
                  callback();
                } else {
                  Navigator.pop(context);
                }
              },
            ),
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(color: color, fontFamily: 'Rubik'),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }

  static void showLoading() {
    BotToast.showCustomLoading(
      clickClose: false,
      allowClick: false,
      backButtonBehavior: BackButtonBehavior.none,
      ignoreContentClick: true,
      animationDuration: const Duration(milliseconds: 200),
      animationReverseDuration: const Duration(milliseconds: 200),
      align: Alignment.center,
      toastBuilder: (cancelFunc) {
        return LoadingAnimationWidget.dotsTriangle(color: AppColor.darkScaffoldBackgroundColor, size: 60);
      },
    );
  }

  static void hideLoading() {
    BotToast.closeAllLoading();
  }
  //
  // static void toast(String error) async {
  //   await Fluttertoast.showToast(
  //       msg: error,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 3,
  //       backgroundColor: Colors.white,
  //       textColor: Colors.black,
  //       fontSize: 16.0);
  // }
}
