import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GetInfo extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool autoFocus;
  final bool maxLines;
  const GetInfo({
    super.key,
    required this.controller,
    required this.hintText,
    required this.autoFocus,
    required this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: autoFocus,
      maxLines: maxLines? 7 : 1,
      minLines: 1,
      obscureText: hintText == 'Password' || hintText == "Confirm Password" ? true : false,
      maxLength: maxLines? 100 : null,
      textAlign: TextAlign.left,
      style: GoogleFonts.montserrat(color: Colors.black),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        hintText: hintText,
        hintStyle: GoogleFonts.montserrat(color: Colors.grey),
        // border: OutlineInputBorder(
        //   borderSide: const BorderSide(color: Color.fromARGB(255, 90, 90, 90), width: 1),
        //   borderRadius: BorderRadius.circular(10),
        // ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 90, 90, 90), width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
