import 'package:flutter/material.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

import '../common/color_extension.dart';

class NutritionRow extends StatelessWidget {
  final Map nObj;
  const NutritionRow({super.key,required this.nObj});

  @override
  Widget build(BuildContext context) {
    var media=MediaQuery.of(context).size;
    var val =double.tryParse(nObj["value"].toString()) ?? 1;
    var maxval= double.tryParse(nObj["max_value"].toString()) ?? 1;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: TColor.white,
        borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 2)]
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(nObj['title'],
                style: TextStyle(
                  color: TColor.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 12
                ),),
                SizedBox(width: 4,),
                Image.asset(nObj["image"].toString(),
                width: 15,
                height: 15,)
                ,
                const Spacer(),
                Text("${nObj["value"].toString()} ${nObj["unit_name"].toString()}",
                style: TextStyle(
                  color: TColor.gray,fontSize: 11
                ),)
              ],
            ),
            SizedBox(height: 4,),
            SimpleAnimationProgressBar(
                ratio: val/maxval, width: media.width-30, height: 10, 
                direction: Axis.horizontal, 
                backgroundColor: Colors.grey.shade100,
                foregrondColor: Colors.purple, 
                duration: Duration(seconds: 3), 
                curve: Curves.fastLinearToSlowEaseIn,
              borderRadius: BorderRadius.circular(7.5),
              gradientColor: LinearGradient(colors: TColor.primaryG,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight),
            )
          ],
        ),
      ),
    );
  }
}
