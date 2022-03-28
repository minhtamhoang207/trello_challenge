import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:trello_challenge/gen/assets.gen.dart';


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
        return Lottie.asset(Assets.lotties.lottieLoading, height: 85, width: 85);
      },
    );
  }

  static void hideLoading() {
    BotToast.closeAllLoading();
  }

  static void toast(String error) async {
      BotToast.showText(
          text: error,
          align: const Alignment(0, 0)
      );
  }

  static void showLottie(String lottieFile) {
    BotToast.showCustomLoading(
      clickClose: false,
      allowClick: false,
      backButtonBehavior: BackButtonBehavior.none,
      ignoreContentClick: true,
      animationDuration: const Duration(milliseconds: 200),
      animationReverseDuration: const Duration(milliseconds: 200),
      align: Alignment.center,
      toastBuilder: (cancelFunc) {
        return LottieBuilder.network('https://assets7.lottiefiles.com/packages/lf20_y2hxPc.json');
      },
    );
  }

}
