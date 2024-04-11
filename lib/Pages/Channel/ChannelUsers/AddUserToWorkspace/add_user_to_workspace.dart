import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_dram_club/Pages/SearchUsersAdd/search_users_add.dart';

class AddUserToWorkspace extends StatelessWidget {
  final List allUsers;
  final String workSpaceID;
  final String workspaceName;
  final String userName;
  final String userEmailID;
  final String workspaceDescription;
  const AddUserToWorkspace(
      {super.key,
      required this.allUsers,
      required this.workSpaceID,
      required this.workspaceName,
      required this.userName,
      required this.userEmailID,
      required this.workspaceDescription});

  @override
  Widget build(BuildContext context) {
    void handlegotoSearchUserAdd() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchUserAdd(
              allUsers: allUsers,
              workSpaceID: workSpaceID,
              userEmailID: userEmailID,
              userName: userName,
              workspaceDescription: workspaceDescription,
              workspaceName: workspaceName,
            ),
          ));
    }

    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(15),
      ),
      child: GestureDetector(
          onTap: handlegotoSearchUserAdd,
          child: Text(
            "Add People to Workspace",
            style: GoogleFonts.montserrat(),
          )),
    );
  }
}
