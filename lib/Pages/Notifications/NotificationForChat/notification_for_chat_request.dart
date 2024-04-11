import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_dram_club/Auth_services/auth_services.dart';

class NotificationForChatRequest extends StatelessWidget {
  final dynamic data;
  final String userDP;
  final String workspaceID;
  final String emailID;
  final String name;
  final String workspaceName;
  final String workspaceDescription;
  final String role;
  final int roleInt;
  final String notificationID;
  const NotificationForChatRequest(
      {super.key,
      required this.data,
      required this.userDP,
      required this.workspaceID,
      required this.emailID,
      required this.name,
      required this.workspaceName,
      required this.workspaceDescription,
      required this.role,
      required this.roleInt,
      required this.notificationID});

  @override
  Widget build(BuildContext context) {
    void showMsg(String msg) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(msg),
        duration: Durations.extralong1,
      ));
    }

    void handleReject() async {
      // Add your logic here
      String res = await AuthServices().rejectRequestToJoinWorkspace(
          workspaceID,
          emailID,
          name,
          workspaceName,
          workspaceDescription,
          notificationID);

      if (res == "Success") {
        showMsg("Request Rejected");
      } else {
        showMsg(res);
      }
    }

    void handleSubmit() async {
      // Add your logic here
      String res = await AuthServices().acceptRequestToJoinWorkspace(
          workspaceID,
          emailID,
          name,
          workspaceName,
          role,
          roleInt,
          notificationID,
          workspaceDescription);

      if (res == "Success") {
        showMsg("Request Accepted");
      } else {
        showMsg(res);
      }
    }

    return Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: userDP == ""
                  ? null
                  : NetworkImage(
                      userDP,
                    ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data["Name"] ?? "",
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text("You're requested to join this workspace",
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        fontSize: 12,
                      ),
                    )),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: handleSubmit,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.done, color: Colors.blue),
              ),
            ),
            GestureDetector(
              onTap: handleReject,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.clear_outlined, color: Colors.red),
              ),
            ),
            const SizedBox(width: 5)
          ],
        ));
  }
}
