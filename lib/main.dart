import 'package:fitness_tracker/common/color_extension.dart';
import 'package:fitness_tracker/view/main_tab/main_tab_view.dart';
import 'package:fitness_tracker/view/on_boarding/started_view.dart';
import 'package:fitness_tracker/view/profile/profile_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        primaryColor: TColor.primaryColor1,
        fontFamily: "Poppins"
      ),
      home: const StartedView(),
    );
  }
}

