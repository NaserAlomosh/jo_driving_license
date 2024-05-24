import 'package:flutter/material.dart';
import 'package:jo_driving_license/features/questions/view/level_score_view.dart';

class AllQuestionsView extends StatelessWidget {
  const AllQuestionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const LevelScoreView(
      correctsNumber: 2,
      wrongsNumber: 1,
      scoreNumber: 98,
    );
  }
}
