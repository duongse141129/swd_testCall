import 'package:advisories_lawyer/lawyer/chat_lawyer/chat_message.dart';
import 'package:advisories_lawyer/lawyer/chat_lawyer/message_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChatBubble extends StatefulWidget {
  ChatMessage chatMessage;
  ChatBubble({required this.chatMessage});
  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff14143a),
      padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      child: Align(
        alignment: (widget.chatMessage.type == MessageType.Receiver
            ? Alignment.topLeft
            : Alignment.topRight),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: (widget.chatMessage.type == MessageType.Receiver
                ? Color(0xff222242)
                : Color(0xff222242)),
          ),
          padding: EdgeInsets.all(16),
          child: Text(widget.chatMessage.message, style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
