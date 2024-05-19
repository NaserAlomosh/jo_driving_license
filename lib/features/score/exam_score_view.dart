import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jo_driving_license/core/constants/dimentions.dart';
import 'package:jo_driving_license/core/constants/image_path.dart';
import 'package:jo_driving_license/core/helper/spacing.dart';
import 'package:jo_driving_license/core/widgets/buttons/custom_button.dart';
import 'package:jo_driving_license/core/widgets/general/custom_text.dart';

class ExamScoreView extends StatelessWidget {
  const ExamScoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: GeneralConst.horizontalPadding, vertical: 30.h),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ribbon(context),
              policeMan(context),
              score(context),
              CustomButton(
                title: tr('continue').toUpperCase(),
                fontSize: 20,
                fontWeight: FontWeight.w700,
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }

  score(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 120.w,
          height: 120.w,
          padding: EdgeInsets.all(10.sp),
          decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(
                25,
              )),
          child: Column(
            children: [
              CustomText(
                text: tr('correct'),
                color: Theme.of(context).colorScheme.onBackground,
              ),
              CustomText(
                text: tr('47'),
                fontSize: 30.sp,
                fontWeight: FontWeight.w900,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ],
          ),
        ),
        Container(
          width: 120.w,
          height: 120.w,
          padding: EdgeInsets.all(10.sp),
          decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(
                25,
              )),
          child: Column(
            children: [
              CustomText(
                text: tr('wrong'),
                color: Theme.of(context).colorScheme.onBackground,
              ),
              CustomText(
                text: tr('3'),
                fontSize: 30.sp,
                fontWeight: FontWeight.w900,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ],
          ),
        ),
        Container(
          width: 120.w,
          height: 120.w,
          padding: EdgeInsets.all(10.sp),
          decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(
                25,
              )),
          child: Column(
            children: [
              CustomText(
                text: tr('yourScore'),
                color: Theme.of(context).colorScheme.onBackground,
              ),
              CustomText(
                text: tr('98%'),
                fontSize: 30.sp,
                fontWeight: FontWeight.w900,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Padding policeMan(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ribbon(context),
          heightSpace(25.h),
          Row(
            children: [
              ribbon(context),
              SvgPicture.asset(
                AppImage.policeManHappy,
                height: 200.h,
                // width: 250.w,
              ),
            ],
          ),

          CustomText(
            text: tr('Congratulations!'),
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onBackground,
          ),

          CustomText(
            text: tr('Naser, go for your licence.'),
            fontSize: 14,
            textAlign: TextAlign.center,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          // SizedBox(
          //   height: 160.h,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Align(
          //         alignment: Alignment.bottomLeft,
          //         child: Icon(
          //           Icons.star,
          //           size: 75,
          //           color: Theme.of(context).colorScheme.tertiary,
          //         ),
          //       ),
          //       Align(
          //         alignment: Alignment.topCenter,
          //         child: Icon(
          //           Icons.star,
          //           size: 135,
          //           color: Theme.of(context).colorScheme.tertiary,
          //         ),
          //       ),
          //       Align(
          //         alignment: Alignment.bottomLeft,
          //         child: Icon(
          //           Icons.star,
          //           size: 75,
          //           color: Theme.of(context).colorScheme.tertiary,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  ribbon(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.w),
          child: SvgPicture.asset(
            AppImage.fireworks,
            height: 80.h,
            // ignore: deprecated_member_use
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),

            // width: 250.w,
          ),
        ),
      ],
    );
  }
}
