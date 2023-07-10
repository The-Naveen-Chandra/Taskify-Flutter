import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskify/app/core/utils/extensions.dart';
import 'package:taskify/app/modules/authentication/widgets/widgets.dart';
import 'package:taskify/app/modules/home/widgets/gradient_text.dart';

class RegisterView extends StatefulWidget {
  final Function()? onTap;

  const RegisterView({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  // text editing controllers
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmTextPasswordController = TextEditingController();

  // sign user up
  void signUp() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      },
    );

    // check if password is confirmed
    if (passwordTextController.text != confirmTextPasswordController.text) {
      // pop loading circle
      Navigator.pop(context);
      // show error to user
      showErrorMsg("Password don't match !");
      return;
    }

    // try {
    //   await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //     email: emailTextController.text,
    //     password: passwordTextController.text,
    //   );
    //   // pop the context
    //   if (context.mounted) Navigator.pop(context);
    // } on FirebaseAuthException catch (e) {
    //   // pop the context
    //   Navigator.pop(context);
    //   // show error message
    //   showErrorMsg(e.code);
    // }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UsernameAndBioScreen(
          email: emailTextController.text,
          password: passwordTextController.text,
        ),
      ),
    );
  }

  // error message popup
  void showErrorMsg(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertDialog(content: message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: GradientText(
          'Taskify',
          style: GoogleFonts.poppins(
            fontSize: 20.0.sp,
            fontWeight: FontWeight.w600,
          ),
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

              GradientText(
                "Let's create an account for you.",
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
                height: 1.8.hp,
              ),

              // confirm password text-field
              MyTextField(
                controller: confirmTextPasswordController,
                hintText: "Confirm Password",
                obscureText: true,
              ),

              SizedBox(
                height: 5.hp,
              ),

              // sign up button
              MyButton(
                text: "Sign Up",
                onTap: signUp,
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
                    "Already have an account.  ",
                    style: GoogleFonts.poppins(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Login now",
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

class UsernameAndBioScreen extends StatefulWidget {
  final String email;
  final String password;

  const UsernameAndBioScreen({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  State<UsernameAndBioScreen> createState() => _UsernameAndBioScreen();
}

class _UsernameAndBioScreen extends State<UsernameAndBioScreen> {
  final usernameController = TextEditingController();
  final bioController = TextEditingController();

  void saveProfile() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      },
    );

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: widget.email,
        password: widget.password,
      );

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.email)
          .set({
        'Username': usernameController.text,
        'Bio': bioController.text,
      });

      if (context.mounted) Navigator.pop(context);
      if (context.mounted) Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      showErrorMsg(e.toString());
    }
    if (context.mounted) Navigator.pop(context);
  }

  void showErrorMsg(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertDialog(content: message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: GradientText(
          'Taskify',
          style: GoogleFonts.poppins(
            fontSize: 20.0.sp,
            fontWeight: FontWeight.w600,
          ),
          gradient: LinearGradient(
            colors: [
              Colors.orange.shade300,
              Colors.orange.shade900,
            ],
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              // logo
              Image.asset(
                "assets/images/logo.png",
                height: 150,
              ),
              SizedBox(height: 2.hp),

              // Fill in your username and bio
              GradientText(
                "Fill in your username and bio.",
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

              SizedBox(height: 3.hp),

              // username text-field
              MyTextField(
                controller: usernameController,
                hintText: "Username",
                obscureText: false,
              ),

              SizedBox(
                height: 1.8.hp,
              ),

              // bio text-field
              MyTextField(
                controller: bioController,
                hintText: "Bio",
                obscureText: false,
              ),

              SizedBox(
                height: 5.hp,
              ),

              MyButton(
                text: "Save",
                onTap: saveProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
