import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jo_driving_license/core/constants/dimentions.dart';
import 'package:jo_driving_license/core/helper/extensions.dart';
import 'package:jo_driving_license/core/widgets/buttons/custom_button.dart';

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
      child: Column(
        children: [
          CustomText(
            text: tr('you will test all questions'),
            fontSize: 20.sp,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          CustomText(
            text: tr('are you ready'),
            fontSize: 20.sp,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          CustomButton(
            title: tr('startNow'),
            onPressed: () {
              context.push(const QuestionsView());
            },
          ),
        ],
      ),
    );
  }
}
