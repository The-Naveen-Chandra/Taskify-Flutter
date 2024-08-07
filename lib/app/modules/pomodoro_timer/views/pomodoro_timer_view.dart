import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'package:taskify/app/core/utils/extensions.dart';
import 'package:taskify/app/modules/pomodoro_timer/components/time_controller.dart';
import 'package:taskify/app/modules/pomodoro_timer/components/timer_card.dart';
import 'package:taskify/app/modules/pomodoro_timer/components/timer_service.dart';
import 'package:taskify/app/services/notification_services.dart';
// import 'package:taskify/app/services/notification_services.dart';

class PomodoroTimer extends StatefulWidget {
  const PomodoroTimer({super.key});

  @override
  State<PomodoroTimer> createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  // var notifyHelper;

  // @override
  // void initState() {
  //   super.initState();
  //   notifyHelper = NotifyHelper();
  //   notifyHelper.initializeNotification();
  //   notifyHelper.requestIOSPermissions();
  // }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimerService>(context);
    final seconds = provider.currentDuration % 60;
    String focus = "Time to focus!";
    String longBreak = "Time to long break!";
    final String completedRounds = provider.rounds.toString();
    final String totalRounds = provider.initialRounds.toString();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.red[500]!,
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Pomodoro",
          style: GoogleFonts.poppins(
            fontSize: 14.0.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // LocalNotification.showSimpleNotification(
              //   title: "Taskify",
              //   body: "Hello",
              //   payload: "Hi there",
              // );

              LocalNotification.showPeriodicNotifications(
                title: "Taskify",
                body: "Periodic Notification",
              );
            },
            icon: const Icon(
              Icons.notifications,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            iconSize: 24.0.sp,
            onPressed: () =>
                Provider.of<TimerService>(context, listen: false).reset(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),

              const TimerCard(),

              Container(
                width: 80.0.wp,
                height: 80.0.wp,
                padding: EdgeInsets.all(10.0.wp),
                child: CircularStepProgressIndicator(
                  totalSteps: provider.selectedTime.toInt(),
                  currentStep: provider.currentDuration.toInt(),
                  stepSize: 6,
                  selectedStepSize: 12,
                  selectedColor: provider.currentState == focus
                      ? Colors.red
                      : provider.currentState == longBreak
                          ? Colors.blue
                          : Colors.green,
                  unselectedColor: provider.currentState == focus
                      ? Colors.red[100]
                      : provider.currentState == longBreak
                          ? Colors.blue[100]
                          : Colors.green[100],
                  padding: 0,
                  width: 150,
                  height: 150,
                  roundedCap: (_, __) => true,
                  circularDirection: CircularDirection.counterclockwise,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            (provider.currentDuration ~/ 60)
                                .toString()
                                .padLeft(2, '0'),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 34.0.sp,
                            ),
                          ),
                          Text(
                            " : ",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 34.0.sp,
                            ),
                          ),
                          Text(
                            seconds == 0
                                ? "${seconds.round()}0"
                                : (seconds).round().toString().padLeft(2, '0'),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 34.0.sp,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "$completedRounds of $totalRounds rounds",
                        style: GoogleFonts.poppins(
                          fontSize: 10.0.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Text(
                provider.currentState == focus
                    ? "Stay focused for ${provider.selectedTime ~/ 60} minutes."
                    : provider.currentState == longBreak
                        ? "Take a long break for ${provider.longBreak ~/ 60} minutes."
                        : "Take a short break for ${provider.shortBreak ~/ 60} minutes.",
                style: GoogleFonts.poppins(
                  fontSize: 10.0.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),

              const SizedBox(
                height: 100,
              ),

              // time controller
              const TimeController(),
            ],
          ),
        ),
      ),
    );
  }
}
