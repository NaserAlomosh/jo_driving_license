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
import 'package:jo_driving_license/features/score/view/exam_score_view.dart';

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
                itemCount: cubit.quizzes.length,
                separatorBuilder: (context, index) => heightSpace(10),
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 100,
                    child: Align(
                      alignment: index <= 2
                          ? Alignment(-0.5 * index.toDouble(), 0)
                          : index >= 2 && index <= 4
                              ? Alignment(index.toDouble() - 3, 0)
                              : index >= 4
                                  ? Alignment((index.toDouble() * -0.6) + 3, 0)
                                  : const Alignment(0, 0),
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              index == cubit.quizzes.length - 1
                                  ? context.pushReplacement(
                                      const BottomNavBarApp(index: 1))
                                  : context.push(
                                      QuistionsView(
                                        quizId: cubit.quizzes[index]?.id ?? '',
                                        levelName:
                                            cubit.quizzes[index]?.name ?? '',
                                      ),
                                    );
                            },
                            child: index == cubit.quizzes.length - 1
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.emoji_events,
                                        size: 70,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                      ),
                                      CustomText(
                                        textAlign: TextAlign.center,
                                        text: tr('finalExam'),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      )
                                    ],
                                  )
                                : CircleAvatar(
                                    backgroundColor: index ==
                                            cubit.quizzes.length - 1
                                        ? Colors.amber.shade800
                                        : Theme.of(context).colorScheme.primary,
                                    radius: 50.sp,
                                    child: index == cubit.quizzes.length - 1
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.emoji_events,
                                                size: 35,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                child: CustomText(
                                                  textAlign: TextAlign.center,
                                                  text: tr('finalExam'),

                                                  // text: cubit.quizzes[index]?.name ?? '',
                                                ),
                                              )
                                            ],
                                          )
                                        : CustomText(
                                            textAlign: TextAlign.center,
                                            text: cubit.quizzes[index]?.name ??
                                                '',
                                          ),
                                  ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(right: 100.w),
                          //   child: Transform.rotate(
                          //     angle: 90,
                          //     child: SvgPicture.asset(
                          //       AppImage.curvedLine,
                          //       height: 80.h,
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  );
                  // : Container(
                  //     height: 100,
                  //     width: 200,
                  //     child: Align(
                  //       alignment: (index % 2 == 0)
                  //           ? Alignment.centerRight
                  //           : Alignment.centerLeft,
                  //       child: Stack(
                  //         children: [
                  //           GestureDetector(
                  //             onTap: () {
                  //               context.push(
                  //                 QuistionsView(
                  //                   quizId: cubit.quizzes[index]?.id ?? '',
                  //                   levelName:
                  //                       cubit.quizzes[index]?.name ?? '',
                  //                 ),
                  //               );
                  //             },
                  //             child: CircleAvatar(
                  //               radius: 45.sp,
                  //               child: Center(
                  //                 child: CustomText(
                  //                   textAlign: TextAlign.center,
                  //                   text: cubit.quizzes[index]?.name ?? '',
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //           // Positioned(
                  //           //   left: 10,
                  //           //   child: Transform.rotate(
                  //           //     angle: 90,
                  //           //     child: SvgPicture.asset(
                  //           //       AppImage.curvedLine,
                  //           //       height: 80.h,
                  //           //     ),
                  //           //   ),
                  //           // ),
                  //         ],
                  //       ),
                  //     ),
                  //   );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
