import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:taskify/app/core/utils/extensions.dart';
import 'package:taskify/app/modules/pomodoro_timer/components/timer_service.dart';

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
      currentValue = "${timerService.initialRounds} sessions";
    } else if (widget.title == "Daily goal") {
      currentValue = "${timerService.initialGoal} goals";
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
