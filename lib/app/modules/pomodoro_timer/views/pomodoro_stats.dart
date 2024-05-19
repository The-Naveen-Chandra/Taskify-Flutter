import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:taskify/app/core/utils/extensions.dart';
import 'package:taskify/app/modules/pomodoro_timer/components/timer_service.dart';

class PomodoroStats extends StatelessWidget {
  const PomodoroStats({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimerService>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Statistics",
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
                "Highlights",
                style: GoogleFonts.poppins(
                  fontSize: 14.0.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // SizedBox
            SizedBox(height: 16.0.sp),

            // Row
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HighlightContainer(
                    initialNumber: provider.rounds.toString(),
                    totalNumber: provider.initialRounds.toString(),
                    title: "Total Rounds",
                  ),
                  HighlightContainer(
                    initialNumber: provider.goal.toString(),
                    totalNumber: provider.initialGoal.toString(),
                    title: "Total Goals",
                    isColorDark: true,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HighlightContainer extends StatelessWidget {
  final String totalNumber;
  final String initialNumber;
  final String title;
  final bool isColorDark;

  const HighlightContainer({
    super.key,
    required this.totalNumber,
    required this.initialNumber,
    required this.title,
    this.isColorDark = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4 - 20.0.sp,
      width: MediaQuery.of(context).size.width / 2 - 20.0.sp,
      padding: EdgeInsets.all(18.0.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: isColorDark ? Colors.grey[800] : Colors.grey[300],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                initialNumber,
                style: GoogleFonts.poppins(
                  fontSize: 24.0.sp,
                  fontWeight: FontWeight.w600,
                  color: isColorDark ? Colors.white : Colors.black,
                ),
              ),
              Text(
                " / ",
                style: GoogleFonts.poppins(
                  fontSize: 18.0.sp,
                  fontWeight: FontWeight.w600,
                  color: isColorDark ? Colors.white : Colors.black,
                ),
              ),
              Text(
                totalNumber,
                style: GoogleFonts.poppins(
                  fontSize: 24.0.sp,
                  fontWeight: FontWeight.w600,
                  color: isColorDark ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0.sp),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12.0.sp,
              fontWeight: FontWeight.w500,
              color: isColorDark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
