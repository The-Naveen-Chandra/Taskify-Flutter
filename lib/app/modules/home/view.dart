import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskify/app/core/utils/extensions.dart';
import 'package:taskify/app/data/models/task.dart';
import 'package:taskify/app/modules/aria/aria_view.dart';
import 'package:taskify/app/modules/authentication/widgets/my_alert_dialog.dart';
import 'package:taskify/app/modules/home/controller.dart';
import 'package:taskify/app/modules/home/widgets/add_card.dart';
import 'package:taskify/app/modules/home/widgets/add_dialog.dart';
import 'package:taskify/app/modules/home/widgets/gradient_text.dart';
import 'package:taskify/app/modules/home/widgets/info_cards.dart';
import 'package:taskify/app/modules/home/widgets/info_model.dart';
import 'package:taskify/app/modules/home/widgets/task_card.dart';
import 'package:taskify/app/modules/home/profile/view.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  // final PageController pageController = PageController();
  // int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    // Timer.periodic(const Duration(seconds: 3), (_) {
    //   if (currentPage < 2) {
    //     currentPage++;
    //   } else {
    //     currentPage = 0;
    //   }
    //   pageController.animateToPage(
    //     currentPage,
    //     duration: const Duration(milliseconds: 500),
    //     curve: Curves.ease,
    //   );
    // });

    // current user
    final currentUser = FirebaseAuth.instance.currentUser!;

    // // all the users
    // final userCollection = FirebaseFirestore.instance.collection("Users");

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: [
            SafeArea(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
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
                            // Text(
                            //   "Hi, Xo !",
                            //   style: GoogleFonts.poppins(
                            //     fontSize: 22,
                            //     fontWeight: FontWeight.w500,
                            //     color: Colors.black,
                            //   ),
                            // ),
                            StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("Users")
                                  .doc(currentUser.email)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                // get the user data
                                if (snapshot.hasData) {
                                  final userData = snapshot.data!.data()
                                      as Map<String, dynamic>;

                                  return GradientText(
                                    'Hi, ${userData['Username']}',
                                    style: GoogleFonts.poppins(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.orange.shade300,
                                        Colors.orange.shade900,
                                      ],
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return MyAlertDialog(
                                      content: snapshot.error.toString());
                                }
                                return const Center(
                                  child: CupertinoActivityIndicator(),
                                );
                              },
                            ),
                          ],
                        ),

                        // AI assistance logo
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AriaView(),
                              ),
                            );
                          },
                          child: Image.asset(
                            "assets/images/aria-ai.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 5.2,
                    child: PageView.builder(
                      // controller: pageController,
                      // onPageChanged: (int index) {
                      //   currentPage = 0;
                      // },
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) => InfoCards(
                        title: infoCardsData[index].title,
                        description: infoCardsData[index].description,
                        bgColor: infoCardsData[index].bgColor,
                        descriptionColor: infoCardsData[index].descriptionColor,
                        isGradientRainbow:
                            infoCardsData[index].isGradientRainbow,
                        gradient: infoCardsData[index].gradient,
                        iconBottomColor: infoCardsData[index].iconBottomColor,
                        isIcon: infoCardsData[index].isIcon,
                        icon: infoCardsData[index].icon,
                        iconBottom: infoCardsData[index].iconBottom,
                        onTap: infoCardsData[index].onTap,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 1.0.wp, horizontal: 4.0.wp),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: Image.asset(
                              "assets/images/double-check.gif",
                            ),
                          ),
                          Text(
                            "Tasks",
                            style: GoogleFonts.poppins(
                              fontSize: 16.0.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Obx(
                    () => GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      children: [
                        ...controller.tasks
                            .map(
                              (element) => LongPressDraggable(
                                data: element,
                                onDragStarted: () =>
                                    controller.changeDeleting(true),
                                onDraggableCanceled: (_, __) =>
                                    controller.changeDeleting(false),
                                onDragEnd: (_) =>
                                    controller.changeDeleting(false),
                                feedback: Opacity(
                                  opacity: 0.8,
                                  child: TaskCard(task: element),
                                ),
                                child: TaskCard(task: element),
                              ),
                            )
                            .toList(),
                        AddCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const ProfilePage(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: DragTarget<Task>(
        builder: (_, __, ___) {
          return Obx(
            () => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade600,
                    spreadRadius: 0.5,
                    blurRadius: 5,
                    offset: const Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Colors.grey.shade200,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                backgroundColor:
                    controller.deleting.value ? Colors.red : Colors.black,
                onPressed: () {
                  if (controller.tasks.isNotEmpty) {
                    Get.to(() => AddDialog(), transition: Transition.fade);
                  } else {
                    EasyLoading.showInfo('Please create your task type');
                  }
                },
                child: Icon(
                  controller.deleting.value
                      ? CupertinoIcons.delete
                      : Icons.add_rounded,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
        onAccept: (Task task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess("Delete Success");
        },
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Obx(
          () => BottomNavigationBar(
            onTap: (int index) {
              controller.changeTabIndex(index);
              // if (index == 1) {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => ProfilePage(),
              //       ));
              // }
            },
            currentIndex: controller.tabIndex.value,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                label: 'Home',
                icon: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) => RadialGradient(
                    center: Alignment.topCenter,
                    stops: const [.5, 1],
                    colors: [
                      Colors.blue.shade400,
                      Colors.blue.shade900,
                    ],
                  ).createShader(bounds),
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.0.wp),
                    child: const Icon(
                      CupertinoIcons.home,
                      size: 35,
                    ),
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: 'Profile',
                icon: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) => RadialGradient(
                    center: Alignment.topCenter,
                    stops: const [.5, 1],
                    colors: [
                      Colors.blue.shade400,
                      Colors.blue.shade900,
                    ],
                  ).createShader(bounds),
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0.wp),
                    child: const Icon(
                      CupertinoIcons.person_fill,
                      size: 35,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
