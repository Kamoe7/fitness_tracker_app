import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:fitness_tracker/common_widget/icon_title_next_row.dart';
import 'package:fitness_tracker/common_widget/round_gradient_button.dart';
import 'package:flutter/material.dart';

import '../../common/color_extension.dart';

class SleepAddAlarmView extends StatefulWidget {
  final DateTime date;
  const SleepAddAlarmView({super.key,required this.date});

  @override
  State<SleepAddAlarmView> createState() => _SleepAddAlarmViewState();
}

class _SleepAddAlarmViewState extends State<SleepAddAlarmView> {
  bool positive=false;

  @override
  Widget build(BuildContext context) {
   var media=MediaQuery.of(context).size;

    return Scaffold(

      appBar:AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.all(8),
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: TColor.lightGray,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset("assets/img/back_btn.png",width: 15,height: 15,fit: BoxFit.contain,),

          ),
        ),


        title: Text("Add Alarm",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
        actions: [
          InkWell(
            onTap: (){},
            child: Container(
              margin: EdgeInsets.all(8),
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: TColor.lightGray,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset("assets/img/more_btn.png",width: 15,height: 15,fit: BoxFit.contain,),
            ),
          )
        ],
      ),
      backgroundColor: TColor.white,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 15,horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            IconTitleNextRow(icon: "assets/img/Icon-Bed.png", title: "Bedtime", time: "09:00 PM", onPressed: (){}, color: TColor.lightGray),
            SizedBox(height: 10,),
            IconTitleNextRow(icon: "assets/img/Icon-Time.png", title: "Hours of sleep", time: "8hours 30minutes", onPressed: (){}, color: TColor.lightGray),
            SizedBox(height: 10,),
            IconTitleNextRow(icon: "assets/img/Icon-Repeat.png", title: "Repeat", time: "Mon to Fir", onPressed: (){}, color: TColor.lightGray),
            SizedBox(height: 10,),

            Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: TColor.lightGray,
                borderRadius: BorderRadius.circular(15)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  SizedBox(width: 15,),
                  Container(
                    width: 30,
                    height: 30,
                    alignment: Alignment.center,
                    child: Image.asset("assets/img/Icon-Vibrate.png",width: 18,
                    height: 18,
                    fit: BoxFit.contain,),
                  ),
                  SizedBox(width: 8,),
                  Expanded(child: Text("Vibrate When Alarm Sound",style: TextStyle(color: TColor.gray,fontSize: 12),)),
                  SizedBox(
                    height: 30,
                    child: Transform.scale(
                      scale: 0.7,
                      child: CustomAnimatedToggleSwitch<bool>(
                          current: positive,
                          values: [false,true],
                          dif: 0.0,
                          indicatorSize: Size.square(30),
                          animationDuration: Duration(milliseconds: 200),
                          animationCurve: Curves.linear,
                          onChanged: (b)=>setState(() =>positive=b),
                          iconBuilder: (context,local,global){
                            return SizedBox();
                          },
                        defaultCursor: SystemMouseCursors.click,
                        onTap: ()=>setState(() =>positive=!positive),
                        iconsTappable: false,
                        wrapperBuilder: (context,global,child){
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                    left:10,
                                    right: 10,
                                    height: 30,
                                    child: DecoratedBox(decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: TColor.secondaryG),
                                      borderRadius: BorderRadius.circular(50)
                                    )),
                                  ),
                                  child,
                                ],
                              ) ;
                        },
                        foregroundIndicatorBuilder: (context,global){
                            return SizedBox.fromSize(
                              size: Size(10,10),
                              child: DecoratedBox(decoration: BoxDecoration(
                                color: TColor.white,
                                borderRadius: BorderRadius.all(Radius.circular(50)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black38,
                                    spreadRadius: 0.05,
                                    blurRadius: 1.1,
                                    offset: Offset(0.0, 0.8)
                                  )
                                ]
                              )),
                            );
                        },


                          ),
                    ),
                  )
                ],
              ),

            ),
            const Spacer(),
            RoundGradientButton(title: "Add", onPressed: (){}),
            SizedBox(height: 20,)

          ],),
      ),



    );
  }
}
