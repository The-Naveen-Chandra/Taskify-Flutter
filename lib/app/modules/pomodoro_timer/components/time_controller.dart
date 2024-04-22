import 'package:flutter/material.dart';

class TimeController extends StatelessWidget {
  const TimeController({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.pause,
          size: 50,
          color: Colors.white,
        ),
      ),
    );
  }
}
