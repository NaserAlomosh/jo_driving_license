import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jo_driving_license/core/helper/spacing.dart';
import 'package:jo_driving_license/core/models/question_model.dart';
import 'package:jo_driving_license/core/widgets/buttons/custom_button.dart';
import 'package:jo_driving_license/core/widgets/error_widget/error_widget.dart';
import 'package:jo_driving_license/core/widgets/general/custom_loading.dart';
import 'package:jo_driving_license/core/widgets/general/custom_network_image.dart';
import 'package:jo_driving_license/core/widgets/general/custom_show_dilog.dart';
import 'package:jo_driving_license/core/widgets/general/custom_text.dart';

import '../view_model/cubit.dart';

class QuistionsView extends StatefulWidget {
  final String quizId;

  const QuistionsView({super.key, required this.quizId});

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
                  itemBuilder: (context, quistionIndex) {
                    final question = cubit.questions[quistionIndex];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        heightSpace(8),
                        _getQuestion(question),
                        heightSpace(8),
                        CustomNetworkImage(imageUrl: question?.image ?? ''),
                        heightSpace(8),
                        _getListAnswers(quistionIndex, question),
                        _getButton(cubit, quistionIndex),
                      ],
                    );
                  },
                  itemCount: cubit.questions.length,
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _getQuestion(QuestionModel? question) {
    return CustomText(
      text: question?.question ?? '',
      fontSize: 20,
      color: Colors.black,
    );
  }

  Widget _getListAnswers(int quistionIndex, QuestionModel? question) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, answerIndex) => GestureDetector(
          onTap: () {
            setState(() {});
            _onClickAnswer(quistionIndex, answerIndex, question);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8.h),
              padding: EdgeInsets.symmetric(vertical: 8.h),
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
        itemCount: question?.answers.length ?? 0,
      ),
    );
  }

  Widget _getButton(QuistionsCubit cubit, int quistionIndex) {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: CustomButton(
        title: 'التالي',
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
