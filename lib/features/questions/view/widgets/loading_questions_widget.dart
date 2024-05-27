import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/dimentions.dart';
import '../../../../core/helper/spacing.dart';
import '../../../../core/widgets/animated/animated_widgets/animation_opacity_color_widget.dart';
import '../../../../core/widgets/general/custom_text.dart';

class LoadingQuestionsWidget extends StatelessWidget {
  const LoadingQuestionsWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    return AnimationColorWidget(
      child: PageView.builder(
        controller: pageController,
        itemCount: 1,
        itemBuilder: (context, quistionIndex) {
          return Padding(
            padding: EdgeInsets.all(GeneralConst.horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                linearIndicator(context),
                heightSpace(15),
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                heightSpace(15),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 200.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                heightSpace(15),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 100.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                heightSpace(8),
                heightSpace(8),
                _getListAnswers(),
                Container(
                  width: double.infinity,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  LinearProgressIndicator linearIndicator(
    BuildContext context,
  ) {
    return LinearProgressIndicator(
      value: 8 / 80,
      minHeight: 12,
      backgroundColor: Colors.grey[300],
      borderRadius: BorderRadius.circular(10),
      valueColor: AlwaysStoppedAnimation<Color>(
        Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _getListAnswers() {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 15.h);
        },
        itemCount: 4,
        itemBuilder: (context, answerIndex) => Container(
          padding: EdgeInsets.symmetric(vertical: 15.h),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiaryContainer,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const CustomText(
            textAlign: TextAlign.center,
            text: '',
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
