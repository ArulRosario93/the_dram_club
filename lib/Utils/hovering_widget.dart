import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class HoveringWidget extends StatelessWidget {
  const HoveringWidget({super.key});

  @override
  Widget build(BuildContext context) {
    void handleClick() {
      // print("Hovering Widget Clicked");
    }

    return Container(
      margin: const EdgeInsets.only(right: 10, left: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        // style: ListTileStyle.drawer,
        splashColor: Colors.black26,
        leading: const Icon(
          Icons.tag,
        ),
        trailing: const Icon(
          Icons.done_all_rounded,
        ),
        subtitle: const Text("Click to see the magic"),
        onTap: handleClick,
        title: Text("Hovering Widget", style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),),
      ),
    );
  }
}
