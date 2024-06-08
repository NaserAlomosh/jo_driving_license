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
  List<bool> answerSelected = []; // Track if an answer has been selected

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
            text: widget.categoryName ?? tr('allQuestions'),
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.secondary,
          ),
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
                      answerSelected.add(false); // Initialize selection state
                    }
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: GeneralConst.horizontalPadding,
                        vertical: 10.w,
                      ),
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
                          _getListAnswers(quistionIndex, question),
                          _getNextButton(cubit, quistionIndex),
                        ],
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

  linearIndicator(
    int quistionIndex,
    int totalQuestions,
  ) {
    return Column(
      children: [
        LinearProgressIndicator(
          value: (quistionIndex + 1) / totalQuestions,
          minHeight: 10,
          backgroundColor: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).colorScheme.secondaryContainer,
          ),
        ),
      ],
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

  Widget _getListAnswers(int quistionIndex, QuestionModel? question) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 15.h);
        },
        itemCount: question?.answers.length ?? 0,
        itemBuilder: (context, answerIndex) => GestureDetector(
          onTap: () {
            if (!answerSelected[quistionIndex]) {
              setState(() {
                _onClickAnswer(quistionIndex, answerIndex, question);
              });
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15.h),
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
      ),
    );
  }

  Widget _getNextButton(QuistionsCubit cubit, int quistionIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        policeImage(),
        CustomButton(
          title: quistionIndex == cubit.questions.length - 1
              ? 'انهاء'
              : tr('next'),
          fontSize: 20,
          onPressed: () {
            if (quistionIndex == cubit.questions.length - 1) {
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

    // Calculate the score percentage
    double scorePercentage = (correctAnswers / totalQuestions) * 100;

    // Convert the score percentage to an integer
    int scoreNumber = scorePercentage.toInt();
    context.push(
      CategoryScoreView(
        correctsNumber: correctAnswers,
        wrongsNumber: incorrectAnswers,
        scoreNumber: scoreNumber.toString(),
        isSuccess: scoreNumber >= 80 ? true : false,
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
          actions: [
            Center(
              child: CustomButton(
                width: MediaQuery.of(context).size.height * 0.23,
                title: tr('ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  policeImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ClipRRect(
          child: Align(
            alignment: Alignment.topLeft, // Adjust alignment as needed
            widthFactor: 1, // Fraction of the original width
            heightFactor: 0.67, // Fraction of the original height
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.18,
              width: 150.w,
              child: SvgPicture.asset(
                AppImage.policeManWait,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _onClickAnswer(int quistionIndex, int answersIndex, QuestionModel? question) {
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

    // Store the correctness of the user's answer
    if (answersCorrectness.length > quistionIndex) {
      answersCorrectness[quistionIndex] = correct;
    } else {
      answersCorrectness.add(correct);
    }

    // Mark this question as answered
    answerSelected[quistionIndex] = true;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
