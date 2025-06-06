import 'package:flutter/cupertino.dart';

import '../../../data/models/chat_model.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];
  List<ChatModel> get getChatList {
    return chatList;
  }

  void addUserMessage({required String msg}) {
    chatList.add(ChatModel(msg: msg, chatIndex: 0));
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswers(
      {required String msg, required String chosenModelId}) async {
    if (chosenModelId.toLowerCase().startsWith("gpt")) {
     // chatList.addAll(await ApiService());
    } else {
      // chatList.addAll(await ApiService.sendMessage(
      //   message: msg,
      //   modelId: chosenModelId,
      // ));
    }
    notifyListeners();
  }
}
