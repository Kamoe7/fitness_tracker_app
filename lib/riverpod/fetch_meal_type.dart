import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final mealsListProvider= FutureProvider.autoDispose((ref) async {
  final today = DateTime.now();
  final todayStart = DateTime(today.year, today.month, today.day).toUtc();
  final tomorrowStart = todayStart.add(Duration(days: 1));


  final userId = Supabase.instance.client.auth.currentUser?.id;

  if (userId == null) throw Exception("No logged users");

  final response = await Supabase.instance.client.from('meals')
      .select('id,food_name,calories,hour,food_image,meal_type')
      .eq("user_id", userId)
      .gte('created_at', todayStart.toIso8601String())    // >= today at 00:00 UTC
  .lt('created_at', tomorrowStart.toIso8601String())       //< tomorrow at 00:00 UTC
      .order('date', ascending: false);

  return response as List<dynamic>;
});