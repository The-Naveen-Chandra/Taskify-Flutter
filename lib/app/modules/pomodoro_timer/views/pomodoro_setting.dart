// ignore_for_file: public_member_api_docs, sort_constructors_first
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
                    _showDurationDialog(context, "Focus duration");
                  },
                ),
                SettingContainer(
                  title: "Short break duration",
                  initialValue: provider.shortBreak.toString(),
                  onTap: () {
                    _showDurationDialog(context, "Short break duration");
                  },
                ),
                SettingContainer(
                  title: "Long break duration",
                  initialValue: provider.longBreak.toString(),
                  onTap: () {
                    _showDurationDialog(context, "Long break duration");
                  },
                ),
                SettingContainer(
                  title: "Daily rounds",
                  initialValue: provider.initialRounds.toString(),
                  onTap: () {
                    _showDurationDialog(context, "Daily rounds");
                  },
                  isInt: true,
                ),
                SettingContainer(
                  title: "Daily goal",
                  initialValue: provider.initialGoal.toString(),
                  onTap: () {
                    _showDurationDialog(context, "Daily goal");
                  },
                  isInt: true,
                ),

                // TimeOptions(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void _showDurationDialog(BuildContext context, String title) async {
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
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter duration",
                hintStyle: GoogleFonts.poppins(
                  fontSize: 12.0,
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
