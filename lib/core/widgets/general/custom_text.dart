import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helper/get_device_type.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final String fontFamily;
  final FontWeight fontWeight;
  final TextDecoration textDecoration;
  final TextAlign textAlign;
  final int maxLines;
  final TextOverflow? textOverflow;
  // final TextDirection textDirection;
  final List<Shadow>? shadows;
  final double? height;

  const CustomText({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.color,
    this.textAlign = TextAlign.start,
    this.fontFamily = 'SF Pro Display',
    this.fontWeight = FontWeight.w500,
    this.textDecoration = TextDecoration.none,
    this.maxLines = 5,
    this.textOverflow,
    // this.textDirection = TextDirection.rtl,
    this.shadows,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final bool isTaplet = checkDeviceIsTaplet(context);
    Color defaultColor = color ?? Theme.of(context).colorScheme.secondary;
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: textOverflow,
      // textDirection: textDirection,
      style: TextStyle(
        height: height,
        fontFamily: fontFamily,
        decoration: textDecoration,
        shadows: shadows,
        fontSize: (isTaplet ? (fontSize - 2).sp : fontSize.sp),
        color: defaultColor,
        fontWeight: fontWeight,
      ),
    );
  }
}
