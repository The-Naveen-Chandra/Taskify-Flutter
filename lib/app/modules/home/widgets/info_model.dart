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
    onTap: () {},
  ),
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
    onTap: () {},
  ),
  InfoCards(
    title: "Optimize your Task",
    description: "Optimize and Manage\nyour tasks with few clicks!",
    bgColor: Colors.white,
    icon: Icons.fast_forward_rounded,
    iconBottom: Icons.arrow_forward,
    iconBottomColor: Colors.blue,
    isGradientRainbow: false,
    gradient: false,
    isIcon: true,
    titleColor: Colors.black,
    descriptionColor: Colors.black,
    onTap: () {},
  ),
];
