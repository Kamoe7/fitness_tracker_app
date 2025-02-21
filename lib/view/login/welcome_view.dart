import 'package:fitness_tracker/common_widget/round_gradient_button.dart';
import 'package:fitness_tracker/view/main_tab/main_tab_view.dart';
import 'package:flutter/material.dart';

import '../../common/color_extension.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var media=MediaQuery.of(context).size;
    return  Scaffold(
      body: SafeArea(
          child: SizedBox(
            width: media.width,
        height: media.height,

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,

            children: [
              SizedBox(height: media.width*0.2,),

            Image.asset("assets/img/0_5.png",width: media.width*0.75,),
              SizedBox(height: media.width*0.1,),

              Text("Welcome,Sagar",style: TextStyle(color: TColor.black,
                  fontSize: 25,fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
              Text("Your are all set now,let's reach your\ngoals together with us",style: TextStyle(color: TColor.gray),textAlign: TextAlign.center,),



              const Spacer(),
              RoundGradientButton(title: "Go To Home", onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>MainTabView()));
              })
              ]
          ),
        )

      )),

    );
  }
}
