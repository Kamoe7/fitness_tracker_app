import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final deleteMealRow=FutureProvider.family<void,String>((ref,mealId) async{
  final userId = Supabase.instance.client.auth.currentUser?.id;

  if (userId == null) throw Exception("No logged user ~~");

  final response = await Supabase.instance.client.from("meals")
      .delete()
      .eq('id',mealId)
  .eq('user_id', userId);

}


);