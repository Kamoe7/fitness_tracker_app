import 'dart:async';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:fitness_tracker/OPEN_AI/API.dart';
import 'package:fitness_tracker/togerther_ai/chatBot_setup_try2.dart';
import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class ChatmessageaiUi extends StatefulWidget {
  const ChatmessageaiUi({super.key});

  @override
  State<ChatmessageaiUi> createState() => _ChatbotSetupState();
}

class _ChatbotSetupState extends State<ChatmessageaiUi> {

  final ChatUser _currentUser=ChatUser(id: '1',firstName: 'kamoe',lastName: 'Susling');
  final ChatUser _botUser=ChatUser(id: '2',firstName: 'Chat',lastName: 'GPT');


  List<ChatMessage>_message=<ChatMessage>[];
  bool _isTyping=false;
  String _typingText = "DeepSeek-R1 is typing.";
  Timer? _typingTimer;
  int _dotCount = 1;

  @override
  void dispose() {
    _typingTimer?.cancel();
    super.dispose();
  }


  void startTypingAnimation() {
    _typingTimer?.cancel();
    _typingTimer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        _dotCount = (_dotCount % 3) + 1;
        _typingText = "ChatGPT is typing" + "." * _dotCount;
      });
    });
  }

  void stopTypingAnimation() {
    _typingTimer?.cancel();
    _dotCount = 1;
    _typingText = "ChatGPT is typing.";
  }

  Future<void> handleSend(ChatMessage message) async{
    setState(() {
      _message.insert(0, message);
      _isTyping=true;
    });

    startTypingAnimation();

    try{
      String reply =await togetherAIChat(message.text);
      setState(() {
        _message.insert(0, ChatMessage(user: _botUser, createdAt: DateTime.now(),text: reply));
      });

    }catch (e){
      setState(() {
        _message.insert(0, ChatMessage(user: _botUser, createdAt:DateTime.now(),
          text: "Error:Failed to get response",
        customProperties: {"retryText":message.text}));
      });

    }finally{
      setState(() {
        _isTyping=false;
      });
      stopTypingAnimation();
    }


  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          backgroundColor: TColor.white,
          centerTitle: true,
          elevation: 0,
          leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.all(8),
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: TColor.lightGray,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset("assets/img/back_btn.png",width: 15,height: 15,fit: BoxFit.contain,),

            ),
          ),


          title: Text("AI ChatBot",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
          actions: [
            InkWell(
              onTap: (){},
              child: Container(
                margin: EdgeInsets.all(8),
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: TColor.lightGray,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset("assets/img/more_btn.png",width: 15,height: 15,fit: BoxFit.contain,),
              ),
            )
          ],
        ),
        body:Column(
          children: [
            if(_isTyping)
              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2,),
                    ),
                    SizedBox(width: 10,),
                    Text(_typingText,style: TextStyle(fontSize: 16),)
                  ],
                ),

              ),
            Expanded(child: DashChat(
                currentUser: _currentUser,
                messageOptions: MessageOptions(
                    currentUserContainerColor: TColor.gray,
                    containerColor: TColor.black,
                    textColor: TColor.white
                ),
                onSend:handleSend,

                 messages: _message,

                   /*
                   onMessageTap:(ChatMessage tappedMessage){
                  if(tappedMessage.user.id==_botUser.id &&
                  tappedMessage.text.startsWith("Error:Failed to get response") &&
                      tappedMessage.customProperties?['retryText']!=null){
                    String retryPrompt=tappedMessage.customProperties!['retryText'];
                    handleSend(ChatMessage(user: _currentUser, createdAt: DateTime.now(),text: retryPrompt));
                    setState(() {
                      _message.remove(tappedMessage);
                    });
                  }

              }*/

            ),),
          ],
        )


    );
  }}
