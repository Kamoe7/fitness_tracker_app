import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//calculating today macro count;

final totalMacroProvider =AutoDisposeFutureProvider<Map<String,Map<String,double>>>((ref) async{
  final userId=Supabase.instance.client.auth.currentUser?.id;

  if(userId==null)throw Exception('user not logged in');

final today=DateTime.now();
final startOfDay=DateTime(today.year,today.month,today.day).toUtc();
final endOfDay=startOfDay.add(Duration(days: 1));


  final response=await Supabase.instance.client
    .from('meals')
    .select('date,calories,protein,carbs,fat')
    .eq('user_id',userId)
  .gte('created_at', startOfDay.toIso8601String())
  .lt('created_at', endOfDay.toIso8601String())
    .order('date',ascending: false);

  final List data=response;

  //Group and sum totals per date
  final Map<String,Map<String,double>> grouped={};


  for (var item in data) {
    final date = item['date'];
    if (!grouped.containsKey(date)) {
      grouped[date] = {
        'calories': 0,
        'protein': 0,
        'carbs': 0,
        'fat': 0
      };
    }
    grouped[date]!['calories'] = (grouped[date]!['calories'] ?? 0) + (item['calories'] ?? 0).toDouble();
    grouped[date]!['protein'] = (grouped[date]!['protein'] ?? 0) + (item['protein'] ?? 0).toDouble();
    grouped[date]!['carbs'] = (grouped[date]!['carbs'] ?? 0) + (item['carbs'] ?? 0).toDouble();
    grouped[date]!['fat'] = (grouped[date]!['fat'] ?? 0) + (item['fat'] ?? 0).toDouble();
  }

  return grouped; // This will return a Map<String, Map<String, double>>
});

