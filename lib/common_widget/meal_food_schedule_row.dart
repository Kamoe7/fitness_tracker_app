import 'package:fitness_tracker/riverpod/delete_meal_row.dart';
import 'package:fitness_tracker/riverpod/fetch_meal_type.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/color_extension.dart';

class MealFoodScheduleRow extends ConsumerWidget {
  final Map mObj;
  final int index;

  const MealFoodScheduleRow(
      {super.key, required this.mObj, required this.index});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isEvent = index % 2 == 0;
    return
      Container(
        margin: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 35,
                width: 55,
                decoration: BoxDecoration(
                    color: isEvent ?
                    TColor.primaryColor2.withOpacity(0.4)
                        : TColor.secondaryColor2.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10)
                ),
                alignment: Alignment.center,
                child: Image.network(mObj["food_image"].toString(),
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(width: 15,),
            Expanded(child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mObj["food_name"].toString(),
                  style: TextStyle(
                      color: TColor.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w700
                  ),
                ),
                Text(
                  mObj['hour'].toString(),
                  style: TextStyle(
                      color: TColor.gray,
                      fontSize: 10
                  ),
                )

              ],
            )),
            IconButton(onPressed: () async {
              try {
                final id = mObj['id'];
                print("Trying to delete ID: $id");

                await ref.read(deleteMealRow(id.toString())
                    .future); // only if mealId is String
                ref.invalidate(mealsListProvider); // or ref.refresh()
              } catch (e) {
                print("Delete error: $e");
              }
            }
                , icon: Icon(Icons.delete)),
            SizedBox(width: 8,),
            IconButton(onPressed: () {},
                icon: Image.asset("assets/img/Workout-Btn.png", width: 25,
                  height: 25,))

          ],
        ),

      );
  }
}
