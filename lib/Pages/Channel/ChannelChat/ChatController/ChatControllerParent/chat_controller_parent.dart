import 'package:flutter/material.dart';
import 'package:the_dram_club/Pages/Channel/ChannelChat/ChatController/ChatControllerChild/chat_controller_child.dart';

class ChatControllerParent extends StatelessWidget {
  final List msg;
  const ChatControllerParent({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: msg.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return ChatControllerChild(msg: msg[index]);
      },
    );
  }
}
