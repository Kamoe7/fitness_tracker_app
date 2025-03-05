import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:fitness_tracker/common_widget/meal_food_schedule_row.dart';
import 'package:fitness_tracker/common_widget/nutrition_row.dart';
import 'package:flutter/material.dart';


import '../../common/color_extension.dart';

class MealScheduleView extends StatefulWidget {
  const MealScheduleView({super.key});

  @override
  State<MealScheduleView> createState() => _MealScheduleViewState();
}

class _MealScheduleViewState extends State<MealScheduleView> {
  CalendarAgendaController _calendarAgendaController=CalendarAgendaController();

  late  DateTime _selectedDateAppBar;

  List breakfastArr = [
    {
      "name": "Honey Pancake",
      "time": "07:00am",
      "image": "assets/img/honey_pan.png"
    },
    {"name": "Coffee", "time": "07:30am", "image": "assets/img/coffee.png"},
  ];

  List lunchArr = [
    {
      "name": "Chicken Steak",
      "time": "01:00pm",
      "image": "assets/img/chicken.png"
    },
    {
      "name": "Milk",
      "time": "01:20pm",
      "image": "assets/img/glass-of-milk 1.png"
    },
  ];
  List snacksArr = [
    {"name": "Orange", "time": "04:30pm", "image": "assets/img/orange.png"},
    {
      "name": "Apple Pie",
      "time": "04:40pm",
      "image": "assets/img/apple_pie.png"
    },
  ];
  List dinnerArr = [
    {"name": "Salad", "time": "07:10pm", "image": "assets/img/salad.png"},
    {"name": "Oatmeal", "time": "08:10pm", "image": "assets/img/oatmeal.png"},
  ];

  List nutritionArr = [
    {
      "title": "Calories",
      "image": "assets/img/burn.png",
      "unit_name": "kCal",
      "value": "350",
      "max_value": "500",
    },
    {
      "title": "Proteins",
      "image": "assets/img/proteins.png",
      "unit_name": "g",
      "value": "300",
      "max_value": "1000",
    },
    {
      "title": "Fats",
      "image": "assets/img/egg.png",
      "unit_name": "g",
      "value": "140",
      "max_value": "1000",
    },
    {
      "title": "Carbo",
      "image": "assets/img/carbo.png",
      "unit_name": "g",
      "value": "140",
      "max_value": "1000",
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDateAppBar=DateTime.now();
  }

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
        title: Text("Meal Schedule",
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CalendarAgenda(
            controller: _calendarAgendaController,
              appbar: false,
              selectedDayPosition: SelectedDayPosition.center,
              leading: IconButton(onPressed: (){}, icon: Image.asset("assets/img/ArrowLeft.png",width: 15,height: 15,),),
              training: IconButton(onPressed: (){}, icon: Image.asset("assets/img/ArrowRight.png",width: 15,height: 15,)),
              
              weekDay: WeekDay.short,
              dayNameFontSize: 12,
              dayNumberFontSize: 16,
              dayBGColor: Colors.grey.withOpacity(0.15),
              titleSpaceBetween: 15,
              backgroundColor: Colors.transparent,

              fullCalendarScroll: FullCalendarScroll.horizontal,
            fullCalendarDay: WeekDay.short,
              selectedDateColor: Colors.white,
              dateColor: Colors.black,
              locale: 'en',

              initialDate: DateTime.now(),
            calendarEventColor: TColor.primaryColor2,
            firstDate: DateTime.now().subtract(Duration(days: 140)),
              lastDate: DateTime.now().add(Duration(days: 60)),
              onDateSelected: (date){
            _selectedDateAppBar=date;
              },
            selectedDayLogo: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: TColor.primaryG,
                begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                ),
                borderRadius: BorderRadius.circular(10)
              ),
            ),
              ),

          Expanded(child: SingleChildScrollView(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                //BREAKFAST
                Padding(padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Breakfast",
                      style: TextStyle(
                        color: TColor.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700
                      ),),
                      TextButton(onPressed: (){},
                          child:Text(
                            "${breakfastArr.length} meals | 230 calories "//i have to change this in backend
                            ,
                            style: TextStyle(color: TColor.gray,fontSize: 12),

                          )),
                    ],
                  ),
                ),

                ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                    itemCount: breakfastArr.length,
                    itemBuilder: (context,index){
                    var mObj=breakfastArr[index] as Map? ?? {};
                    return MealFoodScheduleRow(mObj: mObj, index: index);
                    }),

                //LUNCH
                Padding(padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Lunch",
                        style: TextStyle(
                            color: TColor.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700
                        ),),
                      TextButton(onPressed: (){},
                          child:Text(
                            "${lunchArr.length} meals | 230 calories "//i have to change this in backend
                            ,
                            style: TextStyle(color: TColor.gray,fontSize: 12),

                          )),
                    ],
                  ),
                ),

                ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: lunchArr.length,
                    itemBuilder: (context,index){
                      var mObj=lunchArr[index] as Map? ?? {};
                      return MealFoodScheduleRow(mObj: mObj, index: index);
                    }),


                //Snacks
                Padding(padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Snacks",
                        style: TextStyle(
                            color: TColor.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700
                        ),),
                      TextButton(onPressed: (){},
                          child:Text(
                            "${snacksArr.length} meals | 230 calories "//i have to change this in backend
                            ,
                            style: TextStyle(color: TColor.gray,fontSize: 12),

                          )),
                    ],
                  ),
                ),

                ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snacksArr.length,
                    itemBuilder: (context,index){
                      var mObj=snacksArr[index] as Map? ?? {};
                      return MealFoodScheduleRow(mObj: mObj, index: index);
                    }),

                //DINNER
                Padding(padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Dinner",
                        style: TextStyle(
                            color: TColor.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700
                        ),),
                      TextButton(onPressed: (){},
                          child:Text(
                            "${dinnerArr.length} meals | 230 calories "//i have to change this in backend
                            ,
                            style: TextStyle(color: TColor.gray,fontSize: 12),

                          )),
                    ],
                  ),
                ),

                ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: dinnerArr.length,
                    itemBuilder: (context,index){
                      var mObj=dinnerArr[index] as Map? ?? {};
                      return MealFoodScheduleRow(mObj: mObj, index: index);
                    }),
                SizedBox(height: media.width*0.05,),
                Padding(padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Today Meal Nutrition's",
                    style: TextStyle(
                      color: TColor.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700
                    ),),
                  ]
                ),
                ),
                ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: nutritionArr.length,
                    itemBuilder: (context,index){
                      var nObj=nutritionArr[index] as Map? ??{};

                      return NutritionRow(nObj: nObj);
                    }),


              ],
            ) ,))
        ],
      ),

    );
  }
}
