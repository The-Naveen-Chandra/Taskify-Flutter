import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAlertDialog extends StatelessWidget {
  final String content;

  const MyAlertDialog({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          "Alert !",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      content: Text(
        content,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'OK',
            style: GoogleFonts.poppins(
              color: Colors.orange[900],
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
