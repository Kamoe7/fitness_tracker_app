import 'package:fitness_tracker/common/color_extension.dart';
import 'package:fitness_tracker/common_widget/round_gradient_button.dart';
import 'package:fitness_tracker/view/on_boarding/on_boarding_view.dart';
import 'package:flutter/material.dart';

class StartedView extends StatefulWidget {
  const StartedView({super.key});

  @override
  State<StartedView> createState() => _StartedViewState();
}

class _StartedViewState extends State<StartedView> {
  bool isChangedColor = false;
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: TColor.white,
      body: Container(
        width: media.width,
        decoration: BoxDecoration(
          gradient: isChangedColor
              ? LinearGradient(
                  colors: TColor.primaryG,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)
              : null,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Text(
                  'Fitness',
                  style: TextStyle(
                      color: TColor.black,
                      fontSize: 36,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  'Everybody Can Train',
                  style: TextStyle(
                    color: TColor.gray,
                    fontSize: 18,
                  ),
                ),
                Spacer(),
                SafeArea(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: RoundGradientButton(
                          title: ' Get Started',
                          type: isChangedColor
                              ? RoundButtonType.textGradient
                              : RoundButtonType.bgGradient,
                          onPressed: () {
                            if (isChangedColor) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OnBoardingView()));
                            } else {
                              setState(() {
                                isChangedColor = true;
                              });
                            }
                          })),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
