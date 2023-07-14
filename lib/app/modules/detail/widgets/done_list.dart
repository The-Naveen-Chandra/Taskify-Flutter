import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskify/app/core/utils/extensions.dart';
import 'package:taskify/app/core/values/colors.dart';
import 'package:taskify/app/modules/home/controller.dart';

class DoneList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DoneList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCtrl.doneTodos.isNotEmpty
          ? ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 4.0.wp,
                    horizontal: 5.0.wp,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        CupertinoIcons.checkmark_square_fill,
                        size: 25,
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: 2.0.wp,
                      ),
                      Text(
                        'Completed (${homeCtrl.doneTodos.length})',
                        style: GoogleFonts.poppins(
                            fontSize: 13.0.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                ...homeCtrl.doneTodos
                    .map(
                      (element) => Dismissible(
                        key: ObjectKey(element),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) => homeCtrl.deleteDoneTodo(element),
                        background: Container(
                          color: Colors.red.withOpacity(0.8),
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: 5.0.wp,
                            ),
                            child: const Icon(
                              CupertinoIcons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        child: Padding(
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
                                const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Icon(
                                    Icons.done,
                                    color: blue,
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
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontSize: 12.0.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ],
            )
          : Container(),
    );
  }
}
