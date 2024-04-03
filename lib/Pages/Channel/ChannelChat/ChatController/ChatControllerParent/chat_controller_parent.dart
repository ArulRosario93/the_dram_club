import 'package:flutter/material.dart';
import 'package:the_dram_club/Pages/Channel/ChannelChat/ChatController/ChatControllerChild/chat_controller_child.dart';

class ChatControllerParent extends StatelessWidget {
  final List msg;
  const ChatControllerParent({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    // ScrollController _scrollController = ScrollController();

    // _scrollControlle_scrollControllerr.jumpTo(
    //   .position.maxScrollExtent,
    // );

    return ListView.builder(
      shrinkWrap: true,
      itemCount: msg.length,
      // controller: _scrollController,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return ChatControllerChild(msg: msg[index]);
      },
    );
  }
}
