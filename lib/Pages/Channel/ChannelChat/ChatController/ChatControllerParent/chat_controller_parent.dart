import 'package:flutter/material.dart';
import 'package:the_dram_club/Pages/Channel/ChannelChat/ChatController/ChatControllerChild/chat_controller_child.dart';

class ChatControllerParent extends StatefulWidget {
  final List msg;
  const ChatControllerParent({super.key, required this.msg});

  @override
  State<ChatControllerParent> createState() => _ChatControllerParentState();
}

class _ChatControllerParentState extends State<ChatControllerParent> {
  ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  void initState() {
    super.initState();
    // Scroll to the bottom when the widget is first built
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      // shrinkWrap: true,
      itemCount: widget.msg.length,
      physics: const BouncingScrollPhysics(),
      // itemCount: 40,
      controller: _scrollController,
      itemBuilder: (context, index) {
        return ChatControllerChild(msg: widget.msg[index]);
        // return Text("HEllllo");
      },
    );
  }
}
