import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_dram_club/Utils/get_info.dart';

class WorkspaceForm extends StatelessWidget {
  final TextEditingController orgName;
  final TextEditingController orgDes;
  const WorkspaceForm({super.key, required this.orgName, required this.orgDes});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.start,
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
        Text("Workspaces are where you collaborate with your team",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
                fontSize: 13, fontWeight: FontWeight.w400, color: Colors.grey)),
        const SizedBox(
          height: 30,
        ),
        Text(
          "Name your workspace",
          textAlign: TextAlign.left,
          style: GoogleFonts.montserrat(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.blue),
        ),
        const SizedBox(
          height: 10,
        ),
        GetInfo(
          maxLines: false,
          controller: orgName,
          hintText: "eg: The Dram Club",
          autoFocus: true,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Description for your workspace",
          textAlign: TextAlign.left,
          style: GoogleFonts.montserrat(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.blue),
        ),
        const SizedBox(
          height: 10,
        ),
        GetInfo(
          maxLines: false,
          controller: orgDes,
          hintText: "eg: Club for Dramatics",
          autoFocus: false,
        ),
      ],
    );
  }
}
