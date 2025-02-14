import 'package:flutter/material.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

import '../common/color_extension.dart';

class WorkoutView extends StatelessWidget {
  final Map wObj;
  const WorkoutView({super.key,required this.wObj});

  @override
  Widget build(BuildContext context) {
    var media =MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8,horizontal: 2),
      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
      decoration: BoxDecoration(
        color: TColor.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 2)]),
      child: Row(
        children: [
          ClipRect(

            child: Image.asset(wObj['image'].toString(),height: 60,width: 60,fit: BoxFit.cover,),
          ),
          SizedBox(width: 15,),
          Expanded(
            child: Column(
              children: [
                Text(wObj['name'].toString(),style: TextStyle(
                  color: TColor.black,
                  fontSize: 12
                ),),
                Text(
                  "${wObj['kcal'].toString()} Calories Burn | ${wObj['time'].toString()} minutes" ,style: TextStyle(
                  color: TColor.gray,fontSize: 10
                ),),
                SizedBox(height: 4,),
                SimpleAnimationProgressBar(
                    ratio: wObj["progress"] as double? ?? 0.0,
                    width: media.width*0.5,
                    height: 15,
                    direction: Axis.horizontal,
                    backgroundColor: Colors.grey.shade100,
                    foregrondColor: Colors.purple,
                    duration: Duration(seconds: 3),
                    curve: Curves.fastLinearToSlowEaseIn,borderRadius:BorderRadius.circular(7.5),
                     gradientColor:LinearGradient(colors: TColor.primaryG,
                     begin: Alignment.centerLeft,
                     end: Alignment.centerRight) ,

                )

              ],
            ),
          ),

          IconButton(onPressed: (){}, icon: Image.asset("assets/img/Workout-Btn.png",width: 30,height: 30,
          fit: BoxFit.contain,
          ))


        ],

      ),
    );
  }
}
