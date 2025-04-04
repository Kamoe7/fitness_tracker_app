import 'package:fitness_tracker/common_widget/tab_button.dart';
import 'package:fitness_tracker/togerther_ai/chatMessageAI_UI.dart';
import 'package:fitness_tracker/view/Meal_planner/meal_planner.dart';
import 'package:fitness_tracker/view/home/blank_view.dart';
import 'package:fitness_tracker/view/home/home_view.dart';
import 'package:fitness_tracker/view/profile/profile_view.dart';
import 'package:flutter/material.dart';

import '../../common/color_extension.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int selectTab=0;
  final PageStorageBucket pageBucket=PageStorageBucket();
  Widget currentTab=const HomeView();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
     backgroundColor: TColor.white,
      body: PageStorage(bucket: pageBucket, child: currentTab),
      /*
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 70,height: 70,child: InkWell(
       onTap: (){},
       child: Container(
         width: 65,height: 65,
         decoration: BoxDecoration(
           gradient: LinearGradient(colors: TColor.primaryG),
           borderRadius: BorderRadius.circular(35),
           boxShadow: const[BoxShadow(color: Colors.black12,blurRadius: 2)]
         ),
         child: Icon(Icons.search,color: TColor.white,size: 20,),
       ),
      ),
      ),*/
      
      bottomNavigationBar: BottomAppBar(


        child:Container(
          decoration: BoxDecoration(color: TColor.white, boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, -2))
          ]),
        height:kToolbarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TabButton(icon: "assets/img/Home.png", selectIcon: "assets/img/Home-Active.png", isActive: selectTab==0, onTap: (){
              currentTab=HomeView();


                setState(() {
                  selectTab=0;
              });

            }),
            TabButton(icon: "assets/img/Activity.png", selectIcon: "assets/img/activity_tab_select.png", isActive: selectTab==1, onTap: (){
              currentTab=MealPlanner();


                setState(() { selectTab=1;});
              }
            ),
            TabButton(icon: "assets/img/Camera.png", selectIcon: "assets/img/Camera-select.png", isActive: selectTab==2, onTap: (){
              currentTab=ChatmessageaiUi();


                setState(() {
                  selectTab=2;
                });
              }
            ),
            TabButton(icon: "assets/img/Profile.png", selectIcon: "assets/img/Profile-select.png", isActive: selectTab==3, onTap: (){
              currentTab=ProfileView();

                setState(() {selectTab=3;

                });

            })
          ],
        ),
      )
      )
    );
  }
}
