import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:taskify/app/core/utils/extensions.dart';
import 'package:taskify/app/modules/pomodoro_timer/components/timer_service.dart';
import 'package:taskify/app/modules/pomodoro_timer/components/timer_setting.dart';

class PomodoroSettings extends StatelessWidget {
  const PomodoroSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimerService>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Settings",
          style: GoogleFonts.poppins(
            fontSize: 14.0.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
              child: Text(
                "Sessions",
                style: GoogleFonts.poppins(
                  fontSize: 14.0.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 6.0.sp),
            Column(
              children: [
                SettingContainer(
                  title: "Focus duration",
                  initialValue: provider.selectedTime.toString(),
                  onTap: () {
                    _showDurationDialog(
                        context, "Focus duration", false, false);
                  },
                ),
                SettingContainer(
                  title: "Short break duration",
                  initialValue: provider.shortBreak.toString(),
                  onTap: () {
                    _showDurationDialog(
                        context, "Short break duration", false, false);
                  },
                ),
                SettingContainer(
                  title: "Long break duration",
                  initialValue: provider.longBreak.toString(),
                  onTap: () {
                    _showDurationDialog(
                        context, "Long break duration", false, false);
                  },
                ),
                SettingContainer(
                  title: "Daily rounds",
                  initialValue: provider.initialRounds.toString(),
                  onTap: () {
                    _showDurationDialog(context, "Daily rounds", true, false);
                  },
                  isInt: true,
                ),
                SettingContainer(
                  title: "Daily goal",
                  initialValue: provider.initialGoal.toString(),
                  onTap: () {
                    _showDurationDialog(context, "Daily goal", false, true);
                  },
                  isInt: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void _showDurationDialog(
    BuildContext context, String title, bool isRound, bool isGoal) async {
  final provider = Provider.of<TimerService>(context, listen: false);

  String? newValue = await showDialog<String>(
    context: context,
    builder: (BuildContext dialogContext) {
      return Consumer<TimerService>(
        builder: (context, value, child) {
          String currentValue = "";
          String focus = "Focus duration";
          String shortBreak = "Short break duration";
          String longBreak = "Long break duration";
          String dailyRounds = "Daily rounds";
          String dailyGoal = "Daily goal";

          return AlertDialog(
            title: Text(
              title,
              style: GoogleFonts.poppins(),
            ),
            content: TextField(
              autofocus: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: isRound
                    ? "Enter rounds"
                    : isGoal
                        ? "Enter goals"
                        : "Enter duration",
                hintStyle: GoogleFonts.poppins(
                  fontSize: 12.0.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onChanged: (value) {
                currentValue = value;
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                child: Text(
                  'Cancel',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (currentValue.isEmpty) {
                    return;
                  }

                  if (title == focus) {
                    provider.setSelectTime(double.parse(currentValue) * 60);
                  } else if (title == shortBreak) {
                    provider.setShortBreak(double.parse(currentValue) * 60);
                  } else if (title == longBreak) {
                    provider.setLongBreak(double.parse(currentValue) * 60);
                  } else if (title == dailyRounds) {
                    provider.setInitialRounds(int.parse(currentValue));
                  } else if (title == dailyGoal) {
                    provider.setInitialGoal(int.parse(currentValue));
                  }

                  Navigator.pop(dialogContext, currentValue);
                },
                child: Text(
                  'Save',
                  style: GoogleFonts.poppins(),
                ),
              ),
            ],
          );
        },
      );
    },
  );

  if (newValue != null) {
    print("New value for $title: $newValue min");
    // Update the state or perform necessary actions with the new value
  }
}
