import "dart:async";

import "package:flutter/material.dart";

class TimerService extends ChangeNotifier {
  late Timer timer;
  double currentDuration = 1500;
  double selectedTime = 1500;
  double shortBreak = 300;
  double longBreak = 900;
  bool timerPlaying = false;
  int initialRounds = 4;
  int initialGoal = 12;
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

  void setSelectTime(double seconds) {
    selectedTime = seconds;
    currentDuration = seconds;

    notifyListeners();
  }

  void setShortBreak(double seconds) {
    shortBreak = seconds;
    notifyListeners();
  }

  void setLongBreak(double seconds) {
    longBreak = seconds;
    notifyListeners();
  }

  void setInitialRounds(int rounds) {
    initialRounds = rounds;
    notifyListeners();
  }

  void setInitialGoal(int goal) {
    initialGoal = goal;
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
    if (currentState == "Time to focus!" && rounds != initialRounds - 1) {
      currentState = "Time to break!";
      currentDuration = shortBreak;
      selectedTime = shortBreak;
      rounds++;
      goal++;
    } else if (currentState == "Time to break!") {
      currentState = "Time to focus!";
      currentDuration = selectedTime;
      selectedTime = selectedTime;
    } else if (currentState == "Time to focus!" &&
        rounds == initialRounds - 1) {
      currentState = "Time to long break!";
      currentDuration = longBreak;
      selectedTime = longBreak;
      rounds++;
      goal++;
    } else if (currentState == "Time to long break!") {
      currentState = "Time to focus!";
      currentDuration = selectedTime;
      selectedTime = selectedTime;
      rounds = 0;
    }
    notifyListeners();
  }
}
