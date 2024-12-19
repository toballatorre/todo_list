import 'package:flutter/material.dart';
import 'package:todo_list/app/model/task.dart';
import 'package:todo_list/app/views/components/h1.dart';
import 'package:todo_list/app/views/components/shape.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(),
          Expanded(child: _TaskList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNewTaskModal(context),
        child: const Icon(
          Icons.add,
          size: 50,
        ),
      ),
    );
  }

  void _showNewTaskModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => const _NewTaskModal(),
    );
  }
}

class _NewTaskModal extends StatelessWidget {
  const _NewTaskModal();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(21)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(vertical: 33, horizontal: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const H1('Nueva Tarea'),
          const SizedBox(height: 26),
          TextField(
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
            onPressed: () {},
            child: const Text('Guardar'),
          )
        ],
      ),
    );
  }
}

class _TaskList extends StatefulWidget {
  const _TaskList();

  @override
  State<_TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<_TaskList> {
  final tasklist = List<Task>.generate(
    10,
    (index) => Task('Task: $index'),
  );

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
                onTap: () {
                  tasklist[index].done = !tasklist[index].done;
                  setState(() {});
                },
              ),
            ),
          ),
        ],
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
              Text(task.title),
            ],
          ),
        ),
      ),
    );
  }
}
