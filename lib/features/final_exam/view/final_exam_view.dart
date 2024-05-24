import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jo_driving_license/core/constants/dimentions.dart';
import 'package:jo_driving_license/core/widgets/buttons/custom_button.dart';
import 'package:jo_driving_license/core/widgets/general/custom_text.dart';

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
          CustomText(
            text: tr('putYourSeatBelt'),
            fontSize: 20.sp,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          SizedBox(height: 20.h),
          Column(
            children: [
              Row(
                children: [
                  CustomText(
                    text: tr('Remember the following instructions'),
                    fontSize: 20.sp,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ],
              ),
              CustomText(
                text: tr('Remember the following instructions'),
                fontSize: 20.sp,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              CustomText(
                text: tr('Remember the following instructions'),
                fontSize: 20.sp,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              CustomText(
                text: tr('Remember the following instructions'),
                fontSize: 20.sp,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ],
          ),
          const Spacer(flex: 3),
          Container(
            padding: EdgeInsets.symmetric(vertical: 0.h),
            child: CustomButton(
              title: tr('startNow'),
              onPressed: () {
                // context.push(const FinalExamViewQuestions());
              },
            ),
          ),
          const Spacer(flex: 5),
        ],
      ),
    );
  }
}
