import 'package:flutter/cupertino.dart';
import 'package:flutter_application/services/api_services.dart';

import '../models/chat_model.dart';

class ChatProvider with ChangeNotifier{
  List<ChatModel> chatList = [];

  //Getter
  List<ChatModel> get getChatList{
    return chatList;
  }

  void addUSerMessage({required String msg}) {
    chatList.add(ChatModel(msg: msg, chatIndex: 0));
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswers(
      {required String msg, required String chosenModelId})async {
    chatList.addAll(await ApiService.sendMessage(
        msg: msg,
        modelId: chosenModelId
    ));
    notifyListeners();
  }
}