import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskify/app/modules/pomodoro_timer/components/timer_service.dart';

class TimeController extends StatelessWidget {
  const TimeController({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimerService>(context);

    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () {
          if (provider.timerPlaying) {
            Provider.of<TimerService>(context, listen: false).pause();
          } else {
            Provider.of<TimerService>(context, listen: false).start();
          }
        },
        icon: Icon(
          provider.timerPlaying
              ? Icons.pause_rounded
              : Icons.play_arrow_rounded,
          size: 36,
          color: Colors.white,
        ),
      ),
    );
  }
}
