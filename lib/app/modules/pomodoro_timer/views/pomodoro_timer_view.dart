import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:taskify/app/core/utils/extensions.dart';
import 'package:taskify/app/modules/home/widgets/gradient_text.dart';
import 'package:taskify/app/modules/pomodoro_timer/components/time_controller.dart';
import 'package:taskify/app/modules/pomodoro_timer/components/time_options.dart';
import 'package:taskify/app/modules/pomodoro_timer/components/timer_card.dart';

class PomodoroTimer extends StatelessWidget {
  const PomodoroTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.red[500]!,
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: GradientText(
          "Pomodoro Timer",
          style: GoogleFonts.poppins(
              fontSize: 16.0.sp, fontWeight: FontWeight.w600),
          gradient: LinearGradient(
            colors: [
              Colors.red[500]!,
              Colors.orange[500]!,
            ],
          ),
        ),
        actions: [
          // reset timer button
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.refresh_rounded,
              size: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: const Column(
            children: [
              SizedBox(
                height: 15,
              ),

              // timer card
              TimerCard(),

              SizedBox(
                height: 30,
              ),

              // time options
              TimeOptions(),

              SizedBox(
                height: 40,
              ),

              // time controller
              TimeController(),
            ],
          ),
        ),
      ),
    );
  }
}
