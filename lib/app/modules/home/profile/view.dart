import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

// sign out user
void signOut() {
  FirebaseAuth.instance.signOut();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile Page",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        ),
        actions: const [
          IconButton(
            onPressed: signOut,
            icon: Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text("Profile Page"),
      ),
    );
  }
}
