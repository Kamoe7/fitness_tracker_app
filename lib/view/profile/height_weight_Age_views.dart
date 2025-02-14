import 'package:flutter/material.dart';

import '../../common/color_extension.dart';

class HeightWeightAgeViews extends StatelessWidget {
  final String text;
  final String string;

  const HeightWeightAgeViews(
      {super.key, required this.text, required this.string});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: TColor.white,
                boxShadow: [
                  BoxShadow(color: Colors.black12.withOpacity(0.2),
                      blurRadius: 2)
                ]
            ),

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (bounds) {
                            return LinearGradient(colors: TColor.primaryG,
                                begin: Alignment.centerLeft,
                                end: Alignment.centerLeft).createShader(
                                Rect.fromLTRB(0, 0, bounds.width,
                                    bounds.height));
                          },
                          child:
                          Text(text, style: TextStyle(color: TColor.white
                              .withOpacity(0.7),
                              fontSize: 15,
                              fontWeight: FontWeight.w500),),
                        ),
                        SizedBox(height: 5,),
                        Text(string, style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: TColor.gray),)
                      ],
                    ),
                  )
              ),
    );
  }
}
