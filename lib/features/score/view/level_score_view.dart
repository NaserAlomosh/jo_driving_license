import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jo_driving_license/core/constants/dimentions.dart';
import 'package:jo_driving_license/core/constants/image_path.dart';
import 'package:jo_driving_license/core/helper/extensions.dart';
import 'package:jo_driving_license/core/helper/spacing.dart';
import 'package:jo_driving_license/core/widgets/buttons/custom_button.dart';
import 'package:jo_driving_license/core/widgets/general/custom_text.dart';
import 'package:jo_driving_license/features/botton_nav_bar/botton_nav_bar.dart';

import '../widget/score_container.dart';

class LevelScoreView extends StatelessWidget {
  final int correctsNumber;
  final int wrongsNumber;
  final double scoreNumber;
  const LevelScoreView({
    super.key,
    required this.correctsNumber,
    required this.wrongsNumber,
    required this.scoreNumber,
  });

  @override
  Widget build(BuildContext context) {
    bool isSuccess = false;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: GeneralConst.horizontalPadding, vertical: 30.h),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ribbon(isSuccess),
                stars(context, isSuccess),
                heightSpace(30),
                _score(
                  context,
                  correctsNumber: correctsNumber,
                  wrongsNumber: wrongsNumber,
                  score: scoreNumber,
                ),
                heightSpace(30),
                supportQoute(isSuccess, context),
                heightSpace(40),
                continueButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  CustomButton continueButton(BuildContext context) {
    return CustomButton(
      title: tr('continue').toUpperCase(),
      fontSize: 20,
      fontWeight: FontWeight.w700,
      onPressed: () {
        context.pushReplacementBottomToTop(const BottomNavBarApp());
      },
    );
  }

  CustomText supportQoute(bool isSuccess, BuildContext context) {
    return CustomText(
      text: isSuccess ? tr('supportQouteSuccess1') : tr('supportQouteFail1'),
      fontSize: 16,
      textAlign: TextAlign.center,
      color: Theme.of(context).colorScheme.onBackground,
    );
  }

  _score(
    BuildContext context, {
    required int correctsNumber,
    required int wrongsNumber,
    required double score,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ScoreContainer(
          title: 'corrects',
          score: '$correctsNumber',
          colorContainer:
              Theme.of(context).colorScheme.onError.withOpacity(0.2),
        ),
        ScoreContainer(
          title: 'wrongs',
          score: '$wrongsNumber',
          colorContainer: Theme.of(context).colorScheme.error.withOpacity(0.3),
        ),
        ScoreContainer(
          title: 'yourScore',
          score: '$score%',
          colorContainer:
              Theme.of(context).colorScheme.primary.withOpacity(0.4),
        ),
      ],
    );
  }

  Padding stars(BuildContext context, bool isSuccess) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        children: [
          CustomText(
            text: isSuccess
                ? 'Naser, ${tr('you complete')} level 1'
                : 'Naser, ${tr('neverGiveUp')}',
            fontSize: 20,
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: FontWeight.w700,
          ),
          heightSpace(10),
          SizedBox(
            height: isSuccess ? 160.h : 260.h,
            child: isSuccess
                ? Row(
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
                  )
                : SvgPicture.asset(
                    AppImage.policeManRun,
                  ),
          ),
        ],
      ),
    );
  }

  SizedBox ribbon(bool isSuccess) {
    return SizedBox(
      height: 100,
      child: Stack(
        children: [
          SvgPicture.asset(
            AppImage.greenRibbon,
            // ignore: deprecated_member_use
            color: isSuccess ? Colors.green.shade300 : Colors.blueGrey.shade300,
          ),
          Align(
            alignment: const Alignment(0, -0.2),
            child: CustomText(
              text: isSuccess
                  ? tr('Complete').toUpperCase()
                  : tr('tryAgain').toUpperCase(),
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
