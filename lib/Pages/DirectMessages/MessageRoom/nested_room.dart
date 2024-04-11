import 'package:flutter/material.dart';
import 'package:the_dram_club/Pages/DirectMessages/MessageRoom/msg_container.dart';

class NestedRoom extends StatelessWidget {
  final String userID;
  final List msg;
  const NestedRoom({super.key, required this.msg, required this.userID});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) => MsgContainer(
          emailID: msg[index]["Email-ID"],
          name: msg[index]["Name"],
          userID: userID,
          time: msg[index]["Timestamp"],
          msg: msg[index]["msg"]),
      itemCount: msg.length,
    );
  }
}
