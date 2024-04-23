import "dart:async";

import "package:flutter/material.dart";

class TimerService extends ChangeNotifier {
  late Timer timer;
  double currentDuration = 1500;
  double selectedTime = 1500;
  bool timerPlaying = false;
  int rounds = 0;
  int goal = 0;
  String currentState = "Time to focus!";

  void start() {
    timerPlaying = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentDuration == 0) {
        handleNextRound();
      } else {
        currentDuration--;
        notifyListeners();
      }
    });
  }

  void pause() {
    timer.cancel();
    timerPlaying = false;
    notifyListeners();
  }

  void selectTime(double seconds) {
    selectedTime = seconds;
    currentDuration = seconds;

    notifyListeners();
  }

  void reset() {
    timer.cancel();
    currentState = "Time to focus!";
    currentDuration = selectedTime = 1500;
    rounds = goal = 0;
    timerPlaying = false;
    notifyListeners();
  }

  void handleNextRound() {
    if (currentState == "Time to focus!" && rounds != 3) {
      currentState = "Time to break!";
      currentDuration = 300;
      selectedTime = 300;
      rounds++;
      goal++;
    } else if (currentState == "Time to break!") {
      currentState = "Time to focus!";
      currentDuration = 1500;
      selectedTime = 1500;
    } else if (currentState == "Time to focus!" && rounds == 3) {
      currentState = "Time to long break!";
      currentDuration = 900;
      selectedTime = 900;
      rounds++;
      goal++;
    } else if (currentState == "Time to long break!") {
      currentState = "Time to focus!";
      currentDuration = 1500;
      selectedTime = 1500;
      rounds = 0;
    }
    notifyListeners();
  }
}
