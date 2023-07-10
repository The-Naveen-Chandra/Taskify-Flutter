import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskify/app/core/utils/extensions.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function()? onTap;

  const MyButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(8),
          // gradient: LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          //   colors: [
          //     Colors.red.shade100,
          //     Colors.blue.shade100,
          //   ],
          // ),
          boxShadow:  [
            BoxShadow(
              color: Colors.orange.shade700,
              spreadRadius: 1,
              blurRadius: 5,
              offset:  const Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.grey.shade600,
              // spreadRadius: 1,
              // blurRadius: 5,
              offset: const  Offset(2, 0),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13.0.sp,
            ),
          ),
        ),
      ),
    );
  }
}
