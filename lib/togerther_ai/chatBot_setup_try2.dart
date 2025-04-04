import 'dart:convert';

import 'package:fitness_tracker/togerther_ai/api_key_together_ai.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<String> togetherAIChat(String prompt) async{

  const apiKey=TOGETHER_API_KEY;

  final response = await http.post(

   Uri.parse("https://api.together.xyz/v1/chat/completions"),
    headers: {
     "Authorization":"Bearer $apiKey",
      "Content-Type":"application/json",
    },
    body: jsonEncode({
      "model":"deepseek-ai/DeepSeek-R1-Distill-Llama-70B-free",
      "messages":[{
        "role":"user","content":prompt
    }],
    "max_tokens":200,
    }),
  );

  if(response.statusCode==200){
    final data=jsonDecode(response.body);
    print(data);
    return data['choices'][0]['message']['content'];

  }
  else{
    print(response.body);
    throw Exception("Failed to fetch response:${response.body}");
  }
}
