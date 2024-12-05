import 'package:flutter/material.dart';
import 'package:todo_list/app/views/components/h1.dart';
import 'package:todo_list/app/views/components/shape.dart';
import 'package:todo_list/app/views/task_list/task_list_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Shape(),
            const SizedBox(height: 73),
            Center(
              child: Image.asset(
                'assets/img/onboarding-image.png',
                width: 180,
                height: 168,
              ),
            ),
            const SizedBox(height: 99),
            const Center(child: H1('Lista de Tareas')),
            const SizedBox(height: 21),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const TaskListPage(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'La mejor forma para que no se te olvide nada es anotarlo. Guardar tus tareas y ve completando poco a poco para aumentar tu productividad',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
