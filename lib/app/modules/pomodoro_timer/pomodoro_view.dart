import 'package:flutter/material.dart';
import 'package:taskify/app/modules/pomodoro_timer/views/pomodoro_setting.dart';
import 'package:taskify/app/modules/pomodoro_timer/views/pomodoro_stats.dart';
import 'package:taskify/app/modules/pomodoro_timer/views/pomodoro_timer_view.dart';

class PomodoroView extends StatefulWidget {
  const PomodoroView({super.key});

  @override
  State<PomodoroView> createState() => _PomodoroViewState();
}

class _PomodoroViewState extends State<PomodoroView> {
  int currentIndex = 1;
  final pageController = PageController(initialPage: 1);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: const [
          PomodoroStats(),
          PomodoroTimer(),
          PomodoroSettings(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 0.5,
              color: Colors.black,
            ),
          ),
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: currentIndex,
          onTap: (index) {
            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn,
            );
          },
          items: [
            BottomNavigationBarItem(
              icon: _buildGradientIcon(
                Icons.auto_graph_rounded,
                currentIndex == 0,
              ),
              label: 'Menu',
            ),
            BottomNavigationBarItem(
              icon: _buildGradientIcon(
                Icons.timer_outlined,
                currentIndex == 1,
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: _buildGradientIcon(
                Icons.settings_outlined,
                currentIndex == 2,
              ),
              label: 'More',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientIcon(IconData iconData, bool isSelected) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return isSelected
            ? LinearGradient(
                colors: [
                  Colors.red[500]!,
                  Colors.orange[500]!,
                ], // Define your gradient colors
              ).createShader(bounds)
            : LinearGradient(colors: [
                Colors.grey.shade800,
                Colors.grey.shade800,
              ]).createShader(bounds); // Empty gradient when not selected
      },
      child: Icon(
        iconData,
        size: 30,
        color: isSelected
            ? Colors.white
            : Colors.white, // Icon color when selected/unselected
      ),
    );
  }
}
