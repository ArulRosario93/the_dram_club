import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkspaceDetails extends StatefulWidget {
  final Function(int val) strict;
  // Function(int val) radioChange;
  const WorkspaceDetails({super.key, required this.strict});

  @override
  State<WorkspaceDetails> createState() => _WorkspaceDetailsState();
}

class _WorkspaceDetailsState extends State<WorkspaceDetails> {
  int strict = 0;
  void radioChange(int value) {
    setState(() {
      widget.strict(value);
      strict = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Create WorkSpace',
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent),
        ),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          height: 30,
        ),
        Text("How strict do you want Leave/OD permissions for your workspace?",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87)),
        const SizedBox(
          height: 10,
        ),
        ListTile(
            onTap: () => radioChange(1),
            leading: Text(
              "1.",
              style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            title: Text(
              "Approved only when Higher Authority and Teacher accepts",
              style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              "Hard",
              style: GoogleFonts.montserrat(
                  color: Colors.red, fontWeight: FontWeight.bold),
            ),
            trailing: Icon(
              strict == 1
                  ? Icons.radio_button_checked_sharp
                  : Icons.radio_button_unchecked_sharp,
              color: Colors.deepPurple,
            )),
        ListTile(
            onTap: () => radioChange(2),
            leading: Text(
              "2.",
              style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            title: Text(
              "Approved when Higher Authority or Teacher accepts",
              style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              "Medium",
              style: GoogleFonts.montserrat(
                  color: Colors.orange, fontWeight: FontWeight.bold),
            ),
            trailing: Icon(
              strict == 2
                  ? Icons.radio_button_checked_sharp
                  : Icons.radio_button_unchecked_sharp,
              color: Colors.deepPurple,
            )),
        ListTile(
            onTap: () => radioChange(3),
            leading: Text(
              "3.",
              style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            title: Text(
              "For informing the absence",
              style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              "Soft",
              style: GoogleFonts.montserrat(
                  color: Colors.green, fontWeight: FontWeight.bold),
            ),
            trailing: Icon(
              strict == 3
                  ? Icons.radio_button_checked_sharp
                  : Icons.radio_button_unchecked_sharp,
              color: Colors.deepPurple,
            )),
      ],
    );
  }
}
