// ignore_for_file: prefer_const_constructors

import 'package:fitness_tracker/common/color_extension.dart';
import 'package:fitness_tracker/common_widget/on_boarding_page.dart';
import 'package:fitness_tracker/view/login/signup_view.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  int selectPage = 0;
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      selectPage = controller.page?.round() ?? 0;

      setState(() {});
    });
  }

  List pageArr = [
    {
      "title": "Track your meal",
      "about":
          "Don't worry if you have trouble determining your goals. We can help you determine your goals and track your goals",
      "image": "assets/img/on_1.png",
    },
    {
      "title": "Get Burn",
      "about":
          "Lets keep burning, to achieve yours goals, it hurst only temporally , if your give up now you will be in pain forever",
      "image": "assets/img/on_2.png",
    },
    {
      "title": "Eat Well",
      "about":
          "Let's start a healthy lifestyle with us, we can determine your diet every day healthy eating is fun",
      "image": "assets/img/on_3.png",
    },
    {
      "title": "Improve Sleep \n Quality",
      "about":
          "Improve the quality of your sleep with us good quality sleep can bring a good mood in the morning",
      "image": "assets/img/on_4.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
             
          PageView.builder(
              controller: controller,
              itemCount: pageArr.length,
              itemBuilder: (context, index) {
                var pObj = pageArr[index] as Map? ?? {};
                return OnBoardingPage(pObj: pObj);
              }),
         
          SizedBox(
            width: 120,
            height: 120,

            child: Stack(
              alignment: Alignment.center,
              children: [
                     SizedBox(
                width: 70,
                height: 70,
                child: CircularProgressIndicator(
                  value: (selectPage +1)/ 4,
                  color: TColor.primaryColor1,
                  strokeWidth: 2,
                ),
              ),
               Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    color: TColor.primaryColor1,
                    borderRadius: BorderRadius.circular(35)),
                child: IconButton(
                  icon: Icon(Icons.navigate_next),
                  color: TColor.white,
                  onPressed: () {


                    if (selectPage < 3) {
                      selectPage += 1;
                      controller.animateToPage(selectPage, duration: Duration(milliseconds: 600), curve: Curves.bounceOut);
                      //controller.jumpToPage(selectPage);
                      setState(() {

                      });
                    } else {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupView()));
                    }
                  },
                ),
              ),
           
                    ]),
          )
        ],
      ),
    );
  }
}
