import 'package:flutter/material.dart';
import 'package:taskify/app/modules/home/widgets/info_cards.dart';

class InfoCardsData {
  final String title;
  final String description;
  final IconData icon;
  final Color bgColor;
  void Function()? onTap;
  InfoCardsData({
    required this.title,
    required this.description,
    required this.icon,
    required this.bgColor,
    required this.onTap,
  });
}

List<InfoCards> infoCardsData = [
  InfoCards(
    title: "Aria - AI Assistance",
    description: "Check out the new\nAria - AI assistance!",
    bgColor: Colors.white,
    icon: Icons.bolt,
    iconBottom: Icons.arrow_upward,
    iconBottomColor: Colors.white,
    isGradientRainbow: false,
    gradient: true,
    isIcon: false,
    titleColor: Colors.black,
    descriptionColor: Colors.black,
    onTapPomodoro: false,
    onTap: () {},
  ),
  InfoCards(
    title: "Pomodoro timer",
    description: "Start your work session\nwith the Pomodoro timer!",
    bgColor: Colors.white,
    icon: Icons.timer_outlined,
    iconBottom: Icons.fast_forward_rounded,
    iconBottomColor: Colors.grey[900]!,
    isGradientRainbow: false,
    gradient: false,
    isIcon: true,
    onTapPomodoro: true,
    titleColor: Colors.black,
    descriptionColor: Colors.black,
    onTap: () {},
  ),
  InfoCards(
    title: "Go Premium",
    description: "Get unlimited access\nto all our features!",
    bgColor: Colors.black,
    descriptionColor: Colors.grey[500]!,
    icon: Icons.star_rounded,
    iconBottom: Icons.arrow_forward,
    iconBottomColor: Colors.blue,
    isGradientRainbow: true,
    gradient: false,
    isIcon: true,
    onTapPomodoro: false,
    onTap: () {},
  ),
];
