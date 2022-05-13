import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:wordflow/view/game/multi/game_multi_viewmodel.dart';

class TimerRound extends StatefulWidget {
  const TimerRound({Key? key, this.title, required this.vm}) : super(key: key);

  final String? title;
  final GameMultiViewModel vm;
  @override
  _TimerRoundState createState() => _TimerRoundState();
}

class _TimerRoundState extends State<TimerRound> {
  final int _duration = 200;
  final CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return CircularCountDownTimer(
      // Countdown duration in Seconds.
      duration: _duration,

      // Countdown initial elapsed Duration in Seconds.
      initialDuration: 0,

      // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
      controller: _controller,

      // Width of the Countdown Widget.
      width: MediaQuery.of(context).size.width / 3,

      // Height of the Countdown Widget.
      height: MediaQuery.of(context).size.height / 3,

      // Ring Color for Countdown Widget.
      ringColor: Colors.grey[300]!,

      // Ring Gradient for Countdown Widget.
      ringGradient: null,

      // Filling Color for Countdown Widget.
      fillColor: Colors.purpleAccent[100]!,

      // Filling Gradient for Countdown Widget.
      fillGradient: null,

      // Background Color for Countdown Widget.
      backgroundColor: Colors.purple[500],

      // Background Gradient for Countdown Widget.
      backgroundGradient: null,

      // Border Thickness of the Countdown Ring.
      strokeWidth: 10.0,

      // Begin and end contours with a flat edge and no extension.
      strokeCap: StrokeCap.round,

      // Text Style for Countdown Text.
      textStyle: const TextStyle(
        fontSize: 16.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),

      // Format for the Countdown Text.
      textFormat: CountdownTextFormat.S,

      // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
      isReverse: true,

      // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
      isReverseAnimation: false,

      // Handles visibility of the Countdown Text.
      isTimerTextShown: true,

      // Handles the timer start.
      autoStart: true,

      // This Callback will execute when the Countdown Starts.
      onStart: () {
        // Here, do whatever you want
        debugPrint('Countdown Started');
      },

      // This Callback will execute when the Countdown Ends.
      onComplete: () async {
        // Here, do whatever you want

        if (widget.vm.isReferee) {
          ///sadece 1 kişi değiştirmesi lazım
          widget.vm.changeTurn();
        }

        _controller.restart();

        //TODO-----bir de normal restartlanacak!
        debugPrint('Countdown Ended');
      },
    );
  }
}
