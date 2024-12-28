import 'package:flutter/material.dart';
import 'package:todo_list/app/model/task.dart';
import 'package:todo_list/app/repository/task_repository.dart';
import 'package:todo_list/app/views/components/h1.dart';
import 'package:todo_list/app/views/components/shape.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final tasklist = <Task>[];
  final TaskRepository taskRepository = TaskRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Header(),
          Expanded(
            child: FutureBuilder<List<Task>>(
                future: taskRepository.getTasks(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No existen tareas disponibles'));
                  }
                  return _TaskList(
                    snapshot.data!,
                    onTaskDoneChanged: (task) {
                      task.done = !task.done;
                      taskRepository.saveTasks(snapshot.data!);
                      setState(() {});
                    },
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNewTaskModal(context),
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }

  void _showNewTaskModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => _NewTaskModal(
        onTaskCreated: (task) {
          setState(() {
            taskRepository.addTask(task);
          });
        },
      ),
    );
  }
}

class _NewTaskModal extends StatelessWidget {
  const _NewTaskModal({required this.onTaskCreated});

  final void Function(Task task) onTaskCreated;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(21)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(vertical: 33, horizontal: 23),
      child: _FormNewTask(onTaskCreated: onTaskCreated),
    );
  }
}

class _FormNewTask extends StatelessWidget {
  _FormNewTask({
    required this.onTaskCreated,
  });

  final void Function(Task task) onTaskCreated;
  final _keyForm = GlobalKey<FormState>();
  final _controllerTitle = TextEditingController();
  final _controllerSubTitle = TextEditingController();
  final _controllerDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _keyForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const H1('Nueva Tarea'),
          const SizedBox(height: 26),
          TextFormField(
            controller: _controllerTitle,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              filled: true,
              fillColor: Colors.white,
              hintText: 'Título de la tarea',
            ),
            validator: (value) {
              return (value == null || value.isEmpty)
                  ? 'Debe ingresar un título'
                  : null;
            },
          ),
          const SizedBox(height: 26),
          TextFormField(
            controller: _controllerSubTitle,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              filled: true,
              fillColor: Colors.white,
              hintText: 'Sub-Título de la tarea',
            ),
          ),
          const SizedBox(height: 26),
          TextFormField(
            controller: _controllerDescription,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              filled: true,
              fillColor: Colors.white,
              hintText: 'Descripción de la tarea',
            ),
          ),
          const SizedBox(height: 26),
          ElevatedButton(
            onPressed: () {
              if (_keyForm.currentState!.validate()) {
                final detailTask = (_controllerSubTitle.text.isNotEmpty ||
                        _controllerDescription.text.isNotEmpty)
                    ? TaskDetail(
                        subtitle: _controllerSubTitle.text,
                        description: _controllerDescription.text)
                    : null;
                final task =
                    Task(_controllerTitle.text, taskDetail: detailTask);
                onTaskCreated(task);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Guardar'),
          )
        ],
      ),
    );
  }
}

class _TaskList extends StatelessWidget {
  const _TaskList(this.tasklist, {required this.onTaskDoneChanged});

  final List<Task> tasklist;
  final void Function(Task task) onTaskDoneChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const H1('Tareas'),
          Expanded(
            child: ListView.separated(
              itemCount: tasklist.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (_, index) => _TaskItem(
                tasklist[index],
                onTap: () => onTaskDoneChanged(tasklist[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskItem extends StatelessWidget {
  const _TaskItem(this.task, {this.onTap});
  final Task task;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
          child: Row(
            children: [
              Icon(
                task.done ? Icons.check_box : Icons.check_box_outline_blank,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    task.taskDetail != null
                        ? task.taskDetail!.subtitle.isEmpty
                            ? Container()
                            : Text(
                                task.taskDetail!.subtitle,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontStyle: FontStyle.italic),
                              )
                        : Container(),
                    task.taskDetail != null
                        ? task.taskDetail!.description.isEmpty
                            ? Container()
                            : Text(
                                task.taskDetail!.description,
                                softWrap: true,
                              )
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).colorScheme.primary,
      child: Column(
        children: [
          const Row(children: [Shape()]),
          Image.asset(
            'assets/img/tasks-list-image.png',
            width: 120,
            height: 120,
          ),
          const SizedBox(height: 16),
          const H1(
            'Completa tus tareas',
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
