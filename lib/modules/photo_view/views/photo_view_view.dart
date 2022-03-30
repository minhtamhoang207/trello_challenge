import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:trello_challenge/shared/constants/colors.dart';

import '../controllers/photo_view_controller.dart';

class PhotoViewView extends GetView<PhotoViewController> {
  PhotoViewView({Key? key}) : super(key: key);

  final GlobalKey<ExtendedImageSlidePageState> slidePagekey =
  GlobalKey<ExtendedImageSlidePageState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: Center(
        child: ExtendedImageSlidePage(
          key: slidePagekey,
          child: GestureDetector(
            child: HeroWidget(
              child: ExtendedImage.network(
                controller.url,
                mode: ExtendedImageMode.none,
                enableSlideOutPage: true,
              ),
              tag: controller.url,
              slideType: SlideType.wholePage,
              slidePagekey: slidePagekey,
            ),
            onTap: () {
              slidePagekey.currentState!.popPage();
              Get.back();
            },
          ),
          slideAxis: SlideAxis.both,
          slideType: SlideType.wholePage,
        ),
      ),
    );
  }
}


class HeroWidget extends StatefulWidget {
  const HeroWidget({Key? key,
    required this.child,
    required this.tag,
    required this.slidePagekey,
    this.slideType = SlideType.onlyImage,
  }) : super(key: key);
  final Widget child;
  final SlideType slideType;
  final Object tag;
  final GlobalKey<ExtendedImageSlidePageState> slidePagekey;
  @override
  _HeroWidgetState createState() => _HeroWidgetState();
}

class _HeroWidgetState extends State<HeroWidget> {
  RectTween? _rectTween;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.tag,
      createRectTween: (Rect? begin, Rect? end) {
        _rectTween = RectTween(begin: begin, end: end);
        return _rectTween!;
      },
      // make hero better when slide out
      flightShuttleBuilder: (BuildContext flightContext,
          Animation<double> animation,
          HeroFlightDirection flightDirection,
          BuildContext fromHeroContext,
          BuildContext toHeroContext) {
        // make hero more smoothly
        final Hero hero = (flightDirection == HeroFlightDirection.pop
            ? fromHeroContext.widget
            : toHeroContext.widget) as Hero;
        if (_rectTween == null) {
          return hero;
        }

        if (flightDirection == HeroFlightDirection.pop) {
          final bool fixTransform = widget.slideType == SlideType.onlyImage &&
              (widget.slidePagekey.currentState!.offset != Offset.zero ||
                  widget.slidePagekey.currentState!.scale != 1.0);

          final Widget toHeroWidget = (toHeroContext.widget as Hero).child;
          return AnimatedBuilder(
            animation: animation,
            builder: (BuildContext buildContext, Widget? child) {
              Widget animatedBuilderChild = hero.child;

              // make hero more smoothly
              animatedBuilderChild = Stack(
                clipBehavior: Clip.antiAlias,
                alignment: Alignment.center,
                children: <Widget>[
                  Opacity(
                    opacity: 1 - animation.value,
                    child: UnconstrainedBox(
                      child: SizedBox(
                        width: _rectTween!.begin!.width,
                        height: _rectTween!.begin!.height,
                        child: toHeroWidget,
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: animation.value,
                    child: animatedBuilderChild,
                  )
                ],
              );

              // fix transform when slide out
              if (fixTransform) {
                final Tween<Offset> offsetTween = Tween<Offset>(
                    begin: Offset.zero,
                    end: widget.slidePagekey.currentState!.offset);

                final Tween<double> scaleTween = Tween<double>(
                    begin: 1.0, end: widget.slidePagekey.currentState!.scale);
                animatedBuilderChild = Transform.translate(
                  offset: offsetTween.evaluate(animation),
                  child: Transform.scale(
                    scale: scaleTween.evaluate(animation),
                    child: animatedBuilderChild,
                  ),
                );
              }

              return animatedBuilderChild;
            },
          );
        }
        return hero.child;
      },
      child: widget.child,
    );
  }
}

