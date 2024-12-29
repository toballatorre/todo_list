import 'package:flutter/foundation.dart';
import 'package:todo_list/app/model/task.dart';
import 'package:todo_list/app/repository/task_repository.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _taskList = [];

  final TaskRepository _taskRepository = TaskRepository();
  void fetchTask() async {
    _taskList = await _taskRepository.getTasks();
    notifyListeners();
  }

  List<Task> get taskList => _taskList;

  void onTaskDoneChanged(Task task) {
    task.done = !task.done;
    _taskRepository.saveTasks(_taskList);
    notifyListeners();
  }
}
