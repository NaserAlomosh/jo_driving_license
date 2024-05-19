import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jo_driving_license/core/constants/dimentions.dart';
import 'package:jo_driving_license/core/constants/image_path.dart';
import 'package:jo_driving_license/core/widgets/buttons/custom_button.dart';
import 'package:jo_driving_license/core/widgets/general/custom_text.dart';

class LevelScoreView extends StatelessWidget {
  const LevelScoreView({super.key});

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
              ribbon(),
              stars(context),
              score(context),
              CustomText(
                text: tr(
                    'Congratulations on your incredible win! Your hard work and perseverance have truly paid off!'),
                fontSize: 12,
                textAlign: TextAlign.center,
                color: Theme.of(context).colorScheme.onBackground,
              ),
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

  Column score(BuildContext context) {
    return Column(
      children: [
        CustomText(
          text: tr('yourScore'),
          color: Theme.of(context).colorScheme.onBackground,
        ),
        CustomText(
          text: tr('98%'),
          fontSize: 60.sp,
          fontWeight: FontWeight.w900,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ],
    );
  }

  Padding stars(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        children: [
          CustomText(
            text: tr('Naser you complete level 1'),
            fontSize: 18,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          SizedBox(
            height: 160.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Icon(
                    Icons.star,
                    size: 75,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Icon(
                    Icons.star,
                    size: 135,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Icon(
                    Icons.star,
                    size: 75,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SizedBox ribbon() {
    return SizedBox(
      height: 100,
      child: Stack(
        children: [
          SvgPicture.asset(
            AppImage.greenRibbon,
            color: Colors.green.shade300,
          ),
          Align(
            alignment: const Alignment(0, -0.2),
            child: CustomText(
              text: tr('Complete').toUpperCase(),
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}