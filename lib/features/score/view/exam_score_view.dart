import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jo_driving_license/core/constants/dimentions.dart';
import 'package:jo_driving_license/core/constants/image_path.dart';
import 'package:jo_driving_license/core/widgets/buttons/custom_button.dart';
import 'package:jo_driving_license/core/widgets/general/custom_text.dart';

import '../widget/score_container.dart';

class ExamScoreView extends StatelessWidget {
  const ExamScoreView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isSuccess = true;
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
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              policeManAndFireworks(context, isSuccess),
              congratulations(isSuccess, context),
              score(context),
              continueButton()
            ],
          ),
        ),
      ),
    );
  }

  policeManAndFireworks(BuildContext context, bool isSuccess) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 300.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: SvgPicture.asset(
                  isSuccess ? AppImage.fireworks : AppImage.motivationHand,
                  height: 90.h,
                  // ignore: deprecated_member_use
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SvgPicture.asset(
                  AppImage.policeManHappy,
                  height: 260.h,
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: SvgPicture.asset(
                  isSuccess ? AppImage.fireworks : AppImage.motivationHand,
                  height: 90.h,
                  // ignore: deprecated_member_use
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  congratulations(bool isSuccess, BuildContext context) {
    return Column(
      children: [
        CustomText(
          text: isSuccess ? tr('congratulations') : tr('neverGiveUp'),
          fontSize: 30.sp,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        CustomText(
          text: isSuccess
              ? 'Naser, ${tr('goForYourLicence')}'
              : 'Naser, ${tr('tryAgain.')} ${tr('and')} ${tr('goForYourLicence')}',
          fontSize: 18,
          textAlign: TextAlign.center,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ],
    );
  }

  score(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ScoreContainer(
          title: 'corrects',
          score: '47',
          colorContainer:
              Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
        ScoreContainer(
          title: 'wrongs',
          score: '3',
          colorContainer:
              Theme.of(context).colorScheme.primary.withOpacity(0.33),
        ),
        ScoreContainer(
          title: 'yourScore',
          score: '98%',
          colorContainer:
              Theme.of(context).colorScheme.primary.withOpacity(0.45),
        ),
      ],
    );
  }

  continueButton() {
    return CustomButton(
      title: tr('continue').toUpperCase(),
      fontSize: 20,
      fontWeight: FontWeight.w700,
      onPressed: () {},
    );
  }
}