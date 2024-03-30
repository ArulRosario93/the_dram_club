import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatItem extends StatelessWidget {
  final bool sameUser;
  final bool sameTime;
  final bool samedate;
  final String msg;
  final String sender;
  final String date;
  final String time;
  const ChatItem(
      {super.key,
      required this.sameUser,
      required this.sameTime,
      required this.date,
      required this.samedate,
      required this.msg,
      required this.sender,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          sender == "me" ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        // !samedate? ChatDate(date: date): const SizedBox(),
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          margin: EdgeInsets.only(
            right: 5,
            left: 5,
            top: !sameTime ? 3 : 0,
          ),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: sender == "me" ? Colors.white : Colors.blue,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            msg,
            style: GoogleFonts.montserrat(color: sender == "me"? Colors.black: Colors.white),
          ),
        ),
        !sameTime
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  time,
                  style:
                      GoogleFonts.montserrat(color: Colors.grey, fontSize: 10),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
