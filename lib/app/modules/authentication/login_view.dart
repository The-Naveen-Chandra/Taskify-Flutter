import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskify/app/core/utils/extensions.dart';
import 'package:taskify/app/modules/authentication/widgets/my_button.dart';
import 'package:taskify/app/modules/authentication/widgets/text_field.dart';
import 'package:taskify/app/modules/home/widgets/gradient_text.dart';

class LoginView extends StatefulWidget {
  final Function()? onTap;

  const LoginView({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginView> createState() => _LoginViewState();
}

// text editing controllers
final emailTextController = TextEditingController();
final passwordTextController = TextEditingController();

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: GradientText(
          'Taskify',
          style: GoogleFonts.poppins(
              fontSize: 20.0.sp, fontWeight: FontWeight.w600,),
          gradient: LinearGradient(
            colors: [
              Colors.orange.shade300,
              Colors.orange.shade900,
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              Image.asset(
                "assets/images/logo.png",
                height: 150,
              ),

              SizedBox(
                height: 2.hp,
              ),

              // welcome back message
              // Text(
              //   "Welcome back, you've been missed",
              //   style: GoogleFonts.poppins(
              //     fontWeight: FontWeight.w500,
              //     color: Colors.grey[700],
              //     fontSize: 12.0.sp,
              //   ),
              // ),
              GradientText(
                "Welcome back, you've been missed.",
                style: GoogleFonts.poppins(
                  fontSize: 12.0.sp,
                  fontWeight: FontWeight.w600,
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.orange.shade900,
                    Colors.blue.shade700,
                  ],
                ),
              ),

              SizedBox(
                height: 3.hp,
              ),

              // email text-field
              MyTextField(
                controller: emailTextController,
                hintText: "Email",
                obscureText: false,
              ),

              SizedBox(
                height: 1.8.hp,
              ),

              // password text-field
              MyTextField(
                controller: passwordTextController,
                hintText: "Password",
                obscureText: true,
              ),

              SizedBox(
                height: 5.hp,
              ),

              // sign in button
              MyButton(
                text: "Sign In",
                onTap: () {},
              ),

              // not a member? register now
              SizedBox(
                height: 5.hp,
              ),

              // not a member?  register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member ?  ",
                    style: GoogleFonts.poppins(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Register now",
                      style: GoogleFonts.poppins(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
