import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/img/shape.png',
              width: 141,
              height: 129,
            ),
            const SizedBox(height: 73),
            Center(
              child: Image.asset(
                'assets/img/onboarding-image.png',
                width: 180,
                height: 168,
              ),
            ),
            const SizedBox(height: 99),
            Center(
              child: Text(
                'Lista de Tareas',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const SizedBox(height: 21),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'La mejor forma para que no se te olvide nada es anotarlo. Guardar tus tareas y ve completando poco a poco para aumentar tu productividad',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
