import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GetName extends StatelessWidget {
  final TextEditingController channelName;
  final TextEditingController channelDes;
  final Function()? handleNext;
  const GetName(
      {super.key,
      required this.channelName,
      required this.channelDes,
      required this.handleNext});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60),
          Text("Channel Name",
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 5),
          TextField(
            controller: channelName,
            style: GoogleFonts.montserrat(color: Colors.white),
            decoration: InputDecoration(
                hintStyle: GoogleFonts.montserrat(color: Colors.white),
                hintText: "Channel Name",
                border: const OutlineInputBorder()),
          ),
          const SizedBox(height: 20),
          Text("Channel Description",
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 5),
          TextField(
            controller: channelDes,
            maxLength: 50,
            style: GoogleFonts.montserrat(color: Colors.white),
            decoration: InputDecoration(
                hintStyle: GoogleFonts.montserrat(color: Colors.white),
                hintText: "Channel Description",
                border: const OutlineInputBorder()),
          ),
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: handleNext,
              child: const Text("Next"),
            ),
          )
        ],
      ),
    );
  }
}
