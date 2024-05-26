import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jo_driving_license/core/constants/dimentions.dart';
import 'package:jo_driving_license/core/helper/extensions.dart';
import 'package:jo_driving_license/core/widgets/buttons/custom_button.dart';
import 'package:jo_driving_license/core/widgets/general/custom_text.dart';
import 'package:jo_driving_license/features/questions/view/questions_view.dart';

class FinalExamView extends StatelessWidget {
  const FinalExamView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: GeneralConst.horizontalPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          CustomText(
            text: tr('areYouReadyForYourDrivingLicence'),
            fontSize: 30.sp,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          SizedBox(height: 20.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomText(
                    text: tr('rememberTheFollowingInstructions'),
                    fontSize: 20.sp,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ],
              ),
              CustomText(
                text: tr('timeOfExamIs60Minutes'),
                fontSize: 20.sp,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              CustomText(
                text: tr('youCanGet6WrongAnswers'),
                fontSize: 20.sp,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              CustomText(
                text: tr('andNeverForgetWeBelieveInYou'),
                fontSize: 20.sp,
                color: Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.w900,
              ),
            ],
          ),
          const Spacer(flex: 3),
          Container(
            padding: EdgeInsets.symmetric(vertical: 0.h),
            child: CustomButton(
              title: tr('startNow'),
              onPressed: () {
                context.push(const QuestionsView(countRandomQuestions: 5));
              },
            ),
          ),
          const Spacer(flex: 5),
        ],
      ),
    );
  }
}
