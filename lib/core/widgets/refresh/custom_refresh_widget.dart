import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget myRefreshIndicator(
  BuildContext context, {
  required Future<void> Function() onRefresh,
  required Widget child,
}) {
  return Padding(
    padding: EdgeInsets.only(top: 10.h),
    child: RefreshIndicator(
      onRefresh: onRefresh,
      color: Theme.of(context).colorScheme.primary,
      // Conditional rendering for platform-specific refresh indicator icon
      displacement: Platform.isIOS ? 0 : 40,
      // Set the size of the refresh indicator
      strokeWidth: Platform.isIOS ? 2 : 3,
      // Set the color of the refresh indicator
      // Set the background color of the refresh indicator
      notificationPredicate: (notification) {
        return notification.depth == 0;
      },
      // Set the notification predicate to control when the indicator appears
      semanticsLabel: 'Pull to refresh',
      // Set the semantics label for accessibility
      semanticsValue: 'true',
      // Set the semantics value for accessibility
      triggerMode: Platform.isIOS
          ? RefreshIndicatorTriggerMode.anywhere
          : RefreshIndicatorTriggerMode.onEdge,
      child: child,

      // Set the trigger mode based on the platform
    ),
  );
}
