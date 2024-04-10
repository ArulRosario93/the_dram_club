import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_dram_club/Auth_services/auth_services.dart';
import 'package:the_dram_club/Pages/CreateChannel/SelectUsers/UserItem/user_item.dart';
import 'package:the_dram_club/Pages/Home/home.dart';

class SelectUsers extends StatefulWidget {
  final String workspaceID;
  final String channelName;
  final String description;
  final String userName;
  final String userEmailID;
  final List allusers;
  const SelectUsers(
      {super.key,
      required this.allusers,
      required this.workspaceID,
      required this.channelName,
      required this.description,
      required this.userName,
      required this.userEmailID});

  @override
  State<SelectUsers> createState() => _SelectUsersState();
}

class _SelectUsersState extends State<SelectUsers> {
  List selectedUsers = [];

  void handleSelectUser(String name, String emailID) {
    // Select User
    if (selectedUsers.any((e) => e["Email-ID"] == emailID)) {
      selectedUsers.any((e) => e["Email-ID"] == emailID)
          ? selectedUsers.removeWhere((e) => e["Email-ID"] == emailID)
          : print("Not Found");
    } else {
      selectedUsers.add({
        "Name": name,
        "Email-ID": emailID,
        "Data-Joined": Timestamp.now(),
      });
    }
    print(selectedUsers);
  }

  void handleSubmit() async {
    // Create Channel
    // setState(() {});

    String res = await AuthServices().createChannel(
        widget.workspaceID,
        widget.channelName,
        widget.description,
        widget.userName,
        widget.userEmailID,
        selectedUsers);

    if (res == "Success") {
      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => const HomePage(),));
    } else {
      print("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              // alignment: Alignment.centerRight,
              child: Text(
                "Select All Users",
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              )),
          const SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    for (var user in widget.allusers)
                      UserItem(
                        handleSelectUser: handleSelectUser,
                        name: user["Name"],
                        emailID: user["Email-ID"],
                      ),
                  ],
                )),
          ),
          GestureDetector(
            onTap: handleSubmit,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.deepPurple,
                ),
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                alignment: Alignment.center,
                child: Text(
                  "Create Channel",
                  style: GoogleFonts.montserrat(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
