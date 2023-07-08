import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskify/app/core/utils/extensions.dart';
import 'package:taskify/app/data/models/task.dart';
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
    return Scaffold(
      // backgroundColor: Colors.grey[200],

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
                              height: 40,
                              width: 40,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  "assets/images/profile.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            // Text(
                            //   "Hi, Xo !",
                            //   style: GoogleFonts.poppins(
                            //     fontSize: 22,
                            //     fontWeight: FontWeight.w500,
                            //     color: Colors.black,
                            //   ),
                            // ),
                            GradientText(
                              'Hello Flutter',
                              style: GoogleFonts.poppins(
                                  fontSize: 22, fontWeight: FontWeight.w500),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue.shade400,
                                  Colors.blue.shade900,
                                ],
                              ),
                            ),
                          ],
                        ),

                        // AI assistance logo
                        ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) => RadialGradient(
                            center: Alignment.topCenter,
                            stops: const [.5, 1],
                            colors: [
                              Colors.blue.shade400,
                              Colors.blue.shade900,
                            ],
                          ).createShader(bounds),
                          child: Image.asset(
                            "assets/images/rocket-lunch.png",
                            width: 25,
                            height: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
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
                      child: Text(
                        "Tasks",
                        style: GoogleFonts.poppins(
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
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
            () => FloatingActionButton(
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
