import 'package:flutter/material.dart';
import 'package:the_dram_club/Pages/Channel/ChannelChat/ChatDate/chat_date.dart';
import 'package:the_dram_club/Pages/Channel/ChannelChat/ChatItem/chat_item.dart';

class ChatControllerChild extends StatelessWidget {
  final List msg;
  final Function handleLastDate;
  final String lastDate;
  const ChatControllerChild(
      {super.key,
      required this.msg,
      required this.handleLastDate,
      required this.lastDate});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          bool sameUser = false;
          bool samedate = false;
          bool sameTime = false;

          if (index > 0 && msg[index]["sender"] == msg[index - 1]["sender"]) {
            sameUser = true;
          }
          if (index == 0 && lastDate == "") {
            handleLastDate(msg[index]["date"]);
            samedate = true;
          } else if (lastDate == msg[index]["date"]) {
            // samedate = true;
          }else{
            handleLastDate(msg[index]["date"]);
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
              !samedate ? ChatDate(date: msg[index]["date"]) : const SizedBox(),
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
