import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimationColorWidget extends StatefulWidget {

  final Widget? child;

  const AnimationColorWidget({super.key, this.child});

  @override
  AnimationColorWidgetState createState() => AnimationColorWidgetState();
}

class AnimationColorWidgetState extends State<AnimationColorWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? fadingAnimation;

  AnimationColorWidgetState();

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    fadingAnimation =
        Tween<double>(begin: .2, end: 1).animate(animationController!);

    animationController?.repeat(reverse: true);
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 10.h,
      ),
      child: FadeTransition(
        opacity: fadingAnimation!,
        child: widget.child,
      ),
    );
  }
}




