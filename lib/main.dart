import 'package:fitness_tracker/OPEN_AI/chatbot_setup.dart';

import 'package:fitness_tracker/common/color_extension.dart';

import 'package:fitness_tracker/view/on_boarding/started_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth/supabase_api_key.dart';

 void main() async  {
  await Supabase.initialize(
      url: SUPABASE_URL,
       anonKey: SUPABASE_API_KEY
      );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        primaryColor: TColor.primaryColor1,
        fontFamily: "Poppins"
      ),
      home: const StartedView(),
         // home:const ChatmessageaiUi()
    ));
  }
}

