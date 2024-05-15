import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helper/get_device_type.dart';
import '../../helper/spacing.dart';

Widget myLoadingIndicator(
  BuildContext context, {
  Color? color,
  double? radius,
  double? topPadding,
}) {
  if (Platform.isAndroid) {
    return topPadding == null
        ? Center(
            child: SizedBox(
              height: checkDeviceIsTaplet(context) ? 25.sp : null,
              width: checkDeviceIsTaplet(context) ? 25.sp : null,
              child: CircularProgressIndicator(
                color: color ?? Theme.of(context).colorScheme.primary,
              ),
            ),
          )
        : Column(
            children: [
              heightSpace(topPadding),
              CircularProgressIndicator(
                color: color ?? Theme.of(context).colorScheme.primary,
              ),
            ],
          );
  } else {
    return topPadding == null
        ? Center(
            child: CupertinoActivityIndicator(
              color: color ?? Theme.of(context).colorScheme.primary,
              radius: radius ?? 20.sp,
            ),
          )
        : Column(
            children: [
              heightSpace(topPadding),
              CupertinoActivityIndicator(
                color: color ?? Theme.of(context).colorScheme.primary,
                radius: radius ?? 20.sp,
              ),
            ],
          );
  }
}

Widget myExpandedLoadingIndicator(
  BuildContext context, {
  Color? color,
  double? radius,
}) {
  if (Platform.isAndroid) {
    return Expanded(
      child: Center(
        child: CircularProgressIndicator(
          color: color ?? Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  } else {
    return Expanded(
      child: Center(
        child: CupertinoActivityIndicator(
          color: color ?? Theme.of(context).colorScheme.primary,
          radius: radius ?? 20.sp,
        ),
      ),
    );
  }
}

showDailogWithLoadingIndecator(BuildContext context) async {
  return showDialog(
    useSafeArea: true,
    //barrierDismissible: false,
    context: context,
    builder: (context) => myLoadingIndicator(context),
  );
}
