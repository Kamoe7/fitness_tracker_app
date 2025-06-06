import 'package:fitness_tracker/auth/auth_services.dart';
import 'package:fitness_tracker/common_widget/round_gradient_button.dart';
import 'package:fitness_tracker/common_widget/round_textfield.dart';
import 'package:fitness_tracker/riverpod/provider.dart';
import 'package:fitness_tracker/view/login/CompleteProfileView.dart';
import 'package:fitness_tracker/view/login/loginView.dart';
import 'package:flutter/material.dart';
import 'package:fitness_tracker/common/color_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class SignupView extends ConsumerStatefulWidget {
  const SignupView({super.key});

  @override
  ConsumerState<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends ConsumerState<SignupView> {

  //auth service
  final authService=AuthService();
  final _userName=TextEditingController();
  final _lastName=TextEditingController();
  final _emilController=TextEditingController();
  final _passwordController=TextEditingController();
  //final _confirmPassController=TextEditingController();

  //attempt signup
  void signUp() async{
    final username=_userName.text;
    final lastname=_lastName.text;
    final email=_emilController.text;
    final password=_passwordController.text;
    //final confirmPass=_confirmPassController.text;

   // if(password!=confirmPass){
    //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Password don't match")));}

    try{
      final response = await authService.signUpWithEmailPassword(email, password);

      final user =response.user;
      final userId=user?.id; //this gets the user id

      if(userId != null){
        //insert user data into profiles table
        await Supabase.instance.client.from('profiles').insert({
          'id':userId,
          'username':username,
          'lastname':lastname,
          'email':email,

        });
        ref.read(userProvider.notifier).updateUser(username: username, lastName: lastname);

        print("user profile created successfully!");

      }

      //Navigate to home page;
      if(mounted){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> CompleteProfileView()));
      }


    }catch(e){
      if(mounted){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Error: $e")));
    }}



  }


  get controller => null;
  bool isCheck=false;
  bool _obscureText=false;
  void _istogglePasswordVisibility(){
    setState(() {
      _obscureText=!_obscureText;
    });
  }



  @override
  Widget build(BuildContext context) {
    var media =MediaQuery.of(context).size;
    return Scaffold(

      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Hey there,",
                  style: TextStyle(color: TColor.gray, fontSize: 16),
                ),
                Text(
                  "Create an Account",
                  style: TextStyle(
                      color: TColor.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
               RoundTextfield(controller: _userName, hintText: "Name", icon: "assets/img/Profile.png"),
                SizedBox(
                  height: media.width * 0.05,
                ),
                RoundTextfield(controller: _lastName, hintText: "Last Name", icon: "assets/img/Profile.png"),
                SizedBox(
                  height: media.width * 0.05,
                ),
                RoundTextfield(controller: _emilController, hintText: "Email", icon: "assets/img/Message.png"),
                SizedBox(
                  height: media.width * 0.05,
                ),
                RoundTextfield(controller: _passwordController, hintText: "Password", icon: "assets/img/Lock.png",obscureText: _obscureText,
                  rightIcon:TextButton(onPressed: _istogglePasswordVisibility, child:Container(alignment: Alignment.center,width: 20,height: 20,child: Image.asset("assets/img/Hide-Password.png",width: 20,height: 20,fit: BoxFit.contain,),)),),
                SizedBox(
                  height: media.width * 0.05,
                ),
                 Row(
                  children: [

                    IconButton(onPressed: (){
                      setState(() {
                        isCheck=!isCheck;
                      });
                    }, icon: Icon( isCheck?  Icons.check_box_outlined:Icons.check_box_outline_blank_outlined,color: TColor.gray,size: 20,)),

                    Padding(padding: EdgeInsets.only(top: 8),
                        child: Text("By continuing you accept our Privacy Policy and\nTerm of Use",
                            style: TextStyle(color: TColor.gray, fontSize: 10)))

                  ],
                ),
                SizedBox(height: media.width*0.4,),
                RoundGradientButton(title: 'Register', onPressed: signUp),
                SizedBox(height: media.width*0.04),

                Row(
                  children: [
                    Expanded(child: Container(
                      height: 1,
                      color: TColor.gray.withOpacity(0.5),

                    ),

                    ),
                    Text("or",style: TextStyle(color:TColor.black,fontSize: 12),),
                    Expanded(child: Container(
                      height: 1,
                      color: TColor.gray.withOpacity(0.5),
                    ))
                  ],
                ),
                SizedBox(height: media.width*0.04),

                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [


                      GestureDetector(onTap: (){},
                      child: Image.asset('assets/img/google.png',height: 50,)),
                      SizedBox(width: 50,),

                      GestureDetector(onTap: (){},
                      child: Image.asset('assets/img/fb.png',height: 50,),)
                    ],
                  ),
                SizedBox(height: media.width*0.04,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have account?',style: TextStyle(fontSize: 14,color: TColor.black),),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Loginview()));
              }, child: Text('Login',style: TextStyle(fontSize: 15,color: TColor.secondaryColor1,fontWeight: FontWeight.w700))
              )
                  ],
                )




              ],

                )



             ),
           ),
         ),




    );
  }
}


