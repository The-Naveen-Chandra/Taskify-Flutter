// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:taskify/app/core/utils/extensions.dart';
import 'package:taskify/app/modules/authentication/auth.dart';
import 'package:taskify/app/modules/home/widgets/gradient_text.dart';

class LandingView extends StatefulWidget {
  const LandingView({
    super.key,
  });

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  late SharedPreferences _preferences;
  bool _showIntro = true; // Default to show intro screen
  bool _isLoading = false; // Track loading state

  @override
  void initState() {
    super.initState();
    _loadPreference();
  }

  Future<void> _loadPreference() async {
    _preferences = await SharedPreferences.getInstance();
    bool hasSeenIntro = _preferences.getBool('hasSeenIntro') ?? false;
    if (hasSeenIntro) {
      setState(() {
        _showIntro = false;
      });
    }
  }

  Future<void> _markIntroAsSeen() async {
    await _preferences.setBool('hasSeenIntro', true);
  }

  void _showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  void _hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_showIntro) {
      // Skip intro screen and navigate directly
      return const AuthView();
    }

    return _isLoading
        ? const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CupertinoActivityIndicator(),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: false,
              title: SizedBox(
                width: 25.0.wp,
                height: 25.0.wp,
                child: Image.asset("assets/images/logo.png"),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0.wp),
                child: Column(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 4.wp,
                          ),
                          GradientText(
                            "Taskify",
                            style: GoogleFonts.poppins(
                              fontSize: 38.0.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            gradient: LinearGradient(
                              colors: [
                                Colors.orange.shade800,
                                Colors.orange.shade400,
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5.wp,
                          ),
                          GradientText(
                            "Building the future of AI together.",
                            style: GoogleFonts.poppins(
                              height: 1.2,
                              fontSize: 35.0.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            gradient: LinearGradient(
                              colors: [
                                Colors.red.shade400,
                                Colors.blue.shade700,
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12.wp,
                          ),
                          GradientText(
                            "An AI powered app for the optimized task management.",
                            style: GoogleFonts.poppins(
                              fontSize: 14.0.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue.shade500,
                                Colors.blue.shade900,
                              ],
                            ),
                          ),
                          Center(
                            child: SizedBox(
                              // width: 30.0.wp,
                              height: 50.0.wp,
                              child: Image.asset(
                                  "assets/images/bot-processing.gif"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0.wp),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
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
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent[400],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            minimumSize: const Size(150, 65),
                          ),

                          // onPressed: () => Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const AuthView(),
                          //   ),
                          // ),

                          onPressed: () async {
                            _showLoading();
                            await _markIntroAsSeen();
                            await Future.delayed(const Duration(seconds: 2));
                            _hideLoading();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AuthView(),
                              ),
                            );
                          },

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Get Started',
                                style: GoogleFonts.poppins(
                                    fontSize: 12.0.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                ),
              ),
            ),
          );
  }
}
