import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class TabButton extends StatelessWidget {
  final String icon;
  final String selectIcon;
  final VoidCallback onTap;
  final bool isActive;
  const TabButton({super.key,required this.icon,required this.selectIcon,required this.isActive,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(isActive ? selectIcon:icon,height: 25,width: 25,),
          SizedBox(height:isActive? 3:7),
          if(isActive)
          Container(
            height: 4,
            width: 4,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: TColor.secondaryG),
              borderRadius: BorderRadius.circular(2)
            ),
          )

          
          
          
        ],
      ),

    );
  }
}
