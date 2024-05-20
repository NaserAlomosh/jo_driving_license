import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jo_driving_license/core/constants/dimentions.dart';
import 'package:jo_driving_license/core/helper/extensions.dart';
import 'package:jo_driving_license/core/widgets/general/custom_text.dart';
import 'package:jo_driving_license/features/home/view_model/cubit.dart';
import 'package:jo_driving_license/features/questions/view/questions_view.dart';
import 'package:jo_driving_license/features/score/view/exam_score_view.dart';
import 'package:jo_driving_license/features/score/view/level_score_view.dart';
import '../../../core/constants/image_path.dart';
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
      height: 150.h,
      child: Card(
        color: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20.h,
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  Positioned(
                    top: -3,
                    left: 7,
                    child: SvgPicture.asset(
                      AppImage.policeManRun,
                      height: 107.h,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    // bottom: 2.8,
                    // left: 18.9,
                    child: SvgPicture.asset(
                      AppImage.policeManRun,
                      height: 130.h,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        height: 1.5.h,
                        text: tr('putYourSeatBelt'),
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                      const Row(
                        children: [],
                      )
                    ],
                  ),
                  CustomText(
                    text: tr('areYouReadyForYourDrivingLicence'),
                    fontSize: 16,
                    height: 2.h,
                    fontWeight: FontWeight.w100,
                  ),
                ],
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
                      child: CircleAvatar(
                        radius: 45.sp,
                        child: Center(
                          child: CustomText(
                            textAlign: TextAlign.center,
                            text: cubit.quizzes[index]?.name ?? '',
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
