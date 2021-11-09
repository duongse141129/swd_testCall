import 'package:advisories_lawyer/lawyer/chat_lawyer/chat_bubble.dart';
import 'package:advisories_lawyer/lawyer/chat_lawyer/chat_detail_page_appbar.dart';
import 'package:advisories_lawyer/lawyer/chat_lawyer/chat_message.dart';
import 'package:flutter/material.dart';


enum MessageType {
  Sender,
  Receiver,
}

class ChatDetailPage extends StatefulWidget {
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  List<ChatMessage> chatMessage = [
    ChatMessage(message: "Chào Luật sư Dương", type: MessageType.Sender),
    ChatMessage(
        message: "Em muốn hỏi về tài liệu dự án của em có đủ ko", type: MessageType.Sender),
    ChatMessage(message: "Cần thêm gì ko", type: MessageType.Sender),
    ChatMessage(
        message: "Chào anh Đức, ổn ạ", type: MessageType.Receiver),
    ChatMessage(message: "Em cảm ơn", type: MessageType.Sender),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatDetailPageAppBar(),
      body: Container(
        color: Color(0xff14143a),
        child: Stack(
          children: <Widget>[
            ListView.builder(
              itemCount: chatMessage.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ChatBubble(
                  chatMessage: chatMessage[index],
                );
              },
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 16, bottom: 10,top: 20),
                height: 80,
                width: double.infinity,
                color: Color(0xff14142b),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        //showModal();
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 21,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xff222242),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Type message...",
                              hintStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: EdgeInsets.only(right: 30, bottom: 50),
                child: FloatingActionButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.green,
                  elevation: 0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
