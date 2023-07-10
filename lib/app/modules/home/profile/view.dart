import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskify/app/core/utils/extensions.dart';
import 'package:taskify/app/modules/authentication/widgets/my_alert_dialog.dart';
import 'package:taskify/app/modules/home/profile/widgets/text_box.dart';
import 'package:taskify/app/modules/home/widgets/gradient_text.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // use sign out
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  // current user
  final currentUser = FirebaseAuth.instance.currentUser!;

  // all the users
  final userCollection = FirebaseFirestore.instance.collection("Users");

  // edit field
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        surfaceTintColor: Colors.transparent,
        title: Center(
          child: Text(
            "Edit $field",
            style: GoogleFonts.poppins(
              color: Colors.white,
            ),
          ),
        ),
        content: TextField(
          autofocus: true,
          style: GoogleFonts.poppins(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Enter new $field",
            hintStyle: GoogleFonts.poppins(
              color: Colors.grey,
            ),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          // cancel button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: GoogleFonts.poppins(
                color: Colors.white,
              ),
            ),
          ),

          // const SizedBox(width: 30),

          // save button
          TextButton(
            onPressed: () => Navigator.of(context).pop(newValue),
            child: Text(
              "Save",
              style: GoogleFonts.poppins(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );

    // update in firestore
    if (newValue.trim().isNotEmpty) {
      // only update if there is something in the text-field
      await userCollection.doc(currentUser.email).update({
        field: newValue,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: const BackButton(),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 2.0.wp,
            ),
            GradientText(
              'Profile',
              style: GoogleFonts.poppins(
                  fontSize: 22, fontWeight: FontWeight.w600),
              gradient: LinearGradient(
                colors: [
                  Colors.green.shade300,
                  Colors.blue.shade900,
                ],
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(currentUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          // get the user data
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return ListView(
              children: [
                SizedBox(height: 1.hp),

                // profile pic
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: 1.8,
                      color: Colors.black,
                    ),
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
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: const [
                          0.2,
                          0.5,
                          0.8,
                          0.7
                        ],
                        colors: [
                          Colors.blue[50]!,
                          Colors.blue[100]!,
                          Colors.blue[200]!,
                          Colors.blue[300]!,
                        ]),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        CupertinoIcons.person,
                        size: 50,
                      ),
                      SizedBox(width: 5.wp),

                      // user email
                      Text(
                        currentUser.email!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: Colors.grey[900],
                          fontWeight: FontWeight.w500,
                          fontSize: 13.0.sp,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 5.hp),

                // user details
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: GradientText(
                    'My details',
                    style: GoogleFonts.poppins(
                      fontSize: 16.0.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Colors.red.shade400,
                        Colors.yellow.shade400,
                      ],
                    ),
                  ),
                ),

                // username
                TextBox(
                  sectionName: "Username",
                  text: userData['Username'],
                  onPressed: () => editField("Username"),
                ),

                // bio
                TextBox(
                  sectionName: "Bio",
                  text: userData['Bio'],
                  onPressed: () => editField("Bio"),
                ),

                 SizedBox(height: 10.hp),

                // // user posts
                // Padding(
                //   padding: const EdgeInsets.only(left: 25.0),
                //   child: Text(
                //     "My details",
                //     style: GoogleFonts.poppins(
                //       color: Colors.grey[600],
                //     ),
                //   ),
                // ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0.wp, vertical: 5.hp),
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
                        backgroundColor: Colors.grey[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minimumSize: const Size(150, 55),
                      ),
                      // _markLandingPageVisited(context),
                      onPressed: signOut,
                      child: Text(
                        'Log Out',
                        style: GoogleFonts.poppins(
                          fontSize: 12.0.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return MyAlertDialog(content: snapshot.error.toString());
          }

          return const Center(
            child: CupertinoActivityIndicator(),
          );
        },
      ),
    );
  }
}
