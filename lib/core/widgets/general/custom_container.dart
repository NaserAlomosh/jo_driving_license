import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;
  final Decoration? decoration;
  final Color? color;

  const CustomContainer({
    super.key,
    this.height,
    this.width,
    this.margin,
    this.padding,
    this.alignment,
    this.decoration,
    this.color,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height?.h,
      width: width?.w,
      decoration: decoration,
      padding: padding,
      margin: margin,
      color: color,
      alignment: alignment,
      child: child,
    );
  }
}
