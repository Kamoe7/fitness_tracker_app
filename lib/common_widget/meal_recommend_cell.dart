import 'package:fitness_tracker/common_widget/round_gradient_button.dart';
import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class MealRecommendCell extends StatelessWidget {
  final Map fObj;
  final int index;
  const MealRecommendCell({super.key,required this.fObj,required this.index});

  @override
  Widget build(BuildContext context) {
    var media =MediaQuery.of(context).size;
    bool isEvent =index%2==0;
    return  Container(
      margin: EdgeInsets.all(5),
      width: media.width*0.5,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: isEvent
        ?[
          TColor.primaryColor2.withOpacity(0.5),
            TColor.primaryColor1.withOpacity(0.5)
            ]
            :[
              TColor.secondaryColor2.withOpacity(0.5),
              TColor.secondaryColor1.withOpacity(0.5)
            ]
        ),
            borderRadius: BorderRadius.circular(25)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(fObj["image"].toString(),
            width: media.width*0.3,
            height: media.width*0.25,
            fit: BoxFit.contain,
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(fObj["name"],
          style: TextStyle(color: TColor.black,
          fontSize: 14,
          fontWeight: FontWeight.w500),),
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "${fObj["size"]} | ${fObj["time"]} | ${fObj["kcal"]}",
              style: TextStyle(color: TColor.gray,
                  fontSize: 12,
         ),),
          ),
          SizedBox(height: 15,),
          Padding(padding: EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            width: 90,
            height: 35,
            child: RoundGradientButton(
                fontSize: 12,
                type: isEvent
                ?RoundButtonType.bgGradient
                :RoundButtonType.bgSGradient,
                title: "View", onPressed: (){}),
          ),

          )

        ],
      ),

    );
  }
}
