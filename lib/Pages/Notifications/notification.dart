import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:the_dram_club/Pages/Notifications/NotificationForChat/notification_for_chat_request.dart";
import "package:the_dram_club/Pages/Notifications/NotificationForChatResponse/notification_for_chat_response.dart";

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications', style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 20),),
      ),
      body: Column(
        children: [
          NotificationForChatRequest(),
          NotificationForChatRequest(),
          NotificationForChatResponse(),
        ],
      ),
    );
  }
}