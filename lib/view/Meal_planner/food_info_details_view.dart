import 'package:fitness_tracker/common_widget/food_details_step_row.dart';
import 'package:fitness_tracker/common_widget/round_gradient_button.dart';
import 'package:fitness_tracker/riverpod/insert_into_meal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:readmore/readmore.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../common/color_extension.dart';

class FoodInfoDetailsView extends ConsumerStatefulWidget {
  final Map mObj;
  final Map dObj;
  const FoodInfoDetailsView({super.key,required this.dObj,required this.mObj});

  @override
  ConsumerState<FoodInfoDetailsView> createState() => _FoodInfoDetailsViewState();
}

class _FoodInfoDetailsViewState extends ConsumerState<FoodInfoDetailsView> {

  List nutritionArr = [
    {"image": "assets/img/burn.png", "title": "180kCal"},
    {"image": "assets/img/egg.png", "title": "30g fats"},
    {"image": "assets/img/proteins.png", "title": "20g proteins"},
    {"image": "assets/img/carbo.png", "title": "50g carbo"},
  ];

  List ingredientsArr = [
    {
      "image": "assets/img/flour.png",
      "title": "Wheat Flour",
      "value": "100grm"
    },
    {"image": "assets/img/sugar.png", "title": "Sugar", "value": "3 tbsp"},
    {
      "image": "assets/img/baking_soda.png",
      "title": "Baking Soda",
      "value": "2tsp"
    },
    {"image": "assets/img/eggs.png", "title": "Eggs", "value": "2 items"},
  ];

  List stepArr = [
    {"no": "1", "detail": "Prepare all of the ingredients that needed"},
    {"no": "2", "detail": "Mix flour, sugar, salt, and baking powder"},
    {
      "no": "3",
      "detail":
      "In a seperate place, mix the eggs and liquid milk until blended"
    },
    {
      "no": "4",
      "detail":
      "Put the egg and milk mixture into the dry ingredients, Stir untul smooth and smooth"
    },
    {"no": "5", "detail": "Prepare all of the ingredients that needed"},
  ];


