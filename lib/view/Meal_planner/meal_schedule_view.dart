import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:fitness_tracker/common_widget/meal_food_schedule_row.dart';
import 'package:fitness_tracker/common_widget/nutrition_row.dart';
import 'package:fitness_tracker/riverpod/fetch_meal_type.dart';
import 'package:fitness_tracker/riverpod/meal_provider.dart';
import 'package:fitness_tracker/riverpod/total_calories_count.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../common/color_extension.dart';

class MealScheduleView extends ConsumerStatefulWidget {
  const MealScheduleView({super.key});

  @override
  ConsumerState<MealScheduleView> createState() => _MealScheduleViewState();
}

class _MealScheduleViewState extends ConsumerState<MealScheduleView> {
  final CalendarAgendaController _calendarAgendaController = CalendarAgendaController();

  late DateTime _selectedDateAppBar;

  final ScrollController _scrollController=ScrollController();

  int calculateTotalCalories(List<Map<String, dynamic>> data) {
    return data.fold(0, (sum, item) {
      final cal = item['calories'];
      return sum +
          (cal is int ? cal : double.tryParse(cal.toString())?.toInt() ?? 0);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDateAppBar = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {



    final mealsAsync = ref.watch(mealsListProvider);


    var media = MediaQuery
        .of(context)
        .size;
    return Scaffold(
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
            leading: IconButton(onPressed: () {},
              icon: Image.asset(
                "assets/img/ArrowLeft.png", width: 15, height: 15,),),
            training: IconButton(onPressed: () {},
                icon: Image.asset(
                  "assets/img/ArrowRight.png", width: 15, height: 15,)),

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
            onDateSelected: (date) {
              _selectedDateAppBar = date;
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

          Expanded(
              child: mealsAsync.when(
                  data: (data) {
                    // 🥣 Step 1: Split meals by type
                    final List<Map<String, dynamic>> breakfastArr = data
                        .where((meal) => meal['meal_type'] == 'Breakfast')
                        .cast<Map<String, dynamic>>()
                        .toList();

                    final List<Map<String, dynamic>> lunchArr = data
                        .where((meal) => meal['meal_type'] == 'Lunch')
                        .cast<Map<String, dynamic>>()
                        .toList();

                    final List<Map<String, dynamic>> snacksArr = data
                        .where((meal) => meal['meal_type'] == 'Snacks')
                        .cast<Map<String, dynamic>>()
                        .toList();

                    final List<Map<String, dynamic>> dinnerArr = data
                        .where((meal) => meal['meal_type'] == 'Dinner')
                        .cast<Map<String, dynamic>>()
                        .toList();

                    return SingleChildScrollView(
                      child: Column(
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
                                TextButton(onPressed: () {},
                                    child: Text(
                                      "${breakfastArr
                                          .length} meals | ${calculateTotalCalories(
                                          breakfastArr.cast<Map<String,
                                              dynamic>>())} calories "
                                      //i have to change this in backend
                                      ,
                                      style: TextStyle(
                                          color: TColor.gray, fontSize: 12),

                                    )),
                              ],
                            ),
                          ),

                          ListView.builder(
                              controller: _scrollController,
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: breakfastArr.length,
                              itemBuilder: (context, index) {
                                var mObj = breakfastArr[index];
                                return MealFoodScheduleRow(
                                    mObj: mObj, index: index);


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
                                TextButton(onPressed: () {},
                                    child: Text(
                                      "${lunchArr
                                          .length} meals |${calculateTotalCalories(
                                          lunchArr.cast<Map<String,
                                              dynamic>>())} calories"
                                      //i have to change this in backend
                                      ,
                                      style: TextStyle(
                                          color: TColor.gray, fontSize: 12),

                                    )),
                              ],
                            ),
                          ),

                          ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: lunchArr.length,
                              itemBuilder: (context, index) {
                                var mObj = lunchArr[index] as Map? ?? {};
                                return MealFoodScheduleRow(
                                    mObj: mObj, index: index);
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
                                TextButton(onPressed: () {},
                                    child: Text(
                                      "${snacksArr
                                          .length} meals | ${calculateTotalCalories(
                                          snacksArr.cast<Map<String,
                                              dynamic>>())} calories "
                                      //i have to change this in backend
                                      ,
                                      style: TextStyle(
                                          color: TColor.gray, fontSize: 12),

                                    )),
                              ],
                            ),
                          ),

                          ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snacksArr.length,
                              itemBuilder: (context, index) {
                                var mObj = snacksArr[index] as Map? ?? {};
                                return MealFoodScheduleRow(
                                    mObj: mObj, index: index);
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
                                TextButton(onPressed: () {},
                                    child: Text(
                                      "${dinnerArr
                                          .length} meals | ${calculateTotalCalories(
                                          dinnerArr.cast<Map<String,
                                              dynamic>>())} calories"
                                      //i have to change this in backend
                                      ,
                                      style: TextStyle(
                                          color: TColor.gray, fontSize: 12),

                                    )),
                              ],
                            ),
                          ),

                          ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: dinnerArr.length,
                              itemBuilder: (context, index) {
                                var mObj = dinnerArr[index] as Map? ?? {};
                                return MealFoodScheduleRow(
                                    mObj: mObj, index: index);
                              }),
                          SizedBox(height: media.width * 0.05,),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
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

                          ref.watch(totalCaloriesCount).when(
                              data: (macro) {
                                final List <
                                    Map<String, dynamic>> nutritionArr = [
                                  {
                                    "title": "Calories",
                                    "image": "assets/img/burn.png",
                                    "key": "calories",
                                    "unit_name": "kCal",
                                    "value": macro["calories"]?.toString() ?? 0,
                                    "max_value": "2500",
                                  },
                                  {
                                    "title": "Proteins",
                                    "image": "assets/img/proteins.png",
                                    "key": "protein",
                                    "unit_name": "g",
                                    "value": macro["protein"]?.toString() ?? 0,
                                    "max_value": "200",
                                  },
                                  {
                                    "title": "Fats",
                                    "image": "assets/img/egg.png",
                                    "key": "fat",
                                    "unit_name": "g",
                                    "value": macro["fat"]?.toString() ?? 0,
                                    "max_value": "150",
                                  },
                                  {
                                    "title": "Carbs",
                                    "image": "assets/img/carbo.png",
                                    "key": "carbs",
                                    "unit_name": "g",
                                    "value": macro["carbs"]?.toString() ?? 0,
                                    "max_value": "200",
                                  },
                                ];
                                return ListView.builder(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15),
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: nutritionArr.length,
                                    itemBuilder: (context, index) {
                                      var nObj = nutritionArr[index] as Map? ??
                                          {};

                                      return NutritionRow(nObj: nObj);
                                    }
                                );
                              },
                              error: (err, stack) =>
                                  Center(child: Text('Error:$err'),),
                              loading: () =>
                                  Center(child: CircularProgressIndicator(),))


                        ],
                      ),
                    );
                  }


                  , error: (err, stack) =>
                  Center(child: Text('Error;$err'),)
                  ,
                  loading: () =>
                      Center(child: CircularProgressIndicator(
                      )
                        ,
                      )

              )


          )

        ],
      ),

    );
  }
}