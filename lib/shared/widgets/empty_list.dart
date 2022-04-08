import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trello_challenge/gen/assets.gen.dart';

class EmptyList extends StatelessWidget {
  final String message;
  const EmptyList({Key? key, this.message = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      children: [
        Gap(Get.height * 0.1),
        Lottie.asset(Assets.lotties.lottieEmptyBox, height: 150, width: 150),
        const Gap(20),
        Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16
          ),
        )
      ],
    );
  }
}
