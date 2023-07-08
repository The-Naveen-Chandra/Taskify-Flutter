import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskify/app/core/utils/extensions.dart';
import 'package:taskify/app/data/models/task.dart';
import 'package:taskify/app/modules/detail/view.dart';
import 'package:taskify/app/modules/home/controller.dart';
// import 'package:step_progress_indicator/step_progress_indicator.dart';

class TaskCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  final Task task;
  TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Hexcolor.fromHex(task.color);
    var squareWidth = Get.width - 12.0.wp;
    return GestureDetector(
      onTap: () {
        homeCtrl.changeTask(task);
        homeCtrl.changeTodos(task.todos ?? []);
        Get.to(() => DetailPage());
      },
      child: Container(
        width: squareWidth / 2,
        height: squareWidth / 2,
        margin: EdgeInsets.all(2.5.wp),
        decoration: BoxDecoration(
          color: color.withOpacity(0.3),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 7,
              offset: const Offset(0, 7),
            )
          ],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // StepProgressIndicator(
            //   totalSteps: homeCtrl.isTodosEmpty(task) ? 1 : task.todos!.length,
            //   currentStep:
            //       homeCtrl.isTodosEmpty(task) ? 0 : homeCtrl.getDoneTodo(task),
            //   size: 5,
            //   padding: 20,
            //   roundedEdges: const Radius.circular(40),
            //   selectedGradientColor: LinearGradient(
            //     begin: Alignment.topLeft,
            //     end: Alignment.bottomRight,
            //     colors: [color.withOpacity(0.5), color],
            //   ),
            //   unselectedGradientColor: const LinearGradient(
            //     begin: Alignment.topLeft,
            //     end: Alignment.bottomRight,
            //     colors: [
            //       Colors.white,
            //       Colors.white,
            //     ],
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 2.0.wp,
                top: 6.0.wp,
                right: 4.0.wp,
                left: 4.0.wp,
              ),
              child: Icon(
                IconData(
                  task.icon,
                  fontFamily: 'MaterialIcons',
                ),
                color: color,
                size: 10.0.wp,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 2.0.wp,
                top: 4.0.wp,
                right: 4.0.wp,
                left: 4.0.wp,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 2.0.wp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          '${homeCtrl.isTodosEmpty(task) ? 0 : homeCtrl.getDoneTodo(task)} done',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: color.withOpacity(0.8),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          '${homeCtrl.isTodosEmpty(task) ? 0 : task.todos!.length} tasks',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: color.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
