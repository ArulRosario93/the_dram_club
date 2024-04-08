import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:the_dram_club/Pages/Channel/channel.dart';

class HoveringWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String workspaceID;
  final list;

  const HoveringWidget(
      {super.key,
      required this.title,
      required this.workspaceID,
      required this.subtitle,
      required this.list});

  @override
  Widget build(BuildContext context) {
    void handleClick() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Channel(channel: list, workspaceID: workspaceID)));
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
        subtitle: Text(subtitle, style: GoogleFonts.montserrat()),
        onTap: handleClick,
        title: Text(
          title,
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
