import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_dram_club/Pages/CreateChannel/GetName/get_name.dart';
import 'package:the_dram_club/Pages/CreateChannel/SelectUsers/select_users.dart';

class CreateChannel extends StatefulWidget {
  const CreateChannel({super.key});

  @override
  State<CreateChannel> createState() => _CreateChannelState();
}

class _CreateChannelState extends State<CreateChannel> {
  final TextEditingController channelName = TextEditingController();
  final TextEditingController channelDes = TextEditingController();
  int selectedPage = 0;

  void handleNext() {
    setState(() {
      selectedPage = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      GetName(
        channelName: channelName,
        channelDes: channelDes,
        handleNext: handleNext,
      ),
      const SelectUsers(),
    ];

    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Text(
            "Create Channel",
            style: GoogleFonts.montserrat(),
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
