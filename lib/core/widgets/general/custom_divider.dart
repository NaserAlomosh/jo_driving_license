import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget getDivider(
  BuildContext context, {
  EdgeInsetsGeometry? padding,
  double? thickness,
}) {
  return Padding(
    padding: padding ?? EdgeInsets.only(left: 3.w, right: 1.w),
    child: Divider(
      color: Theme.of(context).colorScheme.tertiaryContainer,
      thickness: thickness,
    ),
  );
}
