import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatDate extends StatelessWidget {
  final Timestamp date;
  const ChatDate({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // color: Colors.grey[100],
        ),
        // padding: const EdgeInsets.all(1.0),
        // margin: const EdgeInsets.all(2.0),
        alignment: Alignment.center,
        child: Text(
          date.toDate().day.toString() +
              "/" +
              date.toDate().month.toString() +
              "/" +
              date.toDate().year.toString(),
          style: GoogleFonts.montserrat(
              color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
        ));
  }
}
