import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskify/app/core/utils/extensions.dart';
import 'package:taskify/app/modules/home/controller.dart';

class DoingList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  DoingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCtrl.doingTodos.isEmpty && homeCtrl.doneTodos.isEmpty
          ? Padding(
              padding: EdgeInsets.only(
                top: 30.0.wp,
                left: 0.0.wp,
                right: 0.0.wp,
                bottom: 0.0.wp,
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/giphy.gif',
                    fit: BoxFit.cover,
                    width: 45.0.wp,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.0.wp,
                      left: 0.0.wp,
                      right: 0.0.wp,
                      bottom: 0.0.wp,
                    ),
                    child: Text(
                      'Add Task',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0.sp,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 4.0.wp,
                    horizontal: 5.0.wp,
                  ),
                  child: homeCtrl.doingTodos.isNotEmpty
                      ? Row(
                          children: [
                            const Icon(
                              Icons.create,
                              size: 25,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 2.0.wp,
                            ),
                            Text(
                              'Created (${homeCtrl.doingTodos.length})',
                              style: GoogleFonts.poppins(
                                fontSize: 13.0.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                ),
                ...homeCtrl.doingTodos
                    .map(
                      (element) => Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 2.0.wp,
                          horizontal: 5.0.wp,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5.0.wp),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[200],
                            border: Border.all(width: 1, color: Colors.black),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 25,
                                height: 25,
                                child: Checkbox(
                                  fillColor: MaterialStateProperty.resolveWith(
                                    (states) => Colors.grey[700],
                                  ),
                                  value: element['done'],
                                  onChanged: (value) {
                                    homeCtrl.doneTodo(element['title']);
                                  },
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 4.0.wp,
                                  ),
                                  child: Text(
                                    element['title'],
                                    overflow: TextOverflow.clip,
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
                if (homeCtrl.doingTodos.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(
                      left: 5.0.wp,
                      right: 5.0.wp,
                      top: 4.0.wp,
                    ),
                    child: const Divider(
                      thickness: 2,
                    ),
                  ),
              ],
            ),
    );
  }
}
