import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';

import '../common/color_extension.dart';
class FoodDetailsStepRow extends StatelessWidget {

  final Map sObj;
  final bool isLast;
  const FoodDetailsStepRow({super.key,required this.sObj, this.isLast=false});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: TColor.secondaryColor1,
                borderRadius: BorderRadius.circular(10)
              ),
              alignment: Alignment.center,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  border: Border.all(color: TColor.white,width: 3),
                  borderRadius: BorderRadius.circular(9)
                ),
              ),
            ),
            if(!isLast)
              DottedDashedLine(height: 50, width: 0, axis: Axis.vertical,dashColor: TColor.secondaryColor1,)
          ],
        ),

        SizedBox(width: 10,),
        Expanded(child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text("Step ${sObj["no"].toString()}",
            style: TextStyle(
              color: TColor.black,
              fontSize: 14,
              fontWeight: FontWeight.w500
            ),),
            Text(
              sObj["detail"].toString(),
              style: TextStyle(
                color: TColor.gray,
                fontSize: 12
              ),
            )
          ],
        ))

      ],

    );
  }
}
