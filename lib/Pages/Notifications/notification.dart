import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:the_dram_club/Auth_services/auth_services.dart";
import "package:the_dram_club/Pages/Notifications/NotificationForChat/notification_for_chat_request.dart";
import "package:the_dram_club/Pages/Notifications/NotificationForChatResponse/notification_for_chat_response.dart";

class NotificationPage extends StatelessWidget {
  final String emailID;
  final String userDP;
  final String name;
  const NotificationPage(
      {super.key,
      required this.emailID,
      required this.userDP,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style:
              GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
                  stream: AuthServices().getNotifications(emailID),
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ListView.builder(
                        itemCount: snapshot.data["Notifications"].length,
                        itemBuilder: (context, index) {
                          final data = snapshot.data["Notifications"];
                          return data[index]["Type"] == "Request-Workspace"
                              ? NotificationForChatRequest(
                                  data: data[index],
                                  userDP: userDP,
                                  workspaceID: data[index]["ID"],
                                  emailID: emailID,
                                  name: name,
                                  workspaceName: data[index]["Name"],
                                  workspaceDescription: data[index]
                                      ["Description"],
                                  role: "student",
                                  notificationID: data[index]["notificationID"],
                                  roleInt: 2)
                              : NotificationForChatResponse();
                        });
                  }))
        ],
      ),
    );
  }
}
