import 'package:fitness_tracker/view/login/loginView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void _showLogoutDialog(BuildContext context){
  showDialog(context: context,
      builder:(context)=>AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(onPressed: ()=>Navigator.pop(context), child: const Text("Cancel")),
          TextButton(
              onPressed: () async {
                Navigator.pop(context); //close dialog
                await Supabase.instance.client.auth.signOut();
                if(context.mounted){
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Loginview()));
                }
                } ,
              child: const Text("Logout"))
        ],
      ));
}