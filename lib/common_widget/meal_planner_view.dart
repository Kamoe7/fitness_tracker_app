import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class MealPlannerView extends StatelessWidget {
  final Map wObj;
  const MealPlannerView({super.key,required this.wObj});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: TColor.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)]),
      child: Row(


        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
          child: Image.asset(wObj["image"].toString(),height: 40,width: 40,
          fit: BoxFit.cover,)

          ),
          SizedBox(width: 15,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(wObj["name"].toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                Text(wObj["time"].toString(),style: TextStyle(color: TColor.gray,fontSize: 10),)
              ],
            ),
          ),
          IconButton(onPressed: (){}, icon: Image.asset("assets/img/bell.png",height: 25,width: 25,),)

        ],
      )
    );


  }
}
