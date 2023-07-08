import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskify/app/core/utils/extensions.dart';
import 'package:taskify/app/modules/home/controller.dart';

import 'gradient_text.dart';

class AddDialog extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  AddDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
              homeCtrl.editCtrl.clear();
              homeCtrl.changeTask(null);
            },
            icon: const Icon(Icons.close),
          ),
          centerTitle: true,
          title: GradientText(
            "New Task",
            style: GoogleFonts.poppins(
                fontSize: 20.0.sp, fontWeight: FontWeight.w600),
            gradient: LinearGradient(
              colors: [
                Colors.red.shade200,
                Colors.pinkAccent,
              ],
            ),
          ),
          actions: [
            TextButton(
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent)),
              onPressed: () {
                if (homeCtrl.formKey.currentState!.validate()) {
                  if (homeCtrl.task.value == null) {
                    EasyLoading.showError('Please select the task type.');
                  } else {
                    var success = homeCtrl.updateTask(
                      homeCtrl.task.value!,
                      homeCtrl.editCtrl.text,
                    );
                    if (success) {
                      EasyLoading.showSuccess('Todo item added successful.');
                      Get.back();
                      homeCtrl.changeTask(null);
                    } else {
                      EasyLoading.showError('Todo item already exist.');
                    }
                    homeCtrl.editCtrl.clear();
                  }
                }
              },
              child: Text(
                'Done',
                style: GoogleFonts.poppins(
                  fontSize: 14.0.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
        body: Form(
          key: homeCtrl.formKey,
          child: ListView(
            children: [
              // Padding(
              //   padding: EdgeInsets.all(3.0.wp),
              //   child: const Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [],
              //   ),
              // ),
              // // Padding(
              // //   padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              // //   child: Text(
              // //     'New Task',
              // //     style: TextStyle(
              // //       fontSize: 20.0.sp,
              // //       fontWeight: FontWeight.bold,
              // //     ),
              // //   ),
              // // ),

              Padding(
                padding: EdgeInsets.only(
                  top: 2.0.wp,
                  left: 5.0.wp,
                  right: 5.0.wp,
                  bottom: 2.0.wp,
                ),
                child: Text(
                  'Add to',
                  style: GoogleFonts.poppins(
                      fontSize: 16.0.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
              ...homeCtrl.tasks
                  .map(
                    (element) => Obx(
                      () => InkWell(
                        onTap: () => homeCtrl.changeTask(element),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 2.0.wp,
                            horizontal: 5.0.wp,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5.0.wp, horizontal: 5.0.wp),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(
                                            IconData(
                                              element.icon,
                                              fontFamily: 'MaterialIcons',
                                            ),
                                            color:
                                                Hexcolor.fromHex(element.color),
                                          ),
                                          SizedBox(
                                            width: 5.0.wp,
                                          ),
                                          Text(
                                            element.title,
                                            style: GoogleFonts.poppins(
                                              fontSize: 12.0.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          if (homeCtrl.task.value == element)
                                            const Icon(
                                              Icons.check_box,
                                              color: Colors.green,
                                              size: 25,
                                            ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList()
            ],
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
            child: Padding(
              padding: EdgeInsets.only(left: 7.0.wp, right: 3.0.wp),
              child: TextFormField(
                controller: homeCtrl.editCtrl,
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  hintText: "New Task",
                  hintStyle: GoogleFonts.poppins(fontSize: 18),
                  suffixIcon: TextButton(
                    onPressed: () {
                      if (homeCtrl.formKey.currentState!.validate()) {
                        if (homeCtrl.task.value == null) {
                          EasyLoading.showError('Please select the task type.');
                        } else {
                          var success = homeCtrl.updateTask(
                            homeCtrl.task.value!,
                            homeCtrl.editCtrl.text,
                          );
                          if (success) {
                            EasyLoading.showSuccess(
                                'Todo item added successful.');
                            Get.back();
                            homeCtrl.changeTask(null);
                          } else {
                            EasyLoading.showError('Todo item already exist.');
                          }
                          homeCtrl.editCtrl.clear();
                        }
                      }
                    },
                    child: Text(
                      "Done",
                      style: GoogleFonts.poppins(
                        fontSize: 14.0.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                autofocus: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your task item.';
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
