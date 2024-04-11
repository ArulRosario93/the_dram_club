import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_dram_club/Pages/CreateChannel/SelectUsers/select_users.dart';
import 'package:the_dram_club/Pages/SearchUsersAddChannel/search_users_add_channel.dart';

class GoToSelectUsersChannel extends StatelessWidget {
  final allUsers;
  final String emailID;
  final String name;
  const GoToSelectUsersChannel(
      {super.key,
      required this.allUsers,
      required this.emailID,
      required this.name});

  @override
  Widget build(BuildContext context) {
    void handlegotoSearchUserAdd() {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchUsersAddChannel(
                allUsers: allUsers, emailID: emailID, name: name)),
      );
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
            "Add People to this Channel",
            style: GoogleFonts.montserrat(),
          )),
    );
  }
}
