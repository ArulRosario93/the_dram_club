import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_dram_club/Auth_services/auth_services.dart';
import 'package:the_dram_club/Pages/Channel/ChannelChat/ChatController/ChatControllerChild/chat_controller_child.dart';

class ChatControllerParent extends StatefulWidget {
  final data;
  final String workspaceID;
  final String channelID;
  const ChatControllerParent(
      {super.key,
      required this.data,
      required this.workspaceID,
      required this.channelID});

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

    return StreamBuilder(
      stream: AuthServices().channelChat(widget.workspaceID, widget.channelID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        // final chatData = snapshot.data();
        // print(snapshot.data["Msg"]["currentRound"]);

        return ListView.builder(
          // shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          itemBuilder: (context, index) {
            return ChatControllerChild(
              data: snapshot.data["Msg"]["Round${index+1}"],
              indexParent: index,
            );
          },
          itemCount: snapshot.data["Msg"]["currentRound"],
        );
      },
    );

    // return ListView.builder(
    //   // shrinkWrap: true,
    //   physics: const BouncingScrollPhysics(),
    //   controller: _scrollController,

    //   itemBuilder: (context, index) {
    //     return ChatControllerChild(
    //       data: widget.data["Msg"]["Round${index + 1}"],
    //       indexParent: index,
    //     );
    //   },
    //   itemCount: widget.data?["Msg"]?["currentRound"] == null
    //       ? 0
    //       : widget.data["Msg"]["currentRound"],
    // );
  }
}
