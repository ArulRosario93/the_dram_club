import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_dram_club/Utils/get_info.dart';

class StudentForm extends StatelessWidget {
  const StudentForm({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController reason = TextEditingController();
    final TextEditingController odOleave = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(20.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text('Student Form', style: GoogleFonts.montserrat(fontSize: 22, fontWeight: FontWeight.w600),),
          // const SizedBox(height: 20, ),
          Text(
            "OD/ Leave:",
            style: GoogleFonts.montserrat(
                fontSize: 16, fontWeight: FontWeight.w500),
          ),
          GetInfo(controller: odOleave, hintText: "Reason", autoFocus: true, maxLines: false,),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Reason for Leave:",
            style: GoogleFonts.montserrat(
                fontSize: 16, fontWeight: FontWeight.w500),
          ),
          GetInfo(controller: reason, hintText: "Reason", autoFocus: true, maxLines: true,),
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 20, right: 20,),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [Colors.blue.shade600, Colors.blue],
              ),
            ),
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Text('Submit', style: GoogleFonts.montserrat(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),),
          )
        ],
      ),
    );
  }
}
