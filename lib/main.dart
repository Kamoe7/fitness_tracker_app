import 'package:fitness_tracker/common/color_extension.dart';
import 'package:fitness_tracker/view/on_boarding/started_view.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async  {
  await Supabase.initialize(
      url: "https://auhzqeuqmlilqdlcdjuf.supabase.co",
       anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF1aHpxZXVxbWxpbHFkbGNkanVmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk2MzA2MzgsImV4cCI6MjA1NTIwNjYzOH0.svCTeLgQDM3qkkeJh53aIb6-Jf_7sPbrVNv5DGtwaSo"
      );
  
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

