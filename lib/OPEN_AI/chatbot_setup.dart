import 'dart:async';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:fitness_tracker/OPEN_AI/API.dart';
import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class ChatbotSetup extends StatefulWidget {
  const ChatbotSetup({super.key});

  @override
  State<ChatbotSetup> createState() => _ChatbotSetupState();
}

class _ChatbotSetupState extends State<ChatbotSetup> {

  late OpenAI _openAI;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _openAI=OpenAI.instance.build(token: OPEN_AI_KEY,baseOption: HttpSetup(receiveTimeout: Duration(seconds: 60),connectTimeout: Duration(seconds: 60)),enableLog: true);
  }




  final ChatUser _currentUser=ChatUser(id: '1',firstName: 'kamoe',lastName: 'Susling');
  final ChatUser _gptChatUser=ChatUser(id: '2',firstName: 'Chat',lastName: 'GPT');


  List<ChatUser> _typingUsers=<ChatUser>[];
 List<ChatMessage>_message=<ChatMessage>[];
  bool _isTyping=false;
  String _typingText = "ChatGPT is typing.";
  Timer? _typingTimer;
  int _dotCount = 1;


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
  @override
  void dispose() {
    _typingTimer?.cancel();
    super.dispose();
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
              typingUsers: _typingUsers,
              currentUser: _currentUser,
              messageOptions: MessageOptions(
                  currentUserContainerColor: TColor.gray,
                  containerColor: TColor.black,
                  textColor: TColor.white
              ),
              onSend: (ChatMessage m){
                getResponse(m);

              }, messages: _message),),
        ],
      )
      

    );
  }
  Future<void>getResponse(ChatMessage m) async {
    setState(() {
      _message.insert(0, m);
     // _typingUsers.add(_gptChatUser);
      _isTyping=true;
    });
    startTypingAnimation();
    List<Map<String,dynamic>> _messageHistory=_message.reversed.map((m) {
      if(m.user.id==_currentUser.id){
        return {
          "role":"user",
          "content":m.text,
        };
      }else{
        return {
          "role":"assistant",
          "content":m.text,
        };
      }
    }).toList();

    final request= ChatCompleteText(model: GptTurbo0301ChatModel(), messages:_messageHistory,maxToken: 200);

    final response=await _openAI.onChatCompletion(request: request);

    for(var element  in response!.choices){
      if(element.message!=null){
        setState(() {
          _message.insert(0, ChatMessage(user: _gptChatUser, createdAt: DateTime.now(),
          text: element.message!.content));

        });
      }
    }
    setState(() {
     // _typingUsers.remove(_gptChatUser);
      _isTyping=false;
    });
    stopTypingAnimation();


  }
}
