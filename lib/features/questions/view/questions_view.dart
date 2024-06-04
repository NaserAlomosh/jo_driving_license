import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jo_driving_license/core/helper/extensions.dart';
import 'package:jo_driving_license/core/helper/spacing.dart';
import 'package:jo_driving_license/core/models/question_model.dart';
import 'package:jo_driving_license/core/widgets/buttons/custom_button.dart';
import 'package:jo_driving_license/core/widgets/error_widget/error_widget.dart';
import 'package:jo_driving_license/core/widgets/general/custom_network_image.dart';
import 'package:jo_driving_license/core/widgets/general/custom_text.dart';
import 'package:jo_driving_license/features/questions/view/category_score_view.dart';
import 'package:jo_driving_license/features/questions/view/widgets/loading_questions_widget.dart';

import '../../../core/constants/dimentions.dart';
import '../../../core/constants/image_path.dart';
import '../view_model/cubit.dart';
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
  final PageController _pageController = PageController();
  Map<int, Map<int, Color>> answerColors = {};
  List<bool> answersCorrectness = [];
  List<bool> answerSelected = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuistionsCubit()
        ..getQuistionsCubit(
          widget.quizId,
          widget.countRandomQuestions,
        ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: CustomText(
            text: widget.categoryName ??
                (widget.countRandomQuestions == null
                    ? tr('allQuestions')
                    : tr('drivingLicenseExam')),
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.secondary,
          ),
          actions: [
            widget.countRandomQuestions != null
                ? TimerWidget()
                : SizedBox.shrink(),
            widthSpace(20),
          ],
        ),
        body: SafeArea(
          child: BlocBuilder<QuistionsCubit, QuistionsState>(
            builder: (context, state) {
              final cubit = context.read<QuistionsCubit>();
              if (state is QuistionsLoading) {
                return const LoadingQuestionsWidget();
              } else if (state is QuistionsError) {
                return Center(child: CustomErrorWidget(msg: state.error));
              } else {
                return PageView.builder(
                  controller: _pageController,
                  itemCount: cubit.questions.length,
                  itemBuilder: (context, quistionIndex) {
                    log(cubit.questions[quistionIndex]!.image.toString());
                    final question = cubit.questions[quistionIndex];

                    if (answerSelected.length <= quistionIndex) {
                      answerSelected.add(false);
                    }
                    if (answersCorrectness.length <= quistionIndex) {
                      answersCorrectness.add(false);
                    }

                    return Padding(
                      padding: EdgeInsets.all(GeneralConst.horizontalPadding),
                      child: LayoutBuilder(
                        builder: (BuildContext context,
                                BoxConstraints constraints) =>
                            SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight,
                            ),
                            child: IntrinsicHeight(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  linearIndicator(
                                    quistionIndex,
                                    cubit.questions.length,
                                  ),
                                  heightSpace(15),
                                  _questionCounter(
                                    quistionIndex,
                                    cubit.questions.length,
                                  ),
                                  heightSpace(15),
                                  _getQuestion(question),
                                  heightSpace(8),
                                  question?.image == null
                                      ? const SizedBox.shrink()
                                      : CustomNetworkImage(
                                          imageUrl: question?.image ?? '',
                                        ),
                                  heightSpace(8),
                                  _getListAnswers(
                                      cubit, quistionIndex, question),
                                  Spacer(),
                                  _getNextButton(cubit, quistionIndex),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _questionCounter(int quistionIndex, int totalQuestions) {
    return CustomText(
      text: '${tr('question')} ${quistionIndex + 1}/$totalQuestions',
      color: Theme.of(context).colorScheme.onBackground,
    );
  }

  LinearProgressIndicator linearIndicator(
    int quistionIndex,
    int totalQuestions,
  ) {
    return LinearProgressIndicator(
      value: (quistionIndex + 1) / totalQuestions,
      minHeight: 12,
      backgroundColor: Colors.grey[300],
      borderRadius: BorderRadius.circular(10),
      valueColor: AlwaysStoppedAnimation<Color>(
        Theme.of(context).colorScheme.secondaryContainer,
      ),
    );
  }

  Widget _getQuestion(QuestionModel? question) {
    return Align(
      alignment: Alignment.center,
      child: CustomText(
        text: question?.question ?? '',
        fontSize: 20,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }

  Widget _getListAnswers(
      QuistionsCubit cubit, int quistionIndex, QuestionModel? question) {
    return Column(
      children: List.generate(
        cubit.questions[quistionIndex]!.answers.length,
        (answerIndex) {
          return GestureDetector(
            onTap: () {
              if (!answerSelected[quistionIndex]) {
                setState(() {
                  _onClickAnswer(quistionIndex, answerIndex, question);
                });
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 15.w),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: answerColors[quistionIndex]?[answerIndex] ??
                      Theme.of(context).colorScheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: CustomText(
                  textAlign: TextAlign.center,
                  text: question?.answers[answerIndex].answer ?? '',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: answerColors[quistionIndex]?[answerIndex] ==
                          Theme.of(context).colorScheme.onError
                      ? Theme.of(context).colorScheme.onBackground
                      : Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _getNextButton(QuistionsCubit cubit, int quistionIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        policeImage(),
        CustomButton(
          title: (quistionIndex == cubit.questions.length - 1 ||
                  answerSelected.where((selected) => selected).length ==
                      cubit.questions.length)
              ? tr('finish')
              : tr('next'),
          fontSize: 20,
          onPressed: () {
            if (quistionIndex == cubit.questions.length - 1 ||
                answerSelected.where((selected) => selected).length ==
                    cubit.questions.length) {
              if (answerSelected.contains(false)) {
                _showIncompleteDialog();
              } else {
                _pushToResultsScreen(widget.categoryName ?? tr('allQuestions'));
              }
            } else {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            }
          },
        ),
      ],
    );
  }

  void _pushToResultsScreen(String categoryName) {
    final correctAnswers =
        answersCorrectness.where((correct) => correct).length;
    final incorrectAnswers = answersCorrectness.length - correctAnswers;
    int totalQuestions = correctAnswers + incorrectAnswers;

    double scorePercentage = (correctAnswers / totalQuestions) * 100;
    int scoreNumber = scorePercentage.toInt();
    context.push(
      CategoryScoreView(
        correctsNumber: correctAnswers,
        wrongsNumber: incorrectAnswers,
        scoreNumber: scoreNumber.toString(),
        isSuccess: incorrectAnswers <= 6 ? true : false,
        categoryName: categoryName,
      ),
    );
  }

  void _showIncompleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(tr('unansweredQuestions')),
          content: Text(tr('pleaseAnswerAllQuestions')),
          actionsAlignment: MainAxisAlignment.start,
          actions: [
            TextButton(
              child: CustomText(
                text: tr('ok'),
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  ClipRRect policeImage() {
    return ClipRRect(
      child: Align(
        alignment: Alignment.topLeft,
        widthFactor: 1,
        heightFactor: 0.7,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.23,
          width: 150.w,
          child: SvgPicture.asset(
            AppImage.policeManWait,
          ),
        ),
      ),
    );
  }

  void _onClickAnswer(
      int quistionIndex, int answersIndex, QuestionModel? question) {
    answerColors[quistionIndex] ??= {};
    final correct = question?.answers[answersIndex].correct ?? false;
    answerColors[quistionIndex]![answersIndex] = correct
        ? Theme.of(context).colorScheme.onError
        : Theme.of(context).colorScheme.error;

    for (int i = 0; i < question!.answers.length; i++) {
      final correct = question.answers[i].correct ?? false;
      answerColors[quistionIndex]![i] = correct
          ? Theme.of(context).colorScheme.onError
          : Theme.of(context).colorScheme.error;
    }

    answersCorrectness[quistionIndex] = correct;
    answerSelected[quistionIndex] = true;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
