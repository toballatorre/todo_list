/* import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/app/model/task.dart';

class TaskRepository {
  static const tasksKey = 'tasks';

  Future<bool> addTask(Task task) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonTasks = prefs.getStringList(tasksKey) ?? [];
    jsonTasks.add(jsonEncode(task.toJson()));
    return prefs.setStringList(tasksKey, jsonTasks);
  }

  Future<List<Task>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonTasks = prefs.getStringList(tasksKey) ?? [];
    return jsonTasks
        .map((jsonTask) => Task.fromJson(jsonDecode(jsonTask)))
        .toList();
  }

  Future<bool> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonTasks = tasks.map((e) => jsonEncode(e.toJson())).toList();
    return prefs.setStringList(tasksKey, jsonTasks);
  }
} */
