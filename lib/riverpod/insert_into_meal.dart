
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final insertMealProvider = Provider((ref)=>InsertMealService());

class InsertMealService{
  final _client = Supabase.instance.client;

  Future<void>insertMeal({
    required String name,
    required String mealType,
    required double calories,
    required double protein,
    required double carbs,
    required double fat,
    required String image
}) async{
    final userId= _client.auth.currentUser?.id;
    if(userId==null) throw Exception('User not logged');

    final now=DateTime.now();
    final dayNow=DateTime.now();

    final response=_client.from('meals').insert({
      'user_id':userId,
      'meal_type':mealType,
      'food_name':name,
      'calories':calories,
      'protein':protein,
      'carbs':carbs,
      'fat':fat,
      'date':now.toIso8601String().split('T')[0], //just the date part

      'hour':DateFormat.Hm().format(now),
      'food_image':image

      //'hour':now.toIso8601String().split("T")[1].substring(0,5)
    });

    return response;

  }

}