import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jo_driving_license/core/helper/extensions.dart';
import 'package:jo_driving_license/core/widgets/general/custom_text.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Timer? _timer;
  int _remainingTime = 3600; // 3600 seconds = 1 hour
  bool start = false;

  void _showTimeUpDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: CustomText(
            text: tr('timeUp'),
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
          content: CustomText(
            text: tr('tryAgain'),
            color: Theme.of(context).colorScheme.secondary,
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  child: Text(
                    tr('countinue'),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  onPressed: () {
                    context.pop();
                  },
                ),
                TextButton(
                  child: Text(
                    tr('exit'),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop(); // Close the exam screen
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      _controller.start();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  final CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return CircularCountDownTimer(
      controller: _controller,
      duration: _remainingTime,
      initialDuration: 0,
      width: 40.sp,
      height: 40.sp,
      ringColor: Theme.of(context).colorScheme.secondary,
      ringGradient: null,
      fillColor: Color.fromARGB(255, 255, 255, 140),
      fillGradient: null,
      backgroundGradient: null,
      strokeWidth: 3.0,
      strokeCap: StrokeCap.round,
      textStyle: TextStyle(
        fontSize: 10.0,
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.bold,
      ),
      textFormat: CountdownTextFormat.MM_SS,
      isReverse: false,
      isReverseAnimation: false,
      isTimerTextShown: true,
      autoStart: start,
      onComplete: () => _showTimeUpDialog(),
    );
  }
}
