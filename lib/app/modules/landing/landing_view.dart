import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskify/app/core/utils/extensions.dart';
import 'package:taskify/app/modules/authentication/auth.dart';
import 'package:taskify/app/modules/home/widgets/gradient_text.dart';

class LandingView extends StatelessWidget {
  const LandingView({
    super.key,
  });

  /* all the commented code is for Visited Page function */

  // Future<bool> _hasVisitedLandingPage() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool('hasVisitedLandingPage') ?? false;
  // }
  //
  // void _markLandingPageVisited(BuildContext context) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('hasVisitedLandingPage', true);
  //
  //   // ignore: use_build_context_synchronously
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => const HomePage(),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder<bool>(
    //   future: _hasVisitedLandingPage(),
    //   builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
    //     if (snapshot.hasData && snapshot.data!) {
    //       // User has already visited the landing page, skip to home page
    //       return const HomePage();
    //     } else {
    return Scaffold(
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
                        child: Image.asset("assets/images/bot-processing.gif"),
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
                    // _markLandingPageVisited(context),
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AuthView(),
                      ),
                    ),
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
//       },
//     );
//   }
// }
