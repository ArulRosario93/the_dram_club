import 'package:flutter/material.dart';
import 'package:the_dram_club/Auth_services/auth_services.dart';
import 'package:the_dram_club/Pages/Channel/ChannelChat/ChatController/ChatControllerChild/chat_controller_child.dart';

class ChatControllerParent extends StatefulWidget {
  final String workspaceID;
  final String channelID;
  final String userEmailID;
  const ChatControllerParent(
      {super.key,
      required this.workspaceID,
      required this.channelID,
      required this.userEmailID});

  @override
  State<ChatControllerParent> createState() => _ChatControllerParentState();
}

class _ChatControllerParentState extends State<ChatControllerParent> {
  final ScrollController _scrollController = ScrollController();
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
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // if (snapshot.hasError) {
        //   return const Center(
        //     child: Text("Something went wrong"),
        //   );
        // }

        if (snapshot.data == null) {
          return const Center(
            child: Text("No data found"),
          );
        }

        // print(object)

        return ListView.builder(
          // shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,

          itemBuilder: (context, index) {
            return ChatControllerChild(
              data: snapshot.data["Msg"]["Round${index + 1}"],
              indexParent: index,
              userEmailID: widget.userEmailID,
            );
          },
          itemCount: snapshot.data?["Msg"]?["currentRound"] == null
              ? 0
              : snapshot.data["Msg"]["currentRound"],
        );
      },
    );
  }
}
