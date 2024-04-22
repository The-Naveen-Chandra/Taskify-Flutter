import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskify/app/modules/pomodoro_timer/components/utils.dart';

class TimeOptions extends StatelessWidget {
  const TimeOptions({super.key});

  @override
  Widget build(BuildContext context) {
    double selectedTime = 1500;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: ScrollController(initialScrollOffset: 175),
      child: Row(
        children: selectableTimes.map((time) {
          return Container(
            width: 70,
            height: 50,
            margin: const EdgeInsets.symmetric(
              horizontal: 6,
            ),
            decoration: int.parse(time) == selectedTime
                ? BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      width: 2,
                      color: Colors.black54,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  )
                : BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Colors.black54,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
            child: Center(
              child: Text(
                (int.parse(time) ~/ 60).toString(),
                style: GoogleFonts.poppins(
                  color: int.parse(time) == selectedTime
                      ? Colors.white
                      : Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
