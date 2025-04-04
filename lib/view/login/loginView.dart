import 'package:fitness_tracker/auth/auth_services.dart';
import 'package:fitness_tracker/common_widget/round_gradient_button.dart';
import 'package:fitness_tracker/common_widget/round_textfield.dart';
import 'package:fitness_tracker/riverpod/provider.dart';
import 'package:fitness_tracker/view/main_tab/main_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../common/color_extension.dart';

class Loginview extends ConsumerStatefulWidget {
  const Loginview({super.key});

  @override
  ConsumerState<Loginview> createState() => _LoginviewState();
}

class _LoginviewState extends ConsumerState<Loginview> {
  //get auth service
  final authService=AuthService();

  //text controllers
  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();

  //login button pressed
  void login() async{
    //prepare data
    final email=_emailController.text;
    final password=_passwordController.text;

    //attempt login
    try{
      final response = await authService.signInWithEmailPassword(email, password);

      final user=response.user;
      final userId=user?.id;

      if(userId != null){

        //Fetch user data from supabase profiles table
        final data=await Supabase.instance.client
            .from('profiles')
            .select()
            .eq('id', userId)
            .single();

        //store in riverpod
        ref.read(userProvider.notifier).updateUser(username: data['username'], lastName: data['lastname']);


        print("user data loaded sucessfully");

      }

      print("✅ Login successful");


      //fetch the session manually
      final session=Supabase.instance.client.auth.currentSession;
      print('current Session: $session');

      if(session!=null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>MainTabView()));
      }
      else{
        print("no session after login");
      }


    }

    catch(e){
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  bool isCheck=false;
  void _isPasswordVisibility(){
    setState(() {
      isCheck=!isCheck;
    });
  }
  @override
  Widget build(BuildContext context) {
    var media=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: media.height*0.9,
                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),

                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Hey there",style: TextStyle(fontWeight:FontWeight.w600,fontSize: 20),),
                        Text("Welcome Back",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                      SizedBox(height: media.width*0.05,),
                      RoundTextfield(
                        controller: _emailController,
                          hintText: "Email", icon: "assets/img/Message.png"),
                      SizedBox(height: media.width*0.05,),
                      RoundTextfield(
                        controller: _passwordController,
                        hintText: "Password", icon: "assets/img/Lock.png",obscureText:isCheck,rightIcon: TextButton(onPressed: _isPasswordVisibility, child: Container(height: 20,width: 20,alignment:Alignment.center, child: Image.asset("assets/img/Hide-Password.png",fit: BoxFit.contain,),)),),
                            SizedBox(height: media.width*0.05),
                      TextButton(onPressed: (){}, child: Text("Forget your password?",style: TextStyle(color: TColor.gray,fontSize: 15,decoration: TextDecoration.underline),)),



                      Spacer(),
                      RoundGradientButton(title: "Login", onPressed:
                          login
                        //  (){Navigator.push(context, MaterialPageRoute(builder: (context)=>CompleteProfileView()));}
                      ),
                      SizedBox(height: media.width*0.04,),
                      Row(
                        children: [
                          Expanded(child: Container(
                            height: 1,
                            color: TColor.gray.withOpacity(0.5),
                          )),
                          Text(" Or ",style: TextStyle(fontSize: 12,color: TColor.black),),
                          Expanded(child: Container(
                            height: 1,
                            color: TColor.gray.withOpacity(0.5),
                          ))
                        ],
                      ),
                      SizedBox(height: media.width*0.04,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          GestureDetector(
                            onTap: (){},
                            child: SizedBox(
                              height: 50,
                              width: 50,
                              child: Image.asset("assets/img/google.png"),
                            ),
                          ),
                          SizedBox(width: media.width*0.05,),
                          GestureDetector(
                            onTap: (){},
                            child: SizedBox(
                              height: 50,
                              width: 50,
                              child: Image.asset("assets/img/fb.png"),
                            ),
                          )
                        ],
                        
                      ),
                      SizedBox(height: media.width*0.04,),

                      Row(
                        mainAxisSize: MainAxisSize.min,
                          children:  [
                        Text("Don't have an account yet?",style: TextStyle(
                          color: TColor.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                        ),),
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        },
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  color: TColor.secondaryColor1,fontSize: 15,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline),

                            ))
                      ])


                      

                  ],

                              ),


                
              ),
        )

      ),
    );
  }
}
