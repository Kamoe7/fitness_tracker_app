import 'package:fitness_tracker/view/login/CompleteProfileView.dart';
import 'package:fitness_tracker/view/login/loginView.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      //listen to auth stage changes
        stream: Supabase.instance.client.auth.onAuthStateChange,

        //build appropriate page based
        builder: (context,snapshot){
          print("Stream Triggered: ${snapshot.connectionState}"); // Debugging
          //loading
          if(snapshot.connectionState==ConnectionState.waiting){
            return Scaffold(
              body: Center(child: CircularProgressIndicator(),),
            );
          }

          final session = snapshot.data?.session ?? Supabase.instance.client.auth.currentSession;
          print("Auth State Change - Session: $session"); // Debugging
          //final session= snapshot.hasData? snapshot.data!.session:null;

          if(session!=null){
            //print("User logged in");
            return CompleteProfileView();
          }else{
            return Loginview();
            //print("Login failed");
          }
        });
  }
}
