import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_dram_club/Pages/Channel/ChannelChat/ChatDate/chat_date.dart';
import 'package:the_dram_club/Pages/Channel/ChannelChat/ChatItem/chat_item.dart';

class ChatControllerChild extends StatelessWidget {
  final int indexParent;
  final data;
  const ChatControllerChild({
    super.key,
    required this.data,
    required this.indexParent,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          // return Text("HELLO");
          bool sameUser = false;
          bool samedate = false;
          bool sameTime = false;
          final Timestamp timeStamp = data[index]["Timestamp"];
          late Timestamp pretimeStamp;
          if (index >= 1 &&
              data[index]["Email-ID"] == data[index - 1]["Email-ID"]) {
            sameUser = true;
            // timeStamp = data[index]["Timestamp"];
            pretimeStamp = data[index - 1]["Timestamp"];
            if (timeStamp.toDate().day == pretimeStamp.toDate().day) {
              samedate = true;
            }

            //Checking the time To give some space between the messages
            // if (index < msg.length - 1 &&
            //     msg[index]["time"] == msg[index + 1]["time"]) {
            //   sameTime = true;
            // }
          }

          //Checking the date

          // and check the round is two
          // if (indexParent == 1) {
          //   samedate = true;
          // } else {
          //   if (index > 0) {
          //     timeStamp = data[index]["Timestamp"];
          //     pretimeStamp = data[index - 1]["Timestamp"];
          //     if (timeStamp.toDate().day == pretimeStamp.toDate().day) {
          //       samedate = true;
          //     }

          // }
          // }

          return Column(
            crossAxisAlignment:
                data[index]["Email-ID"] == "itsarrowhere380@gmail.com"
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
            children: [
              samedate ? ChatDate(date: timeStamp) : const SizedBox(),
              ChatItem(
                  sameUser: sameUser,
                  msg: data[index]["msg"],
                  samedate: samedate,
                  sameTime: sameTime,
                  sender: data[index]["Email-ID"],
                  time: timeStamp.toDate().toString().substring(11, 16),
                  date: timeStamp.toDate().toString().substring(0, 10))
            ],
          );
        },
        itemCount: data.length);
  }
}
