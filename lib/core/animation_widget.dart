import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ListAnimationWidget extends StatelessWidget {
  final Widget child;
  final int? milliseconds;
  const ListAnimationWidget(
      {Key? key, required this.child, this.milliseconds = 400})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: AnimationConfiguration.staggeredList(
        position: 1,
        child: SlideAnimation(
          duration: Duration(milliseconds: milliseconds!),
          child: FadeInAnimation(
            child: child,
          ),
        ),
      ),
    );
  }
}
