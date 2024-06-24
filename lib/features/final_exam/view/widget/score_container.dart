import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jo_driving_license/core/helper/get_device_type.dart';

import '../../../../core/widgets/general/custom_text.dart';

class ScoreContainer extends StatelessWidget {
  const ScoreContainer({
    super.key,
    required this.title,
    required this.score,
    required this.colorContainer,
  });

  final String title;
  final String score;
  final Color colorContainer;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: 120.w,
        height: 110.w,
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          color: colorContainer,
          border: Border.all(color: colorContainer),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: tr(title),
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            Container(
              height: checkDeviceIsTaplet(context) ? 180 : 50.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.background,
              ),
              child: Center(
                child: CustomText(
                  text: score,
                  textAlign: TextAlign.center,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
