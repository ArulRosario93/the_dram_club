import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_dram_club/Pages/DirectMessages/MessageRoom/message_room.dart';
import 'package:the_dram_club/Pages/DirectMessages/UserMessageItem/user_message_item.dart';

class DirectMessages extends StatelessWidget {
  final List directMessage;
  const DirectMessages({super.key, required this.directMessage});


  @override
  Widget build(BuildContext context) {
  void gotoUserMessage(String emailID, String name, String roomID) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MessageRoom(emailID: emailID, name: name, roomID: roomID)));
  }
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => GestureDetector(onTap:() => gotoUserMessage(directMessage[index]["Email-ID"], directMessage[index]["Name"], directMessage[index]["ID"]), child: UserMessageItem(name: directMessage[index]["Name"], emailID: directMessage[index]["Email-ID"])),
            itemCount: directMessage.length,
          )
        ],
      ),
    );
  }
}