  @override
  Widget build(BuildContext context) {
    var media =MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: TColor.primaryG)
      ),
      child: NestedScrollView(
          headerSliverBuilder: (context,innerBoxIsScrolled){
            return [
              SliverAppBar(
                backgroundColor: Colors.transparent,
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
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Image.asset("assets/img/back_btn.png",
                      height: 15,
                      width: 15,
                    fit: BoxFit.contain,),
                  ),
                ),
                actions: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.all(8),
                      alignment: Alignment.center,
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: TColor.lightGray,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Image.asset("assets/img/more_btn.png",
                        height: 15,
                        width: 15,),
                    ),
                  )
                ],
              ),
              SliverAppBar(
                backgroundColor: Colors.transparent,
                centerTitle: true,
                elevation: 0,
                leadingWidth: 0,
                leading: Container(),
                expandedHeight: media.width*0.5,
                flexibleSpace: ClipRRect(
                  child:Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Transform.scale(
                        scale: 1.25,
                        child: Container(
                          width: media.width*0.55,
                          height: media.width*0.55,
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(media.width*0.275)
                          ),
                        ),
                      ),
                      Transform.scale(
                        scale: 1.25,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Image.asset("assets/img/big_cake.png",
                          width: media.width*0.5,
                          height: media.width*0.5,
                          fit: BoxFit.contain,),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ];

          },
          body: Container(
            decoration: BoxDecoration(
              color: TColor.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25)
              )
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 4,
                              decoration: BoxDecoration(
                                color: TColor.gray.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(3)
                              ),
                            )
                          ],
                        ),
                        SizedBox(height:media.width*0.05),

                        Padding(padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.dObj["name"],
                                style: TextStyle(
                                  color: TColor.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700
                                ),),
                                Text(
                                  "by James Ruth",
                                  style: TextStyle(
                                    color: TColor.gray,fontSize: 12
                                  ),
                                ),
                              ],
                            )),
                            TextButton(onPressed: (){}, child: Image.asset("assets/img/fav.png",
                            width: 15,
                            height: 15,
                            fit: BoxFit.contain))
                          ],
                        ),
                        ),

                        SizedBox(height: media.width*0.05,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            "Nutrition",
                            style: TextStyle(
                                color: TColor.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          )),
                        SizedBox(height: 50,
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: nutritionArr.length,
                          itemBuilder: (context,index){
                            var nObj=nutritionArr[index] as Map? ?? {};
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 4,vertical: 8),
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors:[
                                      TColor.primaryColor2.withOpacity(0.4),
                                      TColor.primaryColor1.withOpacity(0.4)
                                    ] ,
                                ),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(nObj["image"].toString(),
                                    width: 15,
                                    height: 15,
                                    fit: BoxFit.contain,
                                  ),
                                  Padding(padding: EdgeInsets.all(8),
                                  child: Text(
                                    nObj["title"],style: TextStyle(
                                    color: TColor.black,fontSize: 12
                                  ),
                                  ),
                                  )
                                ],
                              ),

                            );
                          },)
                        ),
                        SizedBox(
                          height: media.width * 0.05,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            "Descriptions",
                            style: TextStyle(
                                color: TColor.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(height: 4,),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 15),
                          child: ReadMoreText(
                            'Pancakes are some people\'s favorite breakfast, who doesn\'t like pancakes? Especially with the real honey splash on top of the pancakes, of course everyone loves that! besides being Pancakes are some people\'s favorite breakfast, who doesn\'t like pancakes? Especially with the real honey splash on top of the pancakes, of course everyone loves that! besides being',
                            trimLines: 4,
                            colorClickableText: TColor.black,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: ' Read More ...',
                            trimExpandedText: ' Read Less',
                            style: TextStyle(
                              color: TColor.gray,
                              fontSize: 12,
                            ),
                            moreStyle: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Ingredients That You\nWill Need",style: TextStyle(
                              color: TColor.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700
                            ),),
                            TextButton(onPressed: (){}, child: Text(
                              "${stepArr.length} Items",
                              style: TextStyle(
                                  color: TColor.gray,
                                  fontSize: 12),))
                          ],
                        ),),
                        SizedBox(height: 15),
                        SizedBox(
                          height: (media.width*0.25)+40,
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                              itemCount: ingredientsArr.length,
                              itemBuilder: (context,index){
                              var nObj=ingredientsArr[index] as Map? ??{};
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                width: media.width*0.23,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: media.width*0.23,
                                      height: media.width*0.23,
                                      decoration: BoxDecoration(
                                        color: TColor.lightGray,
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      alignment: Alignment.center,
                                      child: Image.asset(nObj['image'].toString(),
                                        width: 45,
                                          height: 45,
                                          fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(height: 4,),
                                    Text(nObj["title"],
                                    style: TextStyle(
                                      color: TColor.black,fontSize: 12
                                    ),
                                    ),
                                    Text(nObj['value'].toString(),
                                    style: TextStyle(
                                      color: TColor.gray,
                                      fontSize: 10
                                    ),
                                    )
                                  ],
                                ),
                              );
                              }),
                        ),
                        SizedBox(height: 15,),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Step by Step",
                            style: TextStyle(
                              color: TColor.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700
                            ),
                            ),
                            TextButton(onPressed: (){}, child: Text("${stepArr.length} Steps",
                            style: TextStyle(color: TColor.black,fontSize: 12),))
                          ]
                        ),
                        ),
                        ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                            itemCount: stepArr.length,
                            itemBuilder: ((context,index){
                            var sObj=stepArr[index] as Map? ?? {};
                            return FoodDetailsStepRow(sObj: sObj,
                            isLast: stepArr.last==sObj,//sObj have the current stepArr value , then if stepArr.last ==last ele.of sObj(ie.stepArr values) then it return true
                            );
                            })),
                        SizedBox(height: media.width*0.25,)
                      ],
                    ),
                  ),
                  SafeArea(child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(padding: EdgeInsets.symmetric(horizontal: 15),
                    child: RoundGradientButton(title:
                    "Add to ${widget.mObj["name"]} Meal", //widget.mObj to get breakfast,lunch etc as it has describe in mealfooddetailsviews
                        onPressed:(){
                      try {
                        final imageName=widget.dObj['b_image'];
                        final imagePath='user1/$imageName';
                        final imageUrl=Supabase.instance.client.storage
                        .from('mealsimage')
                        .getPublicUrl(imagePath);



                        ref.read(insertMealProvider).insertMeal(
                            name:" ${widget.dObj['name']}",
                            mealType: "${widget.mObj['name']}",
                            calories: double.parse("${widget.dObj['calories']}"),
                            protein: double.parse("${widget.dObj['protein']}"),
                            carbs: double.parse("${widget.dObj['carbs']}"),
                            fat: double.parse("${widget.dObj['fat']}"),
                            image: imageUrl

                        );
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Food added to ${widget.mObj['name']}")));
                      }
                      catch(e){
                        print('$e');
                      }
                        }),)
                  ],
                  ))
                ],
              ),
            ),
            
          )),
    );
  }
}
