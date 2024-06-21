import 'package:chat_app/widgets/my_message_card.dart';
import 'package:chat_app/widgets/sender_message_card.dart';
import 'package:flutter/material.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          if ('isMe' == true) {
            return MyMessageCard(message: '', date: '');
          }
          return SenderMessageCard(message: '', date: '');
        });
  }
}
