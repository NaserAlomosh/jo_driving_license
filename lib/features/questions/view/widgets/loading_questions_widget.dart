import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/dimentions.dart';
import '../../../../core/constants/image_path.dart';
import '../../../../core/helper/spacing.dart';
import '../../../../core/widgets/animated/animated_widgets/animation_opacity_color_widget.dart';
import '../../../../core/widgets/buttons/custom_button.dart';
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
                    height: 100.w,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                heightSpace(8),
                heightSpace(8),
                _getListAnswers(),
                _getNextButton(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _getNextButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        policeImage(),
        CustomButton(
          background: Colors.grey[300],
          title: '',
          fontSize: 20,
          onPressed: () {},
        ),
      ],
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

  ClipRRect policeImage() {
    return ClipRRect(
      child: Align(
        alignment: Alignment.topLeft, // Adjust alignment as needed
        widthFactor: 1, // Fraction of the original width
        heightFactor: 0.7, // Fraction of the original height
        child: SizedBox(
          height: 250.w,
          width: 150.w,
          child: SvgPicture.asset(
            AppImage.policeManWait,
            colorFilter: const ColorFilter.mode(
              Color(0xFFE0E0E0),
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
