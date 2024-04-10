import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserItemAdd extends StatelessWidget {
  final String userName;
  final String userEmailID;
  const UserItemAdd(
      {super.key, required this.userName, required this.userEmailID});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          // color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.only(left: 8, right: 8, top: 5),
        padding: const EdgeInsets.all(10),
        child: ListTile(
          leading: const CircleAvatar(
            backgroundImage: NetworkImage(
                "https://yt3.googleusercontent.com/-CFTJHU7fEWb7BYEb6Jh9gm1EpetvVGQqtof0Rbh-VQRIznYYKJxCaqv_9HeBcmJmIsp2vOO9JU=s900-c-k-c0x00ffffff-no-rj"),
          ),
          title: Text(
            userName,
            style: GoogleFonts.montserrat(),
          ),
          subtitle: Text(
            userEmailID,
            style: GoogleFonts.montserrat(),
          ),
        ));
  }
}
