import 'package:flutter/material.dart';
import 'package:the_dram_club/Pages/Channel/ChannelChat/ChatController/ChatControllerChild/chat_controller_child.dart';

class ChatControllerParent extends StatefulWidget {
  final data;
  final Function(String round) handleRound;
  const ChatControllerParent(
      {super.key, required this.data, required this.handleRound});

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
    widget.handleRound(widget.data?["Msg"]?["currentRound"] == null
        ? null
        : widget.data["Msg"]["currentRound"]);
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
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,

      itemBuilder: (context, index) {
        return ChatControllerChild(
          data: widget.data["Msg"]["Round${index + 1}"],
          indexParent: index,
        );
      },
      itemCount: widget.data?["Msg"]?["currentRound"] == null
          ? 0
          : widget.data["Msg"]["currentRound"],
    );
  }
}
