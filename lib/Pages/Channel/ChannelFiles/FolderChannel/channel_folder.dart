import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChannelFolder extends StatelessWidget {
  final String name;
  const ChannelFolder({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.yellow.shade700,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.folder,
            size: 20,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            name,
            style: GoogleFonts.montserrat(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
