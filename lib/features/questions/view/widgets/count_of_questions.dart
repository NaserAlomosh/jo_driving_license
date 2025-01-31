import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jo_driving_license/core/helper/extensions.dart';

import '../../../../core/constants/dimentions.dart';
import '../../../../core/constants/image_path.dart';
import '../../../../core/helper/spacing.dart';
import '../../../../core/models/question_model.dart';
import '../../../../core/widgets/buttons/custom_button.dart';
import '../../../../core/widgets/general/custom_network_image.dart';
import '../../../../core/widgets/general/custom_text.dart';
import '../../view_model/cubit.dart';
import '../category_score_view.dart';

class QuestionsBody extends StatefulWidget {
  const QuestionsBody({
    super.key,
    required this.cubit,
    this.quizId,
    this.categoryName,
    this.countRandomQuestions,
  });
  final QuistionsCubit cubit;
  final String? quizId;
  final String? categoryName;
  final int? countRandomQuestions;

  @override
  State<QuestionsBody> createState() => _QuestionsBodyState();
}

class _QuestionsBodyState extends State<QuestionsBody> {
  PageController _pageController = PageController();
  Map<int, Map<int, Color>> answerColors = {};
  List<bool> answersCorrectness = [];
  List<bool> answerSelected = [];
  ScrollController _listController = ScrollController();
  int? currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex ?? 0);
    _pageController.addListener(_pageChangeListener);
  }

  // Listener for page changes
  void _pageChangeListener() {
    setState(() {
      currentIndex = _pageController.page!.round();
      _listController.jumpTo(
        (_pageController.page ?? 0) * 30.w,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _countOfQuestions(
          widget.cubit.questions.length,
          currentIndex ?? 0,
        ),
        _getPageView(widget.cubit),
      ],
    );
  }

  Widget _countOfQuestions(int countOfQuestions, int quistionIndex) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GeneralConst.horizontalPadding,
        vertical: 6.h,
      ),
      child: SizedBox(
        height: 40.w,
        width: double.infinity,
        child: GridView.builder(
          itemCount: countOfQuestions,
          controller: _listController,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.0),
            child: GestureDetector(
              onTap: () async {
                await _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.ease,
                );
                currentIndex = index;
              },
              child: Container(
                width: 40.w,
                height: 40,
                color: quistionIndex == index
                    ? Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.8)
                    : Colors.grey,
                child: Stack(
                  children: [
                    Center(
                      child: CustomText(
                        text: '${index + 1}',
                      ),
                    ),
                    _getDoneIcon(index, quistionIndex),
                  ],
                ),
              ),
            ),
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
          ),
        ),
      ),
    );
  }

  Widget _getPageView(QuistionsCubit cubit) {
    return Expanded(
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.cubit.questions.length,
        itemBuilder: (context, quistionIndex) {
          final question = widget.cubit.questions[quistionIndex];
          if (answerSelected.length <= quistionIndex) {
            answerSelected.add(false);
          }
          if (answersCorrectness.length <= quistionIndex) {
            answersCorrectness.add(false);
          }
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: GeneralConst.horizontalPadding,
            ),
            child: LayoutBuilder(
              builder: (
                BuildContext context,
                BoxConstraints constraints,
              ) =>
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
                        heightSpace(10),
                        linearIndicator(
                          quistionIndex,
                          widget.cubit.questions.length,
                        ),
                        heightSpace(15),
                        _questionCounter(
                          quistionIndex,
                          widget.cubit.questions.length,
                        ),
                        heightSpace(15),
                        _getQuestion(question),
                        heightSpace(8),
                        question?.image == null
                            ? const SizedBox.shrink()
                            : CustomNetworkImage(
                                imageUrl: question?.image ?? '',
                                height: 130.w,
                                width: 200.w,
                                fit: BoxFit.contain,
                              ),
                        heightSpace(8),
                        _getListAnswers(
                          widget.cubit,
                          quistionIndex,
                          question,
                        ),
                        Spacer(),
                        _getNextButton(
                          widget.cubit,
                          quistionIndex,
                        ),
                        heightSpace(15),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
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

  Widget _getListAnswers(QuistionsCubit cubit, int quistionIndex, QuestionModel? question) {
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
                  color: answerColors[quistionIndex]?[answerIndex] ?? Theme.of(context).colorScheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: CustomText(
                  textAlign: TextAlign.center,
                  text: question?.answers[answerIndex].answer ?? '',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: answerColors[quistionIndex]?[answerIndex] == Theme.of(context).colorScheme.onError
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
                  answerSelected.where((selected) => selected).length == cubit.questions.length)
              ? tr('finish')
              : tr('next'),
          fontSize: 20,
          onPressed: () {
            if (quistionIndex == cubit.questions.length - 1 ||
                answerSelected.where((selected) => selected).length == cubit.questions.length) {
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

  void _pushToResultsScreen(String categoryName) async {
    final correctAnswers = await answersCorrectness.where((correct) => correct).length;
    final incorrectAnswers = await answersCorrectness.length - correctAnswers;
    int totalQuestions = correctAnswers + incorrectAnswers;

    final scorePercentage = await (correctAnswers / totalQuestions) * 100;
    int scoreNumber = await scorePercentage.toInt();
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

  void _onClickAnswer(int quistionIndex, int answersIndex, QuestionModel? question) {
    answerColors[quistionIndex] ??= {};
    final correct = question?.answers[answersIndex].correct ?? false;
    answerColors[quistionIndex]![answersIndex] =
        correct ? Theme.of(context).colorScheme.onError : Theme.of(context).colorScheme.error;

    for (int i = 0; i < question!.answers.length; i++) {
      final correct = question.answers[i].correct ?? false;
      answerColors[quistionIndex]![i] =
          correct ? Theme.of(context).colorScheme.onError : Theme.of(context).colorScheme.error;
    }

    answersCorrectness[quistionIndex] = correct;
    answerSelected[quistionIndex] = true;
  }

  Widget _getDoneIcon(int index, int quistionIndex) {
    if (answerSelected.isEmpty || index >= answerSelected.length) {
      return SizedBox.shrink();
    } else {
      bool isAnswered = answerSelected[index];
      return isAnswered
          ? Center(
              child: Icon(
                Icons.done,
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
            )
          : SizedBox.shrink();
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageChangeListener);
    _listController.dispose();
    _pageController.dispose();
    super.dispose();
  }
}
