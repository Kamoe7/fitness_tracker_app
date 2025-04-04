import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:fitness_tracker/riverpod/bmi_provider.dart';
import 'package:fitness_tracker/riverpod/provider.dart';
import 'package:fitness_tracker/view/profile/height_weight_Age_views.dart';
import 'package:fitness_tracker/view/profile/setting_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/color_extension.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  bool positive=false;


  List accountArr = [
    {"image": "assets/img/p_personal.png", "name": "Personal Data", "tag": "1"},
    {"image": "assets/img/Icon-Achievement.png", "name": "Achievement", "tag": "2"},
    {
      "image": "assets/img/Icon-Activity.png",
      "name": "Activity History",
      "tag": "3"
    },
    {
      "image": "assets/img/Icon-Workout.png",
      "name": "Workout Progress",
      "tag": "4"
    }
  ];

  List otherArr=[
    {"image":"assets/img/p_contact.png","name":"Contact Us","tag":"5"},
    {"image":"assets/img/p_privacy.png","name":"Privacy Policy","tag":"6"},
    {"image":"assets/img/p_setting.png","name":"Setting","tag":"7"},
  ];

  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userDataProvider);

    if(userData.isLoading){
      return Center(child: CircularProgressIndicator());
    }
    if(userData.hasError){
      return Text("Error: ${userData.error}");
    }


    final data = userData.value;
    if(data==null){
      return Center(child: Text("No user data available"));
    }


    final user=ref.watch(userProvider);
    var media=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25,vertical:15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(child:
                                Image.asset("assets/img/Back-Navs.png",width: 30,height: 30,),
                                ),
                          Text("Profile",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color: TColor.black),),
                          Image.asset("assets/img/Detail-Navs.png",width: 30,height: 30,)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                        child: Row(
                          children: [
                            Image.asset("assets/img/Latest-Pic.png",width: 50,height: 50,),
                            SizedBox(width: media.width*0.06,),
                            Expanded(child: Row(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${user.username} ${user.lastname}",style: TextStyle(color: TColor.black,fontSize: 15,fontWeight: FontWeight.w700),),
              Text("Lose a Fat Program",style: TextStyle(color: TColor.gray,fontSize: 12),)
            ],
          )
                            ],)),
                            Container(
          height: 30,
          width: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: TColor.primaryG),
            borderRadius: BorderRadius.circular(15)
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text("Edit",style: TextStyle(fontSize: 12,color: TColor.white,),textAlign: TextAlign.center,),
          ),
                            ),

                          ],
                        ),
                      ),

                      SizedBox(height: media.width*0.05,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [

                            //make change here
                           HeightWeightAgeViews(text: "${data['height']} cm", string: "Height"),
                            SizedBox(width: media.width*0.05,),
                            HeightWeightAgeViews(text: "${data['weight']} kg ", string: "Weight"),
                            SizedBox(width: media.width*0.05,),
                            HeightWeightAgeViews(text: "${data['age']} yrs", string: "Age")
                          ],
                        ),
                      ),
                      SizedBox(height: media.width*0.05,),

                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                        decoration: BoxDecoration(
                          color: TColor.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 2)]
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Account",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700,color: TColor.black),),
                            SizedBox(height: 8,
                            ),
                            ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: accountArr.length,
            itemBuilder:(context, index){
              var wObj=accountArr[index] as Map? ??{};
              return SettingRow(
                icon: wObj['image'].toString(),
                title: wObj['name'].toString(),
                onPressed: (){},

              );
            }
                            )
                          ],
                        )


                      ),
                      SizedBox(height: media.width*0.05,),

                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                        decoration: BoxDecoration(
                            color: TColor.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 2)]
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Notification",style: TextStyle(fontSize: 15,color: TColor.black,fontWeight: FontWeight.w700,),
                              
                            ),
                            SizedBox(height: 8,),
                            SizedBox(height: 8,),
                            SizedBox(height: 30,
                            child: Row(
                              children: [
                                Image.asset("assets/img/p_notification.png",
                                  height: 15,width: 15,fit: BoxFit.contain,
                                ),
                                SizedBox(width: 15,),
                                Expanded(child: Text("Pop-up Notification",
                                  style: TextStyle(
                                      color: TColor.black,
                                      fontSize: 12),)),
                            CustomAnimatedToggleSwitch<bool>(
                                current: positive,
                                values: [false,true],
                                indicatorSize: Size.square(30.0),
                                animationDuration: Duration(milliseconds: 200),
                                animationCurve: Curves.linear,
                                onChanged: (b)=>setState(() =>positive=b),
                                iconBuilder: (context,local,global){
                                  return SizedBox();
                                },

                              onTap: () => setState(() => positive = !positive),
                              iconsTappable: false,
                              wrapperBuilder: (context,global,child){
                                  return Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Positioned(
                                        left: 10,
                                        right: 10,
                                        height: 30,
                                        child: DecoratedBox(decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: TColor.secondaryG),
                                          borderRadius: BorderRadius.all(Radius.circular(50)),
                                        )),
                                      ),child
                                    ],
                                  );
                              },
                              foregroundIndicatorBuilder: (context,global){
                                  return SizedBox.fromSize(
                                    size: Size(10, 10),
                                    child: DecoratedBox(decoration:BoxDecoration(
                                      color: TColor.white,
                                      borderRadius: BorderRadius.all(Radius.circular(50)),
                                      boxShadow:  [
                                        BoxShadow(
                                        color:Colors.black38,
                                        spreadRadius:0.05,
                                        blurRadius:1.1,
                                        offset:Offset(0.0,0.8)
                                        )]
                                    )),
                                  );
                              },

                            ),
                              ],
                            ),
                            ),



                            
                          ],
                        ),

                      ),
                      SizedBox(height: media.width*0.05,),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                        decoration: BoxDecoration(
                            color: TColor.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 2)]
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Other",style: TextStyle(color: TColor.black,fontWeight: FontWeight.w700,fontSize: 15),),
                            SizedBox(height: 8,),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: otherArr.length,
                                itemBuilder: (context,index){
                                var aObj=otherArr[index];
                                return SettingRow(icon: aObj['image'], title: aObj['name'], onPressed: (){});
                                })
                          ],
                        )
                      )


                    ],
          ),
        ),
      ),
    );
  }
}
