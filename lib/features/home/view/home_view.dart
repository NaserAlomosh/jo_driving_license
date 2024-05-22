// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jo_driving_license/core/constants/dimentions.dart';
import 'package:jo_driving_license/core/helper/extensions.dart';
import 'package:jo_driving_license/core/widgets/general/custom_text.dart';
import 'package:jo_driving_license/features/botton_nav_bar/botton_nav_bar.dart';
import 'package:jo_driving_license/features/home/view_model/cubit.dart';
import 'package:jo_driving_license/features/questions/view/questions_view.dart';
import '../../../core/constants/image_path.dart';
import '../../../core/helper/get_device_type.dart';
import '../../../core/helper/spacing.dart';
import '../../../core/widgets/error_widget/error_widget.dart';
import '../../../core/widgets/general/custom_loading.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getQuizzezNameCubit(),
      child: Column(
        children: [
          heightSpace(20),
          _getCard(context),
          heightSpace(20),
          _getListQuizzes(),
        ],
      ),
    );
  }

  Widget _getCard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: checkDeviceIsTaplet(context)
            ? GeneralConst.horizontalPaddingTablet
            : GeneralConst.horizontalPadding,
      ),
      child: SizedBox(
        width: double.infinity,
        height: checkDeviceIsTaplet(context) ? 300.h : 150.w,
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
                      top: -3.h,
                      left: 7.w,
                      child: SvgPicture.asset(
                        AppImage.policeManRun,
                        height: checkDeviceIsTaplet(context) ? 207.h : 107.h,
                        color: Colors.white,
                      ),
                    ),
                    SvgPicture.asset(
                      AppImage.policeManRun,
                      height: checkDeviceIsTaplet(context) ? 230.h : 130.h,
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
                          fontSize: 18.sp,
                        ),
                        const Row(
                          children: [],
                        )
                      ],
                    ),
                    CustomText(
                      text: tr('areYouReadyForYourDrivingLicence'),
                      fontSize: 16.sp,
                      height: 2.h,
                      fontWeight: FontWeight.w100,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getListQuizzes() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final cubit = context.read<HomeCubit>();
            if (state is HomeLoading) {
              return myLoadingIndicator(context);
            } else if (state is HomeError) {
              return CustomErrorWidget(msg: state.error);
            } else {
              return ListView.separated(
                itemCount: cubit.quizzes.length,
                separatorBuilder: (context, index) => heightSpace(0.h),
                itemBuilder: (context, index) {
                  return Align(
                    alignment: (index % 2 == 0)
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        index == cubit.quizzes.length - 1
                            ? context.pushReplacement(
                                const BottomNavBarApp(index: 2))
                            : context.push(
                                QuistionsView(
                                  quizId: cubit.quizzes[index]?.id ?? '',
                                  levelName: cubit.quizzes[index]?.name ?? '',
                                ),
                              );
                      },
                      child: index == cubit.quizzes.length - 1
                          ? finalExam(context)
                          : levelExam(context, index, cubit),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Stack levelExam(BuildContext context, int index, HomeCubit cubit) {
    return Stack(
      children: [
        Container(
          width: 300.w,
          height: 140.h,
          padding: EdgeInsets.only(bottom: 40.h),
          child: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            radius: checkDeviceIsTaplet(context) ? 70.w : 50.w,
            child: index == cubit.quizzes.length - 1
                //final exam
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.emoji_events,
                        size: checkDeviceIsTaplet(context) ? 105.w : 35.w,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        child: CustomText(
                          textAlign: TextAlign.center,
                          text: tr('finalExam'),
                          // text: cubit.quizzes[index]?.name ?? '',
                        ),
                      )
                    ],
                  )
                //level name
                : CustomText(
                    textAlign: TextAlign.center,
                    text: cubit.quizzes[index]?.name ?? '',
                    fontSize: 20.sp,
                  ),
          ),
        ),
        (index % 2 == 0)
            ? Positioned(
                bottom: -5.h,
                left: 20,
                child: SvgPicture.asset(
                  AppImage.currvedLineUp,
                  height: 130.h,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                ),
              )
            : Positioned(
                bottom: 5.h,
                right: 20.w,
                child: SvgPicture.asset(
                  AppImage.currvedLineDown,
                  height: 130.h,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                ),
              )
      ],
    );
  }

  Container finalExam(BuildContext context) {
    return Container(
      width: 300.w,
      height: 140.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppImage.trophy,
            height: 110.h,
            // width: 100.w,
          ),
          // Icon(
          //   Icons.emoji_events,
          //   size: 70.sp,
          //   color: Theme.of(context).colorScheme.tertiary,
          // ),
          // Center(
          //   child: CustomText(
          //     textAlign: TextAlign.center,
          //     text: tr('finalExam'),
          //     color: Theme.of(context).colorScheme.onBackground,
          //   ),
          // )
        ],
      ),
    );
  }
}
