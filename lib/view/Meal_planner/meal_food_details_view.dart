import 'package:fitness_tracker/common_widget/meal_category_cell.dart';
import 'package:fitness_tracker/common_widget/meal_recommend_cell.dart';
import 'package:fitness_tracker/common_widget/popular_meal.dart';
import 'package:fitness_tracker/view/Meal_planner/food_info_details_view.dart';
import 'package:flutter/material.dart';

import '../../common/color_extension.dart';

class MealFoodDetailsView extends StatefulWidget {
  final Map eObj;
  const MealFoodDetailsView({super.key,required this.eObj});

  @override
  State<MealFoodDetailsView> createState() => _MealFoodDetailsViewState();
}

class _MealFoodDetailsViewState extends State<MealFoodDetailsView> {
  TextEditingController txtSearch=TextEditingController();

  List categoryArr = [
    {
      "name": "Salad",
      "image": "assets/img/salad.png",
    },
    {
      "name": "Cake",
      "image": "assets/img/cake.png",
    },
    {
      "name": "Pie",
      "image": "assets/img/pie.png",
    },
    {
      "name": "Smoothies",
      "image": "assets/img/orange.png",
    },
    {
      "name": "Salad",
      "image": "assets/img/salad.png",
    },
    {
      "name": "Cake",
      "image": "assets/img/cake.png",
    },
    {
      "name": "Pie",
      "image": "assets/img/pie.png",
    },
    {
      "name": "Smoothies",
      "image": "assets/img/orange.png",
    },
  ];

  List popularArr = [
    {
      "name": "Blueberry Pancake",
      "image": "assets/img/big_cake.png",
      "b_image":"big_cake.png",
      "size": "Medium",
      "time": "30mins",
      "mealType": "Lunch",
      "calories": "78",
      "protein": "6.2",
      "carbs": "0.6",
      "fat": "5.3"

    },
    {
      "name": "Salmon Nigiri",
      "image": "assets/img/big_bread.png",
      "b_image": "onigiri.png",
      "size": "Medium",
      "time": "20mins",
      "calories": "120",
      "mealType": "Dinner",
      "protein": "32",
      "carbs": "1",
      "fat": "4"
    },
  ];

  List recommendArr = [
    {
      "name": "Honey Pancake",
      "image": "assets/img/rd_1.png",
      "size": "Easy",
      "kcal": "180kCal",
      "mealType": "Lunch",
      "calories": "78",
      "protein": "6.2",
      "carbs": "0.6",
      "fat": "5.3",
      "time":"15min"

    },
    {
      "name": "Canai Bread",
      "image": "assets/img/m_4.png",
      "size": "Easy",
      "time": "20mins",
      "kcal": "230kCal"
    },
  ];

  @override
  Widget build(BuildContext context) {
    var media=MediaQuery.of(context).size;
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: TColor.white,
        centerTitle: true,

        leading: InkWell(
          onTap: () {
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
        title: Text(widget.eObj["name"].toString(),
          style: TextStyle(
              color: TColor.black,
              fontSize: 20,
              fontWeight: FontWeight.bold
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
        backgroundColor: TColor.white,
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              color: TColor.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2,
                    offset: Offset(0, 1))
              ]),
          child: Row(
            children: [
              Expanded(
                  child: TextField(
                    controller: txtSearch,
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        prefixIcon: Image.asset(
                          "assets/img/Search.png",
                          width: 25,
                          height: 25,
                        ),
                        hintText: "Search Pancake"),
                  )),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: 1,
                height: 25,
                color: TColor.gray.withOpacity(0.3),
              ),
              InkWell(
                onTap: () {},
                child: Image.asset(
                  "assets/img/Filter.png",
                  width: 25,
                  height: 25,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: media.width * 0.05,
        ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Category",
                  style: TextStyle(
                    color: TColor.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700
                  ),
                  )
                ],
              ),),
              SizedBox(
                height: 120,
                child:ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryArr.length,
                    itemBuilder: (context,index){
                      var cObj=categoryArr[index] as Map? ?? {};
                      return MealCategoryCell(index: index, cObj: cObj);

                    }),

              ),
                SizedBox(height: media.width*0.05,),
                Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                      "Recommendation\nfor Diet",
                    style: TextStyle(
                      color: TColor.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 16
                    ),
                      ),
                ),
                SizedBox(
                  height: media.width*0.6,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    scrollDirection: Axis.horizontal,
                    itemCount: recommendArr.length,
                      itemBuilder: (context,index){
                      var fObj= recommendArr[index] as Map? ??{};
                      return MealRecommendCell(fObj: fObj, index: index);
                  }
                )
                ),
                SizedBox(height: 15,),
                Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Popular ",style: TextStyle(fontWeight: FontWeight.w700,fontSize:15,color: TColor.black ),)
                ),
                SizedBox(height: 15,),

                // i have to work here
                ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: popularArr.length,
                  itemBuilder: (context,index){
                    var pObj=popularArr[index] as Map? ??{};
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>FoodInfoDetailsView(dObj: pObj,
                          mObj: widget.eObj, //suppose if i press in breakfast i need it and it was in widget.eObj as widget.eObj conisit the arrtylist that has breakfast
                        )));
                      },
                      child: PopularMeal(pObj: pObj),
                    );
                  },

                )
        ]
                )
      ),

    );
  }
}
