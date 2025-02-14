import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class RoundTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String icon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? rightIcon;
  final String  hintText;
  final EdgeInsets? margin;


  const RoundTextfield({super.key, this.controller,required this.hintText,required this.icon,this.keyboardType,this.obscureText=false,this.rightIcon,this.margin});


  @override
  Widget build(BuildContext context) {

    return  Container(
      margin: margin,
        decoration: BoxDecoration(color: TColor.lightGray,borderRadius: BorderRadius.circular(15)),

        child: TextField(
          controller:controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical:15,horizontal: 15),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: hintText,
              suffixIcon: rightIcon,

              prefixIcon: Container(
                alignment: Alignment.center,
                width: 20,
                height: 20,
                child: Image.asset(icon,
                  height: 20,
                  width: 20,
                  fit: BoxFit.contain,
                  color: TColor.gray,),
              ),


              hintStyle: TextStyle(color: TColor.gray,fontSize: 12)
          ),
        )
    );
  }
}
