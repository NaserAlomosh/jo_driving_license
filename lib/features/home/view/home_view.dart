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
import '../../../core/widgets/animated/animated_widgets/animation_opacity_color_widget.dart';
import '../../../core/widgets/error_widget/error_widget.dart';

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
        height: checkDeviceIsTaplet(context)
            ? 300.h
            : MediaQuery.of(context).size.height * 0.18,
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
                    // SvgPicture.asset(
                    //   AppImage.policeManRun,
                    //   height: checkDeviceIsTaplet(context) ? 207.h : 103.h,
                    //   color: Colors.white,
                    //   fit: BoxFit.contain,
                    // ),
                    SvgPicture.asset(
                      AppImage.policeManRun,
                      height: checkDeviceIsTaplet(context) ? 230.h : 130.h,
                      fit: BoxFit.contain,
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
              return _getLoadingListQuizzes();
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
                          : levelQuestions(context, index, cubit),
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



  Widget _getLoadingListQuizzes() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return ListView.separated(
            itemCount: 6,
            separatorBuilder: (context, index) => heightSpace(0.h),
            itemBuilder: (context, index) {
              return Align(
                alignment: (index % 2 == 0)
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: index == 7 - 1
                    ? finalExam(context)
                    : AnimationColorWidget(child: loading(context, index)),
              );
            },
          );
        },
      ),
    );
  }

  Widget loading(BuildContext context, int index) {
    return Stack(
      children: [
        Container(
          width: 300.w,
          padding: EdgeInsets.only(bottom: 40.h),
          child: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            radius: 60.sp,
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



  Stack levelQuestions(BuildContext context, int index, HomeCubit cubit) {
    List<String>? words = cubit.quizzes[index]?.name!.split(' ');

    return Stack(
      children: [
        Container(
          width: checkDeviceIsTaplet(context)
              ? MediaQuery.of(context).size.height * 0.3
              : MediaQuery.of(context).size.height * 0.3,
          height: 140.h,
          padding: EdgeInsets.only(bottom: 40.h),
          child: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            radius: checkDeviceIsTaplet(context) ? 70.w : 50.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: words!.map((word) => Text(word)).toList(),
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

  SizedBox finalExam(BuildContext context) {
    return SizedBox(
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
