import 'dart:developer';

import 'package:gemini_pod/util/constant.dart';

import '../Model/chatMessageModel.dart';
import 'package:dio/dio.dart';
class ChatRepo{
  static chatTextGeneration(
      List<ChatMessageModel>previusMessages)async{
    try{
      Dio dio =  Dio();
      final response = await dio.post("https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=${API_KEY}",
          data:{
            "contents": previusMessages.map((e) => e.toMap()).toList(),
            "generationConfig": {
              "temperature": 0.9,
              "topK": 1,
              "topP": 1,
              "maxOutputTokens": 2048,
              "stopSequences": []
            },
            "safetySettings": [
              {
                "category": "HARM_CATEGORY_HARASSMENT",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              },
              {
                "category": "HARM_CATEGORY_HATE_SPEECH",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              },
              {
                "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              },
              {
                "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              }
            ]
          }
      );
      if(response.statusCode!>=200 && response.statusCode!<300){
        return response.data['candidates'].first['content']['parts'].first['text'];
      }
      // return '';
    }

    catch(ex){
      log(ex.toString());
      print(ex.toString());
      return '';
    }

    }
}