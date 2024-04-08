import 'package:flutter/material.dart';
import 'package:the_dram_club/Pages/Channel/ChannelChat/ChatController/ChatControllerChild/chat_controller_child.dart';

class ChatControllerParent extends StatefulWidget {
  final List msg;
  final data;
  const ChatControllerParent(
      {super.key, required this.msg, required this.data});

  @override
  State<ChatControllerParent> createState() => _ChatControllerParentState();
}

class _ChatControllerParentState extends State<ChatControllerParent> {
  ScrollController _scrollController = ScrollController();
  bool loaded = false;

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
    // RoundCount = 5;
    // if (widget.data != null) {
    //   print(widget.data["currentRound"]);
    // }
    // return Container();

    return ListView.builder(
      // shrinkWrap: true,
      itemCount: 1,
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,
      itemBuilder: (context, index) {
        return ChatControllerChild(
          msg: widget.msg[index],
          data: widget.data,
          // index: index,
        );
        // return Text("HEllllo");
      },
    );
  }
}
