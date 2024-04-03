import 'package:flutter/material.dart';
import 'package:the_dram_club/Pages/Channel/ChannelChat/ChatDate/chat_date.dart';
import 'package:the_dram_club/Pages/Channel/ChannelChat/ChatItem/chat_item.dart';

class ChatControllerChild extends StatelessWidget {
  final List msg;
  const ChatControllerChild({
    super.key,
    required this.msg,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          bool sameUser = false;
          bool samedate = false;
          bool sameTime = false;

          if (index > 0 && msg[index]["sender"] == msg[index - 1]["sender"]) {
            sameUser = true;
          }

          //Checking the date

          // and check the round is two
          if (index == 0) {
            samedate = true;
          } else {
            if (index > 0 && msg[index]["date"] != msg[index - 1]["date"]) {
              samedate = true;
            }
          }

          if (index < msg.length - 1 &&
              msg[index]["time"] == msg[index + 1]["time"]) {
            sameTime = true;
          }

          return Column(
            crossAxisAlignment: msg[index]["sender"] == "me"
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              samedate ? ChatDate(date: msg[index]["date"]) : const SizedBox(),
              ChatItem(
                  sameUser: sameUser,
                  msg: msg[index]["msg"],
                  samedate: samedate,
                  sameTime: sameTime,
                  sender: msg[index]["sender"],
                  time: msg[index]["time"],
                  date: msg[index]["date"]),
            ],
          );
          
        },
        itemCount: msg.length);
  }
}
