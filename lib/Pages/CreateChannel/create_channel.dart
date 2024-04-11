import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_dram_club/Auth_services/auth_services.dart';
import 'package:the_dram_club/Pages/CreateChannel/GetName/get_name.dart';
import 'package:the_dram_club/Pages/CreateChannel/SelectUsers/select_users.dart';

class CreateChannel extends StatefulWidget {
  final String workspaceID;
  final String userName;
  final String userEmailID;
  const CreateChannel(
      {super.key,
      required this.workspaceID,
      required this.userName,
      required this.userEmailID});

  @override
  State<CreateChannel> createState() => _CreateChannelState();
}

class _CreateChannelState extends State<CreateChannel> {
  final TextEditingController channelName = TextEditingController();
  final TextEditingController channelDes = TextEditingController();

  List allUsers = [];
  int selectedPage = 0;

  void handleInitial() async {
    await AuthServices().getWorkspace(widget.workspaceID).then((value) => {
          setState(() {
            allUsers = value["All-Users"];
          })
        });
  }

  void handleNext() {
    if (channelName.text.isNotEmpty && channelDes.text.isNotEmpty) {
      setState(() {
        selectedPage = 1;
      });
    } else {
      const SnackBar(content: Text("Please fill all the fields"));
    }
  }

  void handleCreateChannel() {
    // Create Channel
  }

  // void handleNameDes() {}

  @override
  void initState() {
    super.initState();
    handleInitial();
  }

  @override
  void dispose() {
    channelName.dispose();
    channelDes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      GetName(
        channelName: channelName,
        channelDes: channelDes,
        handleNext: handleNext,
      ),
      SelectUsers(
          allusers: allUsers,
          workspaceID: widget.workspaceID,
          channelName: channelName.text,
          description: channelDes.text,
          userName: widget.userName,
          userEmailID: widget.userEmailID),
    ];

    return Scaffold(
      backgroundColor: Colors.deepPurple[400],
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Text(
            selectedPage == 0 ? "Create Channel" : "Add people to the Channel",
            style: GoogleFonts.montserrat(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: pages[selectedPage],
          ),
        ],
      )),
    );
  }
}
