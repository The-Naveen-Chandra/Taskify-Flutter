import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:taskify/app/core/utils/extensions.dart';
import 'package:taskify/app/modules/home/controller.dart';
import 'package:intl/intl.dart';
import 'package:taskify/app/modules/home/widgets/gradient_text.dart';

class ReportPage extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.orange[500],
          ),
        ),
        centerTitle: true,
        title: GradientText(
          "Taskify Report",
          style: GoogleFonts.poppins(
              fontSize: 20.0.sp, fontWeight: FontWeight.w600),
          gradient: LinearGradient(
            colors: [
              Colors.green.shade800,
              Colors.green.shade500,
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(
          () {
            var createdTasks = homeCtrl.getTotalTask();
            var completedTasks = homeCtrl.getTotalDoneTask();
            var liveTasks = createdTasks - completedTasks;
            var percent =
                (completedTasks / createdTasks * 100).toStringAsFixed(0);
            return ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 4.0.wp,
                    bottom: 1.0.wp,
                  ),
                  child: Center(
                    child: Text(
                      DateFormat.yMMMMd().format(DateTime.now()),
                      style: GoogleFonts.poppins(
                        fontSize: 16.0.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 4.0.wp,
                    horizontal: 5.0.wp,
                  ),
                  child: const Divider(
                    thickness: 2,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 3.0.wp,
                    horizontal: 5.0.wp,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatus(Colors.green, liveTasks, 'Live Tasks'),
                      _buildStatus(Colors.orange, completedTasks, 'Completed'),
                      _buildStatus(Colors.blue, createdTasks, 'Created'),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5.0.wp,
                    horizontal: 5.0.wp,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Efficiency Bar",
                        style: GoogleFonts.poppins(
                          fontSize: 5.0.wp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: 25,
                        width: 25,
                        child: Image.asset("assets/images/pie-chart.png"),
                      ),
                    ],
                  ),
                ),
                UnconstrainedBox(
                  child: Container(
                    width: 90.0.wp,
                    height: 90.0.wp,
                    padding: EdgeInsets.all(10.0.wp),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
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
                    child: CircularStepProgressIndicator(
                      totalSteps: createdTasks == 0 ? 1 : createdTasks,
                      currentStep: completedTasks,
                      stepSize: 20,
                      selectedColor: Colors.greenAccent,
                      unselectedColor: Colors.grey[400],
                      padding: 0,
                      width: 150,
                      height: 150,
                      selectedStepSize: 22,
                      roundedCap: (_, __) => true,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${createdTasks == 0 ? 0 : percent} %',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 20.0.sp,
                            ),
                          ),
                          SizedBox(
                            height: 1.0.wp,
                          ),
                          Text(
                            'Efficiency',
                            style: GoogleFonts.poppins(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Container _buildStatus(Color color, int number, String text) {
    return Container(
      height: 29.0.wp,
      width: 29.0.wp,
      padding: EdgeInsets.symmetric(vertical: 5.0.wp, horizontal: 1.0.wp),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: color,
        ),
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Container(
          //   height: 3.0.wp,
          //   width: 3.0.wp,
          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //     border: Border.all(
          //       width: 0.5.wp,
          //       color: color,
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   width: 3.0.wp,
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '$number',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0.sp,
                ),
              ),
              SizedBox(
                height: 2.0.wp,
              ),
              Text(
                text,
                style: GoogleFonts.poppins(
                    fontSize: 12.0.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
