import 'dart:developer';
import 'package:chat_gpt_app_updated/Feature/Home/presentation/views/widgets/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


import '../../../../core/widget/dailog_message.dart';
import '../../../../core/widget/loading.dart';
import '../../../../generated/assets.dart';
import '../../data/models/chat_model.dart';
import '../../data/repo/home_repo_impl.dart';
import '../manger/providers/models_provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;
  late TextEditingController textEditingController;
  late ScrollController _listScrollController;
  late FocusNode focusNode;
  List<ChatModel> chatList = [];

  @override
  void initState() {
    _listScrollController = ScrollController();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,

        leading: Row(

          children: [
            SizedBox(width: 12,),
            InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                  height: 40,width: 40,
                decoration: BoxDecoration(
                  color: const Color(0xff646464).withOpacity(.27),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 10.0 ,left: 10 ,right: 10),
                  child: Icon(Icons.arrow_back_ios_sharp,size: 15,),
                ),),
            ),
          ],
        ),
        title:  Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text("Chat with Bot",style: GoogleFonts.poppins(
            fontSize: 24,

            fontWeight: FontWeight.w500,
          ),),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 60,),
            Flexible(
              child: chatList.isEmpty // Check if chatList is empty
                  ? Center(
                child: ListView(

                  children: [
                    Center(
                      child: SvgPicture.asset(
                        "assets/image/ChatbotBG.svg", // Replace with your image asset
                        width: 300, // Adjust the size as needed
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                const SizedBox(height: 20), // Add some spacing between the image and text
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                //   child: const Text(
                //     "Hello! 😊 I'm here to help you find what you're looking for. Let's make today amazing together!",
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 16,
                //       fontWeight: FontWeight.w500,
                //
                //     ),textAlign: TextAlign.center,),
                // )
                  ],
                ),
              )
                  : ListView.builder(
                controller: _listScrollController,
                itemCount: chatList.length, // chatList.length,
                itemBuilder: (context, index) {
                  return ChatWidget2(
                    msg: chatList[index].msg,
                    chatIndex: chatList[index].chatIndex,
                    shouldAnimate: chatList.length - 1 == index,
                  );
                },
              ),
            ),
            if (_isTyping) ...[
              CustomLoadingAnimation(
                size: 50,
              )
            ],
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left:  15,right:15,bottom: 10),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff232323),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0,top: 7,bottom:7),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          focusNode: focusNode,
                          style: const TextStyle(color: Colors.white),
                          controller: textEditingController,
                          onSubmitted: (value) async {
                            await sendMessageFCT(modelsProvider: modelsProvider);
                          },
                          decoration: const InputDecoration.collapsed(
                              hintText: "How can I help you?",
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      ),
                      IconButton(
                          onPressed: () async {
                            await sendMessageFCT(modelsProvider: modelsProvider);
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void scrollListToEND() {
    _listScrollController.animateTo(
      _listScrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.easeOut,
    );
  }

  Future<void> sendMessageFCT({required ModelsProvider modelsProvider}) async {
    if (_isTyping) {
      showDialog(
        context: context,
        builder: (context) => DialogMassage(
          onTap: () {
            Navigator.of(context).pop();
          },
          message: "You can't send multiple messages at a time",
          imageTitle: Assets.imageCancel,
        ),
      );
      return;
    }
    if (textEditingController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => DialogMassage(
          onTap: () {
            Navigator.of(context).pop();
          },
          message: "Please type a message",
          imageTitle: Assets.imageCancel,
        ),
      );
      return;
    }
    try {
      String msg = textEditingController.text;
      setState(() {
        _isTyping = true;
        chatList.add(ChatModel(msg: msg, chatIndex: 0));
        textEditingController.clear();
        focusNode.unfocus();
      });

      final responseContent =
      await AiContentGenerator().generateContent(message: msg);
      if (responseContent != null) {
        setState(() {
          chatList.add(ChatModel(msg: responseContent, chatIndex: 1));
        });
      }
    } catch (error) {
      log("error $error");
      showDialog(
        context: context,
        builder: (context) => DialogMassage(
          onTap: () {
            Navigator.of(context).pop();
          },
          message: error.toString(),
          imageTitle: Assets.imageCancel,
        ),
      );
    } finally {
      setState(() {
        scrollListToEND();
        _isTyping = false;
      });
    }
  }
}
