import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskify/app/modules/authentication/login_or_register_view.dart';
import 'package:taskify/app/modules/home/view.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {

          // user is logged in
          if(snapshot.hasData) {
            return const HomePage();
          }

          // user is Not logged in
          else {
            return const LoginOrRegisterView();
          }
        },
      ),
    );
  }
}
