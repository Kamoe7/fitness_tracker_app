import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;

Future<void> showDeleteAccountDialog(BuildContext context) async {
  showDialog(context: context, builder: (context)=>AlertDialog(
    title: const Text("Delete Account"),
    content: const Text("This action is permanent. Are you sure?"),
    actions: [
      TextButton(onPressed: ()=>Navigator.pop(context), child: const Text("Cancel")),
      TextButton(onPressed: (){
        Navigator.pop(context);
        _deleteUser(context);
      }, child: const Text('Delete',style: TextStyle(color:Colors.red),))
    ],
  ));
}



Future<void> _deleteUser(BuildContext context) async{
  final supabase = Supabase.instance.client;
  final session = supabase.auth.currentSession;
  final accessToken = session?.accessToken;

  if(accessToken == null){
    print("No User session");
    return;
  }

  try{
    final response = await http.post(
      Uri.parse("http://10.0.2.2:5000/delete-user"),
      headers:{
        'Content-Type':'application/json',
        'Authorization':'Bearer $accessToken'
      }

    );
    if(response.statusCode == 200){
      print("Account deleted");
      await supabase.auth.signOut();

      //navigate to login page
      if(context.mounted){
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
    else{
      print("Delete failed: ${response.body}");
      _showError(context,"Failed to delete your account");
    }
  }catch(e){
    print("Error: $e");
    _showError(context,"Something went wrong");
  }
}
void _showError(BuildContext context, String msg){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(msg)));
}