import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/app/model/task.dart';

class TaskRepository {
  static const _prefTaskKey = 'tasks';

  /// Agrega una nueva tarea
  Future<bool> addTask(Task task) async {
    final prefs =
        await SharedPreferences.getInstance(); // Obtén la instancia correcta
    final jsonTask = prefs.getStringList(_prefTaskKey) ?? <String>[];
    jsonTask.add(jsonEncode(task.toJson())); // Serializa la tarea a JSON
    return await prefs.setStringList(
        _prefTaskKey, jsonTask); // Guarda la lista actualizada
  }

  /// Obtiene todas las tareas
  Future<List<Task>> getTasks() async {
    final prefs =
        await SharedPreferences.getInstance(); // Obtén la instancia correcta
    final jsonTask =
        prefs.getStringList(_prefTaskKey) ?? []; // Obtén las tareas como JSON
    return jsonTask
        .map((e) => Task.fromJson(jsonDecode(e)))
        .toList(); // Deserializa las tareas
  }

  /// Guarda una lista completa de tareas (sobrescribe las existentes)
  Future<bool> saveTasks(List<Task> tasks) async {
    final prefs =
        await SharedPreferences.getInstance(); // Obtén la instancia correcta
    final jsonTask = tasks
        .map((e) => jsonEncode(e.toJson()))
        .toList(); // Serializa las tareas
    return await prefs.setStringList(
        _prefTaskKey, jsonTask); // Guarda las tareas serializadas
  }

  Future<bool> deleteAllTasks() async {
    final prefs =
        await SharedPreferences.getInstance(); // Obtén la instancia correcta
    return await prefs.clear();
  }
}
