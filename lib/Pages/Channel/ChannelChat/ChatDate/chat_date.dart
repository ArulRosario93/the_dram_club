import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatDate extends StatelessWidget {
  final String date;
  const ChatDate({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // color: Colors.grey[100],
        ),
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(5.0),
        alignment: Alignment.center,
        child: Text(
          date,
          style: GoogleFonts.montserrat(
              color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
        ));
  }
}
