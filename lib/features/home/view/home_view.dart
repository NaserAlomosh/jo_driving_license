import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jo_driving_license/core/constants/dimentions.dart';
import 'package:jo_driving_license/core/helper/extensions.dart';
import 'package:jo_driving_license/core/widgets/general/custom_text.dart';
import 'package:jo_driving_license/features/home/view_model/cubit.dart';
import 'package:jo_driving_license/features/questions/view/quistions_view.dart';
import 'package:jo_driving_license/features/score/exam_score_view.dart';
import 'package:jo_driving_license/features/score/level_score_view.dart';

import '../../../core/helper/spacing.dart';
import '../../../core/widgets/error_widget/error_widget.dart';
import '../../../core/widgets/general/custom_loading.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getQuizzezNameCubit(),
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: GeneralConst.horizontalPadding),
        child: Column(
          children: [
            //will remove this Row later
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      context.push(const LevelScoreView());
                    },
                    icon: const Icon(Icons.star)),
                IconButton(
                    onPressed: () {
                      context.push(const ExamScoreView());
                    },
                    icon: const Icon(Icons.star)),
              ],
            ),
            _getCard(context),
            heightSpace(20),
            _getListQuizzes(),
          ],
        ),
      ),
    );
  }

  Widget _getCard(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20.h,
            horizontal: 20.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    height: 1.5.h,
                    // text: 'الاختبار النظري لرخصة القيادة',
                    text: tr('putYourSeatBelt'),
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    // color: Theme.of(context).colorScheme.onSecondary,
                  ),
                  Row(
                    children: [
                      // Image.asset(
                      //   AppImage.countryImage,
                      //   height: 30.sp,
                      // ),
                      // widthSpace(16),
                      // Image.asset(
                      //   AppImage.card,
                      //   height: 30.sp,
                      //   color: Theme.of(context).colorScheme.onPrimary,
                      // ),
                    ],
                  )
                ],
              ),
              CustomText(
                // text: 'قم بفحص معلوماتك قبل الذهاب الى اختبار رخصة القيادة',
                text: tr('areYouReadyForYourDrivingLicence'),
                fontSize: 16,
                height: 2.h,
                fontWeight: FontWeight.w100,
                // color: Theme.of(context).colorScheme.onPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getListQuizzes() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final cubit = context.read<HomeCubit>();
            if (state is HomeLoading) {
              return myLoadingIndicator(context);
            } else if (state is HomeError) {
              return CustomErrorWidget(msg: state.error);
            } else {
              return ListView.separated(
                separatorBuilder: (context, index) => heightSpace(10),
                itemBuilder: (context, index) {
                  return Align(
                    alignment: (index % 2 == 0)
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        context.push(
                          QuistionsView(
                            quizId: cubit.quizzes[index]?.id ?? '',
                            levelName: cubit.quizzes[index]?.name ?? '',
                          ),
                        );
                      },
                      child:
                          //CircleAvatar(
                          Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(70.sp)),
                        // radius: 70.sp,
                        // backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Center(
                          child: CustomText(
                            textAlign: TextAlign.center,
                            text: cubit.quizzes[index]?.name ?? '',
                            // color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: cubit.quizzes.length,
              );
            }
          },
        ),
      ),
    );
  }
}
