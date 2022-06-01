import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import '../constants/colors.dart';

class MyImageWidget extends StatelessWidget {
  final String imgUrl;
  final imageBuilder;
  const MyImageWidget({Key? key, required this.imgUrl, required this.imageBuilder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      errorWidget: (context, url, error) => Icon(
          CupertinoIcons.person,
          size: 100,
          color: AppColor.darkGray),
      placeholder: (context, url) => Icon(
          CupertinoIcons.person,
          size: 100,
          color: AppColor.darkGray),
      imageBuilder: imageBuilder
    );
  }
}
