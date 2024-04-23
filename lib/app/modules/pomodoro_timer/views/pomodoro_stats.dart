import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskify/app/core/utils/extensions.dart';

class PomodoroStats extends StatelessWidget {
  const PomodoroStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        child: Container(
          alignment: Alignment.center,
          child: const Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
