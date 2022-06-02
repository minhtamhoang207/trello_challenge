import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import '../../../../shared/constants/colors.dart';

class SmallAvatar extends StatelessWidget {
  final int index;
  final String imgURL;
  const SmallAvatar({Key? key, required this.index, required this.imgURL}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.translationValues( 0, 0, 0),
      child: CachedNetworkImage(
        imageUrl: imgURL,
        errorWidget: (context, url, error) =>  Transform(
          transform: Matrix4.translationValues(0, 0, 0),
          child: Icon(
              CupertinoIcons.person_circle_fill,
              size: 25,
              color: AppColor.darkGray),
        ),
        placeholder: (context, url) =>
            Transform(
              transform: Matrix4.translationValues( 0, 0, 0),
              child: Icon(
                  CupertinoIcons.person_circle_fill,
                  size: 25,
                  color: AppColor.darkGray),
            ),
        imageBuilder: (context, imageProvider) => SizedBox(
            height: 25,
            width: 25,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColor.white, width: 2),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: imageProvider
                  )
              ),
            )
        ),
      ),
    );
  }
}
