import 'package:flutter/material.dart';
import 'package:taskify/app/modules/authentication/login_view.dart';
import 'package:taskify/app/modules/authentication/register_view.dart';


class LoginOrRegisterView extends StatefulWidget {
  const LoginOrRegisterView({super.key});

  @override
  State<LoginOrRegisterView> createState() => _LoginOrRegisterScreenState();
}

class _LoginOrRegisterScreenState extends State<LoginOrRegisterView> {
  // initially show login page
  bool showLoginPage = true;

  // toggle between login and register screen
  void toggleScreen() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginView(
        onTap: toggleScreen,
      );
    } else {
      return RegisterView(
        onTap: toggleScreen,
      );
    }
  }
}