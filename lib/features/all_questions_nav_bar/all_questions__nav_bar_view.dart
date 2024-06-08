import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jo_driving_license/core/constants/dimentions.dart';
import 'package:jo_driving_license/core/helper/extensions.dart';
import 'package:jo_driving_license/core/widgets/buttons/custom_button.dart';

import '../../core/constants/image_path.dart';
import '../../core/widgets/general/custom_text.dart';
import '../questions/view/questions_view.dart';

class AllQuestionsNavBar extends StatelessWidget {
  const AllQuestionsNavBar({super.key});

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: tr('youWillTestAllQuestions'),
                    fontSize: 26,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  CustomText(
                    text: tr('areYouReady'),
                    fontSize: 26,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      height: 300.h,
                      AppImage.allQuestionsExamBackground,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Spacer(),
                  CustomButton(
                    title: tr('startNow'),
                    fontSize: 20.sp,
                    onPressed: () {
                      context.push(const QuestionsView());
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
