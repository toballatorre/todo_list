import 'package:flutter/material.dart';
import 'package:todo_list/app/views/splash/splash_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF40B7AD);
    const textColor = Color(0xFF4A4A4A);
    const background = Color(0xFFF5F5F5);
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 54),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        bottomSheetTheme:
            const BottomSheetThemeData(backgroundColor: Colors.transparent),
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
        scaffoldBackgroundColor: background,
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Poppins',
              bodyColor: textColor,
              displayColor: textColor,
            ),
        useMaterial3: false,
      ),
      home: const SplashPage(),
    );
  }
}
