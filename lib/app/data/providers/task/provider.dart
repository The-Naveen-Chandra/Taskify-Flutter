
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskify/app/core/utils/keys.dart';
import 'package:taskify/app/data/models/task.dart';
import 'package:taskify/app/data/services/storage/services.dart';

class TaskProvider {
  final _storage = Get.find<StorageService>();

// {'tasks': [
//     { 'title': 'Work',
//     'color': '#ff123456',
//     'icon': 0xe123}
// ]}
  

  List<Task> readTask() {
    var tasks = <Task> [];
    jsonDecode(_storage.read(taskKey).toString())
      .forEach((task) => tasks.add(Task.fromJson(task)));
    return tasks;
  }

  void writeTask(List<Task> tasks) {
    _storage.write(taskKey, jsonEncode(tasks));
  }
}