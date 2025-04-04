import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final userDataProvider =FutureProvider.autoDispose((ref) async {

  final userId=Supabase.instance.client.auth.currentUser?.id;

  final data= await Supabase.instance.client

    .from('users')
    .select('height, weight,birth_date')
    .eq('id', userId as Object)
    .single();


  double height=
      data['height'] is int
      ?(data['height'] as int).toDouble()
      : (data['height'] ?? 0) /100;
  double weight=
      data['weight'] is int
      ?(data['weight'] as int).toDouble()
      : data['weight'] ?? 0;
  double bmi=( height>0)?(weight/(height*height)) : 0;

  //this for age
  DateTime dateOfBirth= DateTime.parse(data['birth_date']);
  DateTime today=DateTime.now();

  int age=today.year-dateOfBirth.year;
  if(today.month<dateOfBirth.month || today.month==dateOfBirth.month && today.day<dateOfBirth.day){
    age--;
  }

  return {'height' : height,'weight':weight,'bmi':bmi,'age':age};

  return null;


});