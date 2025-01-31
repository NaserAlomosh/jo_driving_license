import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../core/constants/image_path.dart';
import '../../../core/widgets/general/custom_text.dart';

class OnBoardingViewThree extends StatelessWidget {
  const OnBoardingViewThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.w),
            child: Column(
                mainAxisAlignment: MediaQuery.of(context).size.width < 800
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                    text: tr('onBoardingTitle3'),
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.center,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  const SizedBox(height: 10),
                  CustomText(
                    text: tr('onBoardingSubtitle3'),
                    fontSize: 18.sp,
                    textAlign: TextAlign.center,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  SizedBox(height: 50.w),
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        height: 300.w,
                        width: 300.w,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: MediaQuery.of(context).size.width > 800
                              ? BorderRadius.circular(200.h)
                              : BorderRadius.circular(150.h),
                        ),
                      ),
                      Lottie.asset(
                        AppImage.onBoardingBus,
                        height: 300.w,
                        width: 300.w,
                      ),
                    ],
                  ),
                ])),
      ),
    );
  }
}
