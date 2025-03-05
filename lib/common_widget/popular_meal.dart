import 'package:flutter/material.dart';

import '../common/color_extension.dart';
class PopularMeal extends StatelessWidget {
  final Map pObj;
  const PopularMeal({super.key,required this.pObj});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8,horizontal: 2),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: TColor.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 2)]
      ),
      child: Row(
        children: [
          Image.asset(pObj["image"].toString(),
          width: 50,
          height: 50,
          fit: BoxFit.contain,),
          SizedBox(width: 15,),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(pObj["name"],
              style: TextStyle(color: TColor.black,
              fontSize: 14,
                fontWeight: FontWeight.w500
              ),
                  ),
              Text(
                "${pObj["size"]} | ${pObj["time"]} | ${pObj["kcal"]}",
                style: TextStyle(color: TColor.gray,fontSize: 12),
              )
            ],
          )),
          IconButton(onPressed: (){}, icon:Image.asset("assets/img/Workout-Btn.png",width: 25,height: 25,))
          
        ],
      ),
    );
  }
}
