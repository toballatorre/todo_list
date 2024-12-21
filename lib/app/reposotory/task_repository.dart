import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:todo_list/app/model/task.dart';

class TaskRepository {
  static const _prefTaskKey = 'tasks';
  final _prefsAsync = SharedPreferencesAsync();

  Future<void> addTask(Task task) async {
    final jsonTask =
        await _prefsAsync.getStringList(_prefTaskKey) ?? <String>[];
    jsonTask.add(jsonEncode(task.toJson()));
    await _prefsAsync.setStringList(_prefTaskKey, jsonTask);
  }

  Future<List<Task>> getTasks() async {
    final jsonTask = await _prefsAsync.getStringList(_prefTaskKey) ?? [];
    return jsonTask.map((e) => Task.fromJson(jsonDecode(e))).toList();
  }

  Future<void> saveTask(List<Task> tasks) async {
    final jsonTask = tasks.map((e) => jsonEncode(e.toJson())).toList();
    await _prefsAsync.setStringList(_prefTaskKey, jsonTask);
  }
}
