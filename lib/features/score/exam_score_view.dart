import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jo_driving_license/core/constants/dimentions.dart';
import 'package:jo_driving_license/core/constants/image_path.dart';
import 'package:jo_driving_license/core/widgets/buttons/custom_button.dart';
import 'package:jo_driving_license/core/widgets/general/custom_text.dart';

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              policeManAndFireworks(context, isSuccess),
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
                  height: 80.h,
                  // ignore: deprecated_member_use
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SvgPicture.asset(
                  AppImage.policeManHappy,
                  height: 230.h,
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: SvgPicture.asset(
                  isSuccess ? AppImage.fireworks : AppImage.motivationHand,
                  height: 80.h,
                  // ignore: deprecated_member_use
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
        congratulations(isSuccess, context),
      ],
    );
  }

  congratulations(bool isSuccess, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Column(
        children: [
          CustomText(
            text: isSuccess ? tr('congratulations') : tr('neverGiveUp'),
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          CustomText(
            text: isSuccess
                ? 'Naser, ${tr('goForYourLicence')}'
                : 'Naser, ${tr('tryAgain.')} ${tr('and')} ${tr('goForYourLicence')}',
            fontSize: 14,
            textAlign: TextAlign.center,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ],
      ),
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
    return Container(
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
            fontWeight: FontWeight.w700,
          ),
          Container(
            height: 60.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.background,
            ),
            child: Center(
              child: CustomText(
                text: score,
                textAlign: TextAlign.center,
                fontSize: 30.sp,
                fontWeight: FontWeight.w900,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
