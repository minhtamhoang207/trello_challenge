import 'package:flutter/material.dart';
import 'package:trello_challenge/shared/constants/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.darkLiver,
      child: Center(
        child: Text("Chillo",
          style: TextStyle(
            color: AppColor.white,
            fontSize: 33,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
