import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:taskify/app/core/utils/extensions.dart';
import 'package:taskify/app/core/values/colors.dart';
import 'package:taskify/app/modules/detail/widgets/doing_list.dart';
import 'package:taskify/app/modules/detail/widgets/done_list.dart';
import 'package:taskify/app/modules/home/controller.dart';
import 'package:taskify/app/modules/home/report/view.dart';
import 'package:taskify/app/modules/home/widgets/gradient_text.dart';

class DetailPage extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var task = homeCtrl.task.value;
    var color = Hexcolor.fromHex(task!.color);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            color: Colors.black,
            onPressed: () {
              Get.back();
              homeCtrl.updateTodos();
              homeCtrl.changeTask(null);
              homeCtrl.editCtrl.clear();
            },
          ),
          centerTitle: true,
          title: Row(
            children: [
              SizedBox(
                width: 15.0.wp,
              ),
              Icon(
                IconData(
                  task.icon,
                  fontFamily: 'MaterialIcons',
                ),
                size: 35,
                color: color,
              ),
              SizedBox(
                width: 3.0.wp,
              ),
              // Text(
              //   task.title,
              //   style: GoogleFonts.poppins(
              //     fontSize: 18.0.sp,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              GradientText(
                task.title,
                style: GoogleFonts.poppins(
                    fontSize: 20.0.sp, fontWeight: FontWeight.w600),
                gradient: LinearGradient(
                  colors: [
                    color,
                    Colors.blue.shade900,
                  ],
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReportPage(),
                  ),
                );
              },
              icon: Icon(
                Icons.data_usage_rounded,
                size: 30,
                color: color,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: homeCtrl.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Padding(
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 8.0.wp,
                //   ),
                //   child: Row(
                //     children: [
                //       Icon(
                //         IconData(
                //           task.icon,
                //           fontFamily: 'MaterialIcons',
                //         ),
                //         color: color,
                //       ),
                //       SizedBox(
                //         width: 3.0.wp,
                //       ),
                //       Text(
                //         task.title,
                //         style: TextStyle(
                //           fontSize: 14.0.sp,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                Column(
                  children: [
                    Obx(
                      () {
                        var totalTodos = homeCtrl.doingTodos.length +
                            homeCtrl.doneTodos.length;
                        return homeCtrl.doingTodos.isEmpty &&
                                homeCtrl.doneTodos.isEmpty
                            ? const SizedBox()
                            : Padding(
                                padding: EdgeInsets.only(
                                  left: 4.0.wp,
                                  top: 4.0.wp,
                                  right: 4.0.wp,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      '$totalTodos Tasks Created',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14.0.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.0.wp,
                                    ),
                                    Expanded(
                                      child: StepProgressIndicator(
                                        totalSteps:
                                            totalTodos == 0 ? 1 : totalTodos,
                                        currentStep: homeCtrl.doneTodos.length,
                                        size: 12,
                                        padding: 0,
                                        roundedEdges: const Radius.circular(30),
                                        selectedGradientColor: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            color.withOpacity(0.5),
                                            color
                                          ],
                                        ),
                                        unselectedGradientColor: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Colors.grey[300]!,
                                            Colors.grey[300]!
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                      },
                    ),
                    DoingList(),
                    DoneList(),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            top: 4.0.wp,
            bottom: 12.0.wp,
            left: 4.0.wp,
            right: 4.0.wp,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 2.0.wp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              border: Border.all(width: 1, color: Colors.black),
              color: Colors.grey[200],
            ),
            child: TextFormField(
              controller: homeCtrl.editCtrl,
              autofocus: true,
              decoration: InputDecoration(
                // contentPadding: EdgeInsets.only(left: 8, right: 8),
                hintText: "Write your task",
                hintStyle: GoogleFonts.poppins(),
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.check_box_outline_blank,
                  color: Colors.grey[500],
                ),
                suffixIcon: TextButton(
                  onPressed: () {
                    if (homeCtrl.formKey.currentState!.validate()) {
                      var success = homeCtrl.addTodo(homeCtrl.editCtrl.text);
                      if (success) {
                        EasyLoading.showSuccess('Todo item added successfully');
                      } else {
                        EasyLoading.showError('Todo item already existed');
                      }
                      homeCtrl.editCtrl.clear();
                    }
                  },
                  child: const Icon(
                    Icons.done,
                    size: 35,
                    color: blue,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your todo item';
                }
                return null;
              },
            ),
          ),
        ),
      ),
    );
  }
}
