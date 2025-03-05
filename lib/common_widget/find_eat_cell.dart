import 'package:fitness_tracker/common_widget/round_gradient_button.dart';
import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class FindEatCell extends StatelessWidget {
  final Map fObj;
  final int index;
  const FindEatCell({super.key,required this.fObj,required this.index});

  @override
  Widget build(BuildContext context) {
    var media=MediaQuery.of(context).size;
    bool isEvent=index%2==0;
    return Container(
      margin: EdgeInsets.all(8),
      width: media.width*0.5,
      decoration:BoxDecoration(
        gradient: LinearGradient(colors: isEvent
        ?
        [
            TColor.primaryColor2.withOpacity(0.5),
            TColor.primaryColor1.withOpacity(0.5)
        ]
          :
        [
          TColor.secondaryColor2.withOpacity(0.5),
          TColor.secondaryColor1.withOpacity(0.5)
        ],
        ),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(75),
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25)
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(fObj['image'].toString(),width: media.width*0.3,height: media.width*0.25,fit: BoxFit.contain,)
            ],
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(fObj["name"],style:
              TextStyle(
                color: TColor.black,
                fontWeight: FontWeight.w500,
                fontSize: 14
              ),),
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(fObj["number"],
          style: TextStyle(
            fontSize: 12,
            color: TColor.gray
          ),),
          ),
          SizedBox(height: 15,),
          Padding(padding: EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            height: 25,
            width: 90,
            child: RoundGradientButton(
                fontSize: 12,
                type: isEvent
                ? RoundButtonType.bgGradient
                : RoundButtonType.bgSGradient,
                title: "Select", onPressed: (){}),
          ),
          )
        ],
      ),

    );
  }
}
