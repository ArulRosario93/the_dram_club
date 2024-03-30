import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserSearch extends StatelessWidget {
  const UserSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Search Users',
          hintStyle: GoogleFonts.montserrat(),
          contentPadding: const EdgeInsets.only(left: 10, top: 0, bottom: 0),
          prefixIcon: const Icon(Icons.search),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      )
    );
  }
}