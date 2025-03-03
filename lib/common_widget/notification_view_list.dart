import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class NotificationViewList extends StatelessWidget {
  final  Map wObj;
  const NotificationViewList({super.key,required this.wObj});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8,horizontal: 20),
      child:Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(wObj["image"].toString(),height: 40,width: 40,fit: BoxFit.cover,),
            
          ),
          SizedBox(width: 15,),
          Expanded(child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(wObj["title"].toString(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13,color: TColor.black),),
              Text(wObj["time"].toString(),style: TextStyle(fontSize: 10,color: TColor.gray),)
              
            ],
            
          )),
          IconButton(onPressed: (){}, icon: Image.asset("assets/img/sub_menu.png",height: 15,width: 15,fit: BoxFit.contain,))
        ],

      ),

      
    );
  }
}
