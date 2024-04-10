import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserItem extends StatefulWidget {
  final String name;
  final String emailID;
  final Function(String name, String emailID) handleSelectUser;
  const UserItem({
    super.key,
    required this.name,
    required this.emailID,
    required this.handleSelectUser,
  });

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  bool isSelected = false;

  // void handleIniial() {
  //   isSelected =
  //       widget.selectedUsers.any((e) => e["Email-ID"] == widget.emailID);
  // }

  void handleSelect() {
    widget.handleSelectUser(widget.name, widget.emailID);
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  void initState() {
    super.initState();
    // handleIniial();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleSelect,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepPurple : Colors.transparent,
          borderRadius: BorderRadius.circular(60),
          border: Border.all(color: Colors.deepPurple[300]!),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListTile(
          title: Text(widget.name,
              style: GoogleFonts.montserrat(color: Colors.white)),
          subtitle: Text(widget.emailID,
              style: GoogleFonts.montserrat(color: Colors.white)),
          trailing: Icon(
            isSelected ? Icons.done : Icons.add,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}
