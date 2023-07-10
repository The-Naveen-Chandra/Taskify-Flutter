import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskify/app/core/utils/extensions.dart';

class TextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onPressed;

  const TextBox({
    super.key,
    required this.text,
    required this.sectionName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1.8,
          color: Colors.black,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade600,
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
          BoxShadow(
            color: Colors.grey.shade200,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      padding: const EdgeInsets.only(left: 15, bottom: 15),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // section name
              Text(
                sectionName,
                style: GoogleFonts.poppins(
                  color: Colors.grey[700],
                  fontSize: 12.0.sp,
                ),
              ),

              // edit button
              IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.settings,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),

          // text
          Text(
            text,
            style: GoogleFonts.poppins(
              color: Colors.grey[900],
              fontWeight: FontWeight.w600,
              fontSize: 12.0.sp,
            ),
          ),
        ],
      ),
    );
  }
}
