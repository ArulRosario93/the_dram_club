import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:the_dram_club/Pages/Channel/ChannelChat/ChatController/chat_controller.dart';

class Channelchat extends StatelessWidget {
  const Channelchat({super.key});

  @override
  Widget build(BuildContext context) {
    List msg = [
      [
        {'msg': 'Hello', 'sender': 'me', 'date': '12/12/2021', 'time': '12:00'},
        {'msg': 'Hi', 'sender': 'other', 'date': '12/12/2021', 'time': '12:01'},
        {
          'msg': 'How are you?',
          'sender': 'me',
          'date': '12/12/2021',
          'time': '12:02'
        },
        {
          'msg': 'I am fine',
          'sender': 'other',
          'date': '12/12/2021',
          'time': '12:03'
        },
        {
          "msg": "How are you?",
          "sender": "me",
          'date': '12/12/2021',
          'time': '12:04'
        },
        {
          "msg": "I am fine",
          "sender": "other",
          'date': '12/12/2021',
          'time': '12:05'
        },
        {
          "msg": "I am fine",
          "sender": "other",
          'date': '12/12/2021',
          'time': '12:05'
        }
      ],
      [
        {
          "msg": "How are you?",
          "sender": "me",
          'date': '12/12/2021',
          'time': '12:04'
        },
        {
          "msg": "I am fine",
          "sender": "other",
          'date': '12/12/2021',
          'time': '12:05'
        },
        {"msg": "Hello", "sender": "me", 'date': '12/12/2021', 'time': '12:06'},
        {"msg": "Hi", "sender": "other", 'date': '12/12/2021', 'time': '12:07'},
        {
          "msg": "How are you?",
          "sender": "me",
          'date': '12/12/2021',
          'time': '12:04'
        },
        {
          "msg": "I am fine",
          "sender": "other",
          'date': '12/12/2021',
          'time': '12:05'
        },
        {
          "msg": "I am fine",
          "sender": "other",
          'date': '12/12/2021',
          'time': '12:05'
        },
        {"msg": "Hello", "sender": "me", 'date': '12/12/2021', 'time': '12:06'},
        {"msg": "Hi", "sender": "other", 'date': '12/12/2021', 'time': '12:07'},
        {"msg": "Hi", "sender": "other", 'date': '12/12/2021', 'time': '12:07'}
      ]
    ];

    return Container(
      color: Colors.red[100],
      child: Column(
        children: [
          Expanded(child: ChatController(msg: msg)),
          Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(30)),
              margin: const EdgeInsets.only(left: 5, right: 5, bottom: 8),
              child: TextFormField(
                maxLines: 7,
                minLines: 1,
                decoration: const InputDecoration(
                  hintText: 'Type a message',
                  prefixIcon: Icon(Icons.attach_file_sharp),
                  suffixIcon: Icon(Icons.send_rounded),
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
