import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helper/spacing.dart';
import '../general/custom_text.dart';

Widget getErrorImage(
  BuildContext context, {
  double? heightPadding,
  double? iconSize,
  double? fontSize,
  EdgeInsetsGeometry? padding,
}) {
  return SizedBox(
    child: Center(
      child: Padding(
        padding: padding ?? const EdgeInsets.all(0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: iconSize ?? 20.sp,
              color: Colors.red,
            ),
            heightSpace(heightPadding ?? 100),
            const Flexible(
              child: CustomText(
                textAlign: TextAlign.center,
                text: 'Image Not Found',
                fontSize: 11,
                fontWeight: FontWeight.w300,
              ),
            )
          ],
        ),
      ),
    ),
  );
}
