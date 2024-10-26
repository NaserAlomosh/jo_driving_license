import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jo_driving_license/core/constants/dimentions.dart';
import 'package:jo_driving_license/core/helper/extensions.dart';
import 'package:jo_driving_license/core/helper/spacing.dart';
import 'package:jo_driving_license/core/widgets/buttons/custom_button.dart';
import 'package:jo_driving_license/core/widgets/general/custom_text.dart';
import 'package:jo_driving_license/features/questions/view/questions_view.dart';

import '../../../core/constants/image_path.dart';

class FinalExamView extends StatelessWidget {
  const FinalExamView({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GeneralConst.horizontalPadding,
        vertical: GeneralConst.horizontalPadding,
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) =>
            SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: tr('rememberTheFollowingInstructions'),
                    fontSize: 26,
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 20.h),
                  Instruction(text: 'timeOfExamIs60Minutes'),
                  Instruction(text: 'youCanGet6WrongAnswers'),
                  const Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      height: 220.h,
                      AppImage.policeManInstructions,
                    ),
                  ),
                  heightSpace(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: tr('andNeverForgetWeBelieveInYou'),
                        fontSize: 28,
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const Spacer(),
                  CustomButton(
                    fontSize: 20.sp,
                    title: tr('startNow'),
                    onPressed: () {
                      context.push(
                        const QuestionsView(countRandomQuestions: 5),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Instruction extends StatelessWidget {
  const Instruction({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          height: 30.h,
          AppImage.carWheel,
        ),
        SizedBox(width: 5),
        CustomText(
          text: tr(text),
          fontSize: 20,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ],
    );
  }
}
