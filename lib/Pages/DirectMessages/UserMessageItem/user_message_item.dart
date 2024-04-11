import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserMessageItem extends StatelessWidget {
  final String name;
  final String emailID;
  const UserMessageItem({super.key, required this.name, required this.emailID});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle,
          ),
          child: Text(
            name[0] + name[1],
            style: GoogleFonts.montserrat(
                fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
            child: ListTile(
                title: Text(
                  name,
                  style: GoogleFonts.montserrat(),
                ),
                subtitle: Text(
                  emailID,
                  style: GoogleFonts.montserrat(),
                )))
      ]),
    );
  }
}
