// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:taskify/app/core/utils/extensions.dart';
import 'package:taskify/app/modules/pomodoro_timer/components/timer_service.dart';

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
  TimerService timerService = Provider.of<TimerService>(context, listen: false);

  String? newValue = await showDialog<String>(
    context: context,
    builder: (BuildContext dialogContext) {
      String currentValue = timerService.selectedTime.toString();

      return AlertDialog(
        title: Text(title),
        content: TextField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: "Enter duration in minutes",
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
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (double.tryParse(currentValue) != null) {
                timerService.selectTime(double.parse(currentValue) * 60);
              }
              Navigator.pop(dialogContext, currentValue);
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );

  if (newValue != null) {
    print("New value for $title: $newValue min");
    // Update the state or perform necessary actions with the new value
  }
}

class SettingContainer extends StatefulWidget {
  final String title;
  final String initialValue;
  final void Function()? onTap;
  final bool isInt;

  const SettingContainer({
    Key? key,
    required this.title,
    required this.initialValue,
    required this.onTap,
    this.isInt = false,
  }) : super(key: key);

  @override
  State<SettingContainer> createState() => _SettingContainerState();
}

class _SettingContainerState extends State<SettingContainer> {
  @override
  Widget build(BuildContext context) {
    TimerService timerService = Provider.of<TimerService>(context);

    String currentValue = widget.initialValue;

    if (widget.title == "Focus duration") {
      currentValue =
          (timerService.selectedTime ~/ 60).toString().padLeft(2, '0');
    } else if (widget.title == "Short break duration") {
      currentValue = (timerService.shortBreak ~/ 60).toString();
    } else if (widget.title == "Long break duration") {
      currentValue = (timerService.longBreak ~/ 60).toString();
    } else if (widget.title == "Daily rounds") {
      currentValue = "${timerService.initialRounds} rounds";
    } else if (widget.title == "Daily goal") {
      currentValue = "${timerService.initialGoal} sessions";
    }

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0.sp, horizontal: 12.0.sp),
        padding: EdgeInsets.all(18.0.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[300],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: GoogleFonts.poppins(
                fontSize: 12.0.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              widget.isInt ? currentValue : "$currentValue min",
              style: GoogleFonts.poppins(
                fontSize: 12.0.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
