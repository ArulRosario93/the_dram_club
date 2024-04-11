import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:the_dram_club/Pages/CreateChannel/create_channel.dart";
import "package:the_dram_club/Pages/CreateWorkspace/create_workspace.dart";
import "package:the_dram_club/Utils/hovering_widget.dart";

class ChannelPage extends StatelessWidget {
  final List list;
  final String userName;
  final String userID;
  final String workspaceID;
  final List allUsers;
  const ChannelPage(
      {super.key,
      required this.list,
      required this.workspaceID,
      required this.userID,
      required this.userName,
      required this.allUsers});

  @override
  Widget build(BuildContext context) {
    void handleCreateChannel() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CreateChannel(
                    workspaceID: workspaceID,
                    userEmailID: userID,
                    userName: userName,
                  )));
    }

    void handleCreateWorkspace() {
      // Create Workspace
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CreateWorkSpace(emailID: userID, userName: userName)));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 20.0, bottom: 10),
          child: Text(
            list.isNotEmpty ? "Channels" : "",
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
              userName: userName,
              userEmailID: userID,
              allUsers: allUsers,
              list: list[i]),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: workspaceID.isNotEmpty ? handleCreateChannel : handleCreateWorkspace,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.only(left: 20, right: 20),
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              workspaceID.isNotEmpty
                  ? "Create Channel"
                  : "Create your first Workspace",
              style: GoogleFonts.montserrat(),
            ),
          ),
        )
      ],
    );
  }
}
