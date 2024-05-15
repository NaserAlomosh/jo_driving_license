import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helper/get_device_type.dart';
import 'custom_text.dart';

PreferredSize customAppBar(
  BuildContext context, {
  String? title,
  void Function()? onTapActionIcon,
  void Function()? onTapBackIcon,
  bool? removeBackIcon,
  bool? removeActionIcon,
  Widget? leading,
  Widget? actionIcon,
  bool? centerTitle,
}) {
  bool isTablet = checkDeviceIsTaplet(context);
  return PreferredSize(
    preferredSize: Size.fromHeight(48.h),
    child: AppBar(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      leading: leading ??
          ((removeBackIcon ?? false)
              ? null
              : InkWell(
                  onTap: onTapBackIcon ??
                      () {
                        Navigator.pop(context);
                      },
                  borderRadius: BorderRadius.circular(100.sp),
                  child: Icon(
                    Icons.arrow_back,
                    size: isTablet ? 16.sp : 20.sp,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                )),
      actions: [
        (removeActionIcon ?? false)
            ? const SizedBox.shrink()
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: actionIcon ??
                    InkWell(
                      borderRadius: BorderRadius.circular(100.w),
                      onTap: onTapActionIcon,
                      child: Icon(
                        Icons.more_vert,
                        color: Theme.of(context).colorScheme.onSecondary,
                        size: isTablet ? 18.sp : 24.sp,
                      ),
                    ),
              ),
      ],
      centerTitle: centerTitle,
      title: CustomText(
        text: title ?? '',
        color: Theme.of(context).colorScheme.onSecondary,
        fontSize: 16,
      ),
    ),
  );
}
