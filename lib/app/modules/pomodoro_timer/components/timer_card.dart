import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:taskify/app/modules/pomodoro_timer/components/timer_service.dart';

class TimerCard extends StatelessWidget {
  const TimerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimerService>(context);
    String focus = "Time to focus!";
    String longBreak = "Time to long break!";

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 22,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Text(
        provider.currentState,
        style: GoogleFonts.poppins(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: provider.currentState == focus
              ? Colors.red
              : provider.currentState == longBreak
                  ? Colors.blue
                  : Colors.green,
        ),
      ),
    );
  }
}
