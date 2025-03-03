import 'package:fitness_tracker/common_widget/notification_view_list.dart';
import 'package:flutter/material.dart';

import '../../common/color_extension.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    List notificationArr = [
      {"image": "assets/img/workout_1.png", "title": "Hey, it’s time for lunch", "time": "About 1 minutes ago"},
      {"image": "assets/img/workout_2.png", "title": "Don’t miss your lowerbody workout", "time": "About 3 hours ago"},
      {"image": "assets/img/workout_3.png", "title": "Hey, let’s add some meals for your b", "time": "About 3 hours ago"},
      {"image": "assets/img/workout_4.png", "title": "Congratulations, You have finished A..", "time": "29 May"},
      {"image": "assets/img/workout_3.png", "title": "Hey, it’s time for lunch", "time": "8 April"},
      {"image": "assets/img/workout_4.png", "title": "Ups, You have missed your Lowerbo...", "time": "8 April"},
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: TColor.white,
        centerTitle: true,

        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.all(8),
            height: 40,
            width: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: TColor.lightGray,
            borderRadius: BorderRadius.circular(12)
          ),
          child: Image.asset("assets/img/back_btn.png",
          height: 15,
          width: 15,),
          ),
        ),
        title: Text("Notification",
          style: TextStyle(
            color: TColor.black,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),

        actions: [
          InkWell(
            onTap: (){},
            child: Container(
              margin: EdgeInsets.all(8),
              alignment: Alignment.center,
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: TColor.lightGray,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Image.asset("assets/img/more_btn.png",
              height: 15,
              width: 15,),
            ),
          )
        ],

        ),
      backgroundColor: TColor.white,
      body: ListView.separated(
          itemBuilder: ((context,index){
            var wObj=notificationArr[index] as Map? ?? {};
            return NotificationViewList(wObj: wObj);
          }),
          separatorBuilder: (context,index) {
            return Divider(color: TColor.black.withOpacity(0.2),height: 1);
          },
          itemCount: notificationArr.length)
    );
  }
}
