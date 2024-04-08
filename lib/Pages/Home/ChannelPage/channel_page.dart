import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:the_dram_club/Pages/Channel/channel.dart";
import "package:the_dram_club/Utils/hovering_widget.dart";
// import "package:the_dram_club/Utils/hovering_widget.dart";

class ChannelPage extends StatelessWidget {
  final List list;
  final String workspaceID;
  const ChannelPage({super.key, required this.list, required this.workspaceID});

  @override
  Widget build(BuildContext context) {
    // print(list);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 20.0, bottom: 10),
          child: Text(
            "Channels",
            textAlign: TextAlign.left,
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ),
        for (var i = 0; i < list.length; i++)
          HoveringWidget(
              title: list[i]["Name"],
              workspaceID: workspaceID,
              subtitle: list[i]["Description"],
              list: list[i])
      ],
    );
  }
}
