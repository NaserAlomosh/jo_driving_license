import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jo_driving_license/core/helper/spacing.dart';
import 'package:jo_driving_license/core/widgets/error_widget/error_widget.dart';
import 'package:jo_driving_license/core/widgets/general/custom_text.dart';
import 'package:jo_driving_license/features/questions/view/widgets/get_ads.dart';
import 'package:jo_driving_license/features/questions/view/widgets/loading_questions_widget.dart';

import '../view_model/cubit.dart';
import 'widgets/count_of_questions.dart';
import 'widgets/timer_widget.dart';

class QuestionsView extends StatefulWidget {
  final String? quizId;
  final String? categoryName;
  final int? countRandomQuestions;

  const QuestionsView({
    super.key,
    this.quizId,
    this.categoryName,
    this.countRandomQuestions,
  });

  @override
  QuestionsViewState createState() => QuestionsViewState();
}

class QuestionsViewState extends State<QuestionsView> {
  bool isNavigating = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuistionsCubit()
        ..getQuistionsCubit(
          widget.quizId,
          widget.countRandomQuestions,
        ),
      child: PopScope(
        canPop: false,
        onPopInvoked: (_) async => await questionBackShowDiloge(context),
        child: Scaffold(
          bottomNavigationBar: GetAdsWidget(),
          appBar: _getAppBar(),
          body: SafeArea(
            child: BlocBuilder<QuistionsCubit, QuistionsState>(
              builder: (context, state) {
                final cubit = context.read<QuistionsCubit>();
                if (state is QuistionsLoading) {
                  return const LoadingQuestionsWidget();
                } else if (state is QuistionsError) {
                  return Center(child: CustomErrorWidget(msg: state.error));
                } else {
                  return QuestionsBody(cubit: cubit);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _getAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () async => await questionBackShowDiloge(context),
        child: Icon(
          Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
          size: 20.sp,
        ),
      ),
      title: CustomText(
        text: widget.categoryName ??
            (widget.countRandomQuestions == null
                ? tr('allQuestions')
                : tr('drivingLicenseExam')),
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: Theme.of(context).colorScheme.secondary,
      ),
      actions: [
        widget.countRandomQuestions != null ? TimerWidget() : SizedBox.shrink(),
        widthSpace(20),
      ],
    );
  }

  Future questionBackShowDiloge(BuildContext context) async {
    if (isNavigating) return;
    isNavigating = true;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          title: CustomText(
            text: tr('exitQuiz'),
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          content: CustomText(
            text: tr('areYouSureYouWantToExitTheQuiz'),
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          actionsAlignment: MainAxisAlignment.start,
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                isNavigating = false;
              },
              child: CustomText(
                text: tr('no'),
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Pop the dialog
                Navigator.of(context).pop(); // Pop the quiz screen
              },
              child: CustomText(
                text: tr('yes'),
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        );
      },
    );
    isNavigating = false;
  }
}
