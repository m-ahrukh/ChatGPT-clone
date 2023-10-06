import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_application/constants/api_consts.dart';
import 'package:flutter_application/models/chat_model.dart';
import 'package:flutter_application/models/models_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(Uri.parse("$BASE_URL/models"),
          headers: {'Authorization': 'Bearer $API_KEY'});

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        print("JsonResponse['error'] $jsonResponse['error']['message']");
        throw HttpException(jsonResponse['error']['message']);
      }
      print("JsonResponse: $jsonResponse");
      List temp = [];
      for (var data in jsonResponse["data"]) {
        temp.add(data);
        log('temp ${data["id"]}');
      }
      return ModelsModel.modelsFromSnapshot(temp);
    } catch (error) {
      log("Error $error");
      rethrow;
    }
  }

  // Send Message FCT
  static Future<List<ChatModel>> sendMessage(
      {required String msg, required String modelId}) async {
    try {
      log("ModelId $modelId ");
      var response = await http.post(Uri.parse("$BASE_URL/chat/completions"),
          headers: {
            'Authorization': 'Bearer $API_KEY',
            'Content-Type': 'application/json'
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo",
            //"prompt": msg,
            "messages": [
              {"role": "user", "content": msg}
            ],
            "max_tokens": 400
          }));

      Map jsonResponse = jsonDecode(response.body);

      log("JsonResponse\n: $jsonResponse \n\n");

      if (jsonResponse['error'] != null) {
        log("JsonResponse['error'] ${jsonResponse['error']['message']}");
        throw HttpException(jsonResponse['error']['message']);
      }

      List<ChatModel> chatList = [];
      if (jsonResponse['choices'].length > 0) {
        // log("jsonResponse['choices']text ${jsonResponse['choices'][0]['message']['content']}");
        chatList = List.generate(jsonResponse['choices'].length,
            (index) => ChatModel(
                msg: jsonResponse['choices'][index]['message']['content'],
                chatIndex: 1,
            ),
        );
      }
      return chatList;
    } catch (error) {
      log("Error $error");
      rethrow;
    }
  }
}
