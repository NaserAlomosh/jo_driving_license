// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jo_driving_license/core/constants/dimentions.dart';
import 'package:jo_driving_license/core/helper/extensions.dart';
import 'package:jo_driving_license/core/widgets/general/custom_text.dart';
import 'package:jo_driving_license/core/widgets/refresh/custom_refresh_widget.dart';
import 'package:jo_driving_license/features/botton_nav_bar/botton_nav_bar.dart';
import 'package:jo_driving_license/features/home/view_model/cubit.dart';

import '../../../add_ads_helper.dart';
import '../../../core/constants/image_path.dart';
import '../../../core/helper/get_device_type.dart';
import '../../../core/helper/spacing.dart';
import '../../../core/widgets/animated/animated_widgets/animation_opacity_color_widget.dart';
import '../../../core/widgets/buttons/custom_button.dart';
import '../../../core/widgets/error_widget/error_widget.dart';
import '../../questions/view/questions_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getQuizzezNameCubit(),
      child: Column(
        children: [
          heightSpace(20),
          card(context),
          heightSpace(20),
          _getListQuizzes(),
        ],
      ),
    );
  }

  Padding card(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: GeneralConst.horizontalPadding),
      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.45,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                AppImage.carWithBackground,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.06),
            height: MediaQuery.of(context).size.width * 0.45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heightSpace(20),
                      CustomText(
                        height: 1.5.h,
                        text: tr('putYourSeatBelt'),
                        fontWeight: FontWeight.w900,
                        fontSize: 18.sp,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                      CustomText(
                        text: tr('areYouReadyForYourDrivingLicence'),
                        fontSize: 16.sp,
                        height: 2.h,
                        fontWeight: FontWeight.w200,
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width * 0.1,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: CustomButton(
                            borderRadius: 50,
                            background: Theme.of(context).colorScheme.tertiary,
                            elevation: 10,
                            title: tr('finalExam'),
                            fontSize: 14.sp,
                            textColor: Theme.of(context).colorScheme.primary,
                            onPressed: () {
                              context.pushReplacement(
                                  const BottomNavBarApp(index: 2));
                            },
                          ),
                        ),
                      ),
                      heightSpace(20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getListQuizzes() {
    return Expanded(
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();
          if (state is HomeLoading) {
            return _getLoadingListQuizzes();
          } else if (state is HomeError) {
            return CustomErrorWidget(msg: state.error);
          } else {
            return myRefreshIndicator(
              context,
              onRefresh: () async => cubit.getQuizzezNameCubit(),
              child: ListView.separated(
                itemCount: cubit.quizzes.length,
                separatorBuilder: (context, index) => SizedBox.shrink(),
                itemBuilder: (context, index) {
                  return Align(
                    alignment: (index % 2 == 0)
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        ADState().loadAd();

                        index == cubit.quizzes.length - 1
                            ? context.pushReplacement(
                                const BottomNavBarApp(index: 2))
                            : context.push(
                                QuestionsView(
                                  quizId: cubit.quizzes[index]?.id ?? '',
                                  categoryName:
                                      cubit.quizzes[index]?.name ?? '',
                                ),
                              );
                      },
                      child: index == cubit.quizzes.length - 1
                          ? finalExam(context)
                          : categoryQuestions(context, index, cubit),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  Widget _getLoadingListQuizzes() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return ListView.separated(
          itemCount: 4,
          separatorBuilder: (context, index) => SizedBox.shrink(),
          itemBuilder: (context, index) {
            return Align(
              alignment: (index % 2 == 0)
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: index == 7 - 1
                  ? finalExam(context)
                  : AnimationColorWidget(
                      child: loading(context, index),
                    ),
            );
          },
        );
      },
    );
  }

  Widget loading(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: checkDeviceIsTaplet(context) ? 100.w : 0,
      ),
      child: Stack(
        children: [
          Container(
            width: checkDeviceIsTaplet(context)
                ? MediaQuery.of(context).size.width * 0.5
                : MediaQuery.of(context).size.width * 0.7,
            padding: EdgeInsets.only(bottom: 40.h),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              radius: 70.sp,
            ),
          ),
          (index % 2 == 0)
              ? Positioned(
                  bottom: checkDeviceIsTaplet(context)
                      ? MediaQuery.of(context).size.height * -0.007
                      : MediaQuery.of(context).size.height * -0.002,
                  left: checkDeviceIsTaplet(context)
                      ? MediaQuery.of(context).size.height * 0.01
                      : MediaQuery.of(context).size.height * 0.01,
                  child: SvgPicture.asset(
                    AppImage.currvedLineUp,
                    height: checkDeviceIsTaplet(context)
                        ? MediaQuery.of(context).size.height * 0.18
                        : MediaQuery.of(context).size.height * 0.15,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.5),
                  ),
                )
              : Positioned(
                  bottom: 5.h,
                  right: 20.w,
                  child: SvgPicture.asset(
                    AppImage.currvedLineDown,
                    height: 130.h,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.5),
                  ),
                )
        ],
      ),
    );
  }

  Widget categoryQuestions(BuildContext context, int index, HomeCubit cubit) {
    List<String>? words = cubit.quizzes[index]?.name!.split(' ');
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: checkDeviceIsTaplet(context) ? 100.w : 0),
      child: Stack(
        children: [
          Stack(
            children: [
              Container(
                width: checkDeviceIsTaplet(context)
                    ? MediaQuery.of(context).size.width * 0.5
                    : MediaQuery.of(context).size.width * 0.7,
                padding: EdgeInsets.only(bottom: 40.h),
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  radius: 70.sp,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: words!
                        .map((word) => CustomText(
                              text: word,
                              fontSize: 17.sp,
                            ))
                        .toList(),
                  ),
                ),
              ),
              (index % 2 == 0)
                  ? Positioned(
                      bottom: checkDeviceIsTaplet(context)
                          ? MediaQuery.of(context).size.height * -0.007
                          : MediaQuery.of(context).size.height * -0.002,
                      left: checkDeviceIsTaplet(context)
                          ? MediaQuery.of(context).size.height * 0.01
                          : MediaQuery.of(context).size.height * 0.01,
                      child: SvgPicture.asset(
                        AppImage.currvedLineUp,
                        height: checkDeviceIsTaplet(context)
                            ? MediaQuery.of(context).size.height * 0.18
                            : MediaQuery.of(context).size.height * 0.15,
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.5),
                      ),
                    )
                  : Positioned(
                      bottom: 5.h,
                      right: 20.w,
                      child: SvgPicture.asset(
                        AppImage.currvedLineDown,
                        height: 130.h,
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.5),
                      ),
                    )
            ],
          ),
        ],
      ),
    );
  }

  Widget finalExam(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: checkDeviceIsTaplet(context) ? 100.w : 0),
      child: SizedBox(
        width: 300.w,
        height: MediaQuery.of(context).size.height * 0.17,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppImage.trophy,
                height: MediaQuery.of(context).size.height * 0.13
                // width: 100.w,
                ),
          ],
        ),
      ),
    );
  }
}
