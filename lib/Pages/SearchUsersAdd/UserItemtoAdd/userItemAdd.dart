import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_dram_club/Auth_services/auth_services.dart';
import 'package:the_dram_club/Pages/Home/home.dart';

class UserItemAdd extends StatefulWidget {
  final String userName;
  final String userEmailID;
  final String nameUser;
  final String emailUser;
  final Function(String name, String email) selectedUsers;
  const UserItemAdd(
      {super.key,
      required this.userName,
      required this.userEmailID,
      required this.selectedUsers,
      required this.nameUser,
      required this.emailUser});

  @override
  State<UserItemAdd> createState() => _UserItemAddState();
}

class _UserItemAddState extends State<UserItemAdd> {
  bool isSelected = false;

  void handleTap() {
    widget.selectedUsers(widget.userEmailID, widget.userName);
    setState(() {
      isSelected = !isSelected;
    });
  }

  void handleCreateDirectMessage() async {
    String res = await AuthServices().createDirectMessageRoom(
        widget.emailUser, widget.nameUser, widget.userEmailID, widget.userName);

    if (res == "Success") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Failed to create Direct Message Room",
            style: GoogleFonts.montserrat(),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleTap,
      onLongPress: handleCreateDirectMessage,
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
