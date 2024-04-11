import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_dram_club/Pages/SearchUsersAdd/UserItemtoAdd/userItemAdd.dart';

class SearchUsersAddChannel extends StatefulWidget {
  final allUsers;
  const SearchUsersAddChannel({super.key, required this.allUsers});

  @override
  State<SearchUsersAddChannel> createState() => _SearchUsersAddChannelState();
}

class _SearchUsersAddChannelState extends State<SearchUsersAddChannel> {
  List filteredUsers = [];
  List selectedUsers = [];

  void handleSelectedUsers(String email, String name) {
    if (selectedUsers
        .any((ele) => ele['email'] == email && ele['name'] == name)) {
      setState(() {
        selectedUsers.removeWhere(
            (element) => element['email'] == email && element['name'] == name);
      });
    } else {
      setState(() {
        selectedUsers.add({'email': email, 'name': name});
      });
    }
    print(selectedUsers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            "Add Users To Channel",
            style: GoogleFonts.montserrat(),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) => UserItemAdd(
                userName: widget.allUsers[index]["Name"],
                userEmailID: widget.allUsers[index]["Email-ID"],
                selectedUsers: handleSelectedUsers),
            itemCount: widget.allUsers.length,
          )),

          // Bottom Button
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              "Add ${selectedUsers.length} People to this Channel",
              style: GoogleFonts.montserrat(),
            ),
          ),
        ],
      ),
    );
  }
}
