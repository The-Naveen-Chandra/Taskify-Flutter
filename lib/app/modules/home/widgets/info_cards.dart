import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskify/app/core/utils/extensions.dart';
import 'package:taskify/app/modules/aria/aria_view.dart';
import 'package:taskify/app/modules/home/widgets/gradient_text.dart';

// ignore: must_be_immutable
class InfoCards extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final IconData iconBottom;
  final Color iconBottomColor;
  final Color bgColor;
  final Color descriptionColor;
  final Color titleColor;
  final bool gradient;
  final bool isGradientRainbow;
  final bool isIcon;
  void Function()? onTap;
  InfoCards({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.iconBottom,
    required this.iconBottomColor,
    required this.bgColor,
    required this.descriptionColor,
    this.titleColor = Colors.black,
    required this.gradient,
    required this.isGradientRainbow,
    required this.onTap,
    required this.isIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: MediaQuery.of(context).size.height / 4.5,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            padding: EdgeInsets.symmetric(vertical: 4.wp, horizontal: 4.wp),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 2, color: Colors.black),
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      color: Colors.grey[800], shape: BoxShape.circle),
                  child: Icon(
                    icon,
                    color: Colors.amber.shade400,
                    size: 14.0.sp,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isGradientRainbow
                        ? GradientText(
                            title,
                            style: GoogleFonts.poppins(
                                fontSize: 18.0.sp, fontWeight: FontWeight.w600),
                            gradient: const LinearGradient(
                              colors: [
                                Colors.red,
                                Colors.pink,
                                Colors.purple,
                                Colors.deepPurple,
                                Colors.deepPurple,
                                Colors.indigo,
                                Colors.blue,
                                Colors.lightBlue,
                                Colors.cyan,
                                Colors.teal,
                                Colors.green,
                                Colors.lightGreen,
                                Colors.lime,
                                Colors.yellow,
                                Colors.amber,
                                Colors.orange,
                                Colors.deepOrange,
                              ],
                            ),
                          )
                        : gradient
                            ? GradientText(
                                title,
                                style: GoogleFonts.poppins(
                                    fontSize: 18.0.sp,
                                    fontWeight: FontWeight.w600),
                                gradient: const LinearGradient(
                                  colors: [
                                    Colors.red,
                                    Colors.blue,
                                  ],
                                ),
                              )
                            : Text(
                                title,
                                style: GoogleFonts.poppins(
                                  color: titleColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.0.sp,
                                ),
                              ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      description,
                      style: GoogleFonts.poppins(
                        fontSize: 12.0.sp,
                        color: descriptionColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconBottomColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: isIcon
                    ? Icon(
                        iconBottom,
                        color: Colors.white,
                      )
                    : ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (Rect bounds) => RadialGradient(
                          center: Alignment.topCenter,
                          stops: const [.5, 1],
                          colors: [
                            Colors.blue.shade400,
                            Colors.blue.shade900,
                          ],
                        ).createShader(bounds),
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AriaView(),
                            ),
                          ),
                          child: Image.asset(
                            "assets/images/rocket-lunch.png",
                            width: 25,
                            height: 25,
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
