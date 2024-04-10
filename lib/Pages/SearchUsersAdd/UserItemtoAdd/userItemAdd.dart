import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserItemAdd extends StatefulWidget {
  final String userName;
  final String userEmailID;
  final Function(String name, String email) selectedUsers;
  const UserItemAdd(
      {super.key, required this.userName, required this.userEmailID, required this.selectedUsers});

  @override
  State<UserItemAdd> createState() => _UserItemAddState();
}

class _UserItemAddState extends State<UserItemAdd> {
  bool isSelected = false;

  void handleTap() {
    widget.selectedUsers(widget.userName, widget.userEmailID);
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleTap,
      child: Container(
          decoration: BoxDecoration(
            color: isSelected ? Colors.deepPurpleAccent : Colors.transparent,
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
                widget.userName,
                style: GoogleFonts.montserrat(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
              subtitle: Text(
                widget.userEmailID,
                style: GoogleFonts.montserrat(
                  color: isSelected ? Colors.white : Colors.grey,
                ),
              ),
              trailing: isSelected
                  ? const Icon(
                      Icons.check_circle,
                      color: Colors.deepPurple,
                    )
                  : const SizedBox())),
    );
  }
}
