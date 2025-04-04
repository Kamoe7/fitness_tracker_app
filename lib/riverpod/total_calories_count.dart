
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final totalCaloriesCount=FutureProvider.autoDispose((ref) async {


  final userId=Supabase.instance.client.auth.currentUser?.id;

  if(userId == null) throw Exception("No logged user found");

  final today=DateTime.now();
  final startOfDay =DateTime(today.year,today.month,today.day).toUtc();
  final endOfDay= startOfDay.add(Duration(days: 1));


  final response= await Supabase.instance.client.from('meals')
      .select('date,calories,protein,carbs,fat')
      .eq('user_id',userId)
        .gte('created_at', startOfDay.toIso8601String())
  .lt('created_at', endOfDay.toIso8601String())
  ;

  final meals = response as List<dynamic>;


  // sum all the macros
  num totalCalories=0;
  num totalProteins=0;
  num totalCarbs=0;
  num totalFat=0;

  for (final meal in meals){
    totalCalories +=meal['calories'] ?? 0;
    totalProteins +=meal['protein'] ?? 0;
    totalCarbs += meal['carbs'] ?? 0;
    totalFat += meal['fat'] ?? 0;
  }

  return{
    'calories': totalCalories,
    'protein':totalProteins,
    'carbs' :totalCarbs,
    'fat': totalFat
  };



});