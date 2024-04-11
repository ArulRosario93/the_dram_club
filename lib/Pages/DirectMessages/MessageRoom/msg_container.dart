import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MsgContainer extends StatelessWidget {
  final String emailID;
  final String name;
  final String userID;
  final String msg;
  final Timestamp time;
  const MsgContainer(
      {super.key,
      required this.emailID,
      required this.name,
      required this.userID,
      required this.msg,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          userID == emailID ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          alignment:
              userID == emailID ? Alignment.centerRight : Alignment.centerLeft,
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
          child: Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                msg,
                style: GoogleFonts.montserrat(
                    fontSize: 16, fontWeight: FontWeight.w500),
              )),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              time.toDate().toString().substring(11, 16),
            ))
      ],
    );
  }
}
