import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jo_driving_license/core/helper/spacing.dart';
import 'package:jo_driving_license/core/models/question_model.dart';
import 'package:jo_driving_license/core/widgets/buttons/custom_button.dart';
import 'package:jo_driving_license/core/widgets/error_widget/error_widget.dart';
import 'package:jo_driving_license/core/widgets/general/custom_loading.dart';
import 'package:jo_driving_license/core/widgets/general/custom_network_image.dart';
import 'package:jo_driving_license/core/widgets/general/custom_show_dilog.dart';
import 'package:jo_driving_license/core/widgets/general/custom_text.dart';

import '../../../core/constants/dimentions.dart';
import '../../../core/constants/image_path.dart';
import '../view_model/cubit.dart';

class QuistionsView extends StatefulWidget {
  final String quizId;
  final String levelName;

  const QuistionsView({
    super.key,
    required this.quizId,
    required this.levelName,
  });

  @override
  QuistionsViewState createState() => QuistionsViewState();
}

class QuistionsViewState extends State<QuistionsView> {
  final PageController _pageController = PageController();
  Map<int, Map<int, Color>> answerColors = {};

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuistionsCubit()..getQuistionsCubit(widget.quizId),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: CustomText(
            text: widget.levelName,
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<QuistionsCubit, QuistionsState>(
            builder: (context, state) {
              final cubit = context.read<QuistionsCubit>();
              if (state is QuistionsLoading) {
                return myLoadingIndicator(context);
              } else if (state is QuistionsError) {
                return Center(child: CustomErrorWidget(msg: state.error));
              } else {
                return PageView.builder(
                  controller: _pageController,
                  itemCount: cubit.questions.length,
                  itemBuilder: (context, quistionIndex) {
                    final question = cubit.questions[quistionIndex];
                    return Padding(
                      padding: EdgeInsets.all(GeneralConst.horizontalPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
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
                            ],
                          ),
                          _getQuestion(question),
                          heightSpace(8),
                          CustomNetworkImage(imageUrl: question?.image ?? ''),
                          heightSpace(8),
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

  _questionCounter(int quistionIndex, int totalQuestions) {
    return CustomText(
      text: '${tr('question')} $quistionIndex/$totalQuestions',
      color: Theme.of(context).colorScheme.primary,
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
        Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _getQuestion(QuestionModel? question) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          text: question?.question ?? '',
          fontSize: 20,
          color: Colors.black,
        ),
      ],
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
            setState(() {});
            _onClickAnswer(quistionIndex, answerIndex, question);
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
              color: answerColors[quistionIndex]?[answerIndex] == Colors.green
                  ? Colors.white
                  : Colors.black,
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
          title: tr('next'),
          fontSize: 20,
          onPressed: () {
            if (quistionIndex == cubit.questions.length - 1) {
              showDialogSuccessBack(context, 'msg');
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

  ClipRRect policeImage() {
    return ClipRRect(
      child: Align(
        alignment: Alignment.topLeft, // Adjust alignment as needed
        widthFactor: 1, // Fraction of the original width
        heightFactor: 0.7, // Fraction of the original height
        child: Container(
          height: 250.w,
          width: 150.w,
          child: SvgPicture.asset(
            AppImage.policeManWait,
          ),
        ),
      ),
    );
  }

  _onClickAnswer(int quistionIndex, int answersIndex, QuestionModel? question) {
    answerColors[quistionIndex] ??= {};
    final correct = question?.answers[answersIndex].correct ?? false;
    answerColors[quistionIndex]![answersIndex] =
        correct ? Colors.green : Colors.red;

    for (int i = 0; i < question!.answers.length; i++) {
      final correct = question.answers[i].correct ?? false;
      answerColors[quistionIndex]![i] = correct ? Colors.green : Colors.red;
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
