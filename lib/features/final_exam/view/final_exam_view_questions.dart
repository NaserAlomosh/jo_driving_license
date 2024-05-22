import 'package:flutter/material.dart';

class FinalExamViewQuestions extends StatelessWidget {
  const FinalExamViewQuestions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Center(
          child: Text('Final Exam View Questions'),
        ),
      ),
    );
  }
}
