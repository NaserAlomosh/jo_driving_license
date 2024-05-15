import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jo_driving_license/core/widgets/error_widget/error_widget.dart';
import 'package:jo_driving_license/core/widgets/general/custom_loading.dart';
import 'package:jo_driving_license/core/widgets/general/custom_text.dart';

import '../view_model/cubit.dart';

class QuistionsView extends StatelessWidget {
  final String quizId;
  const QuistionsView({super.key, required this.quizId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuistionsCubit()..getQuistionsCubit(quizId),
      child: Scaffold(
        body: BlocBuilder<QuistionsCubit, QuistionsState>(
          builder: (context, state) {
            final cubit = context.read<QuistionsCubit>();
            if (state is QuistionsLoading) {
              return myLoadingIndicator(context);
            } else if (state is QuistionsError) {
              return Center(child: CustomErrorWidget(msg: state.error));
            } else {
              return ListView.builder(
                itemBuilder: (context, quistionIndex) => ListTile(
                  title: CustomText(
                    text: cubit.questions[quistionIndex]?.question ?? '',
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  subtitle: SizedBox(
                    height: 100,
                    child: ListView.builder(
                      itemBuilder: (context, index) => CustomText(
                        text: cubit.questions[quistionIndex]?.answers[index]
                                .answer ??
                            '',
                        color: Colors.black,
                      ),
                      itemCount: cubit.questions[quistionIndex]?.answers.length,
                    ),
                  ),
                ),
                itemCount: cubit.questions.length,
              );
            }
          },
        ),
      ),
    );
  }
}
//
