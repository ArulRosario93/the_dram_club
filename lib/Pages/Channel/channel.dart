import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_dram_club/Auth_services/auth_services.dart';
import 'package:the_dram_club/Pages/Channel/ChannelChat/channel_chat.dart';
import 'package:the_dram_club/Pages/Channel/ChannelFiles/FloatIcon/floaticon.dart';
import 'package:the_dram_club/Pages/Channel/ChannelFiles/channel_files.dart';
import 'package:the_dram_club/Pages/Channel/ChannelUsers/channel_users.dart';

class Channel extends StatefulWidget {
  final channel;
  final String userName;
  final String userEmailID;
  final String workspaceID;
  const Channel({super.key, required this.channel, required this.workspaceID, required this.userName, required this.userEmailID});

  @override
  State<Channel> createState() => _ChannelState();
}

class _ChannelState extends State<Channel> {
  int selectedPage = 0;
  bool _isfloatVisible = false;
  var ChannelData;
  List msgs = [];
  int currentRound = 0;

  final PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  void handlePageSelection(int index) {
    setState(() {
      _isfloatVisible = false;
      _pageController.animateToPage(index,
          duration: Durations.medium1, curve: Curves.easeIn);
      selectedPage = index;
    });
  }

  void handleCurrentRound(int round) {
    setState(() {
      currentRound = round;
    });
  }

  void handlemsgSend(
    String msg,
  ) async {
    // print(currentRound);
    // print(msg);
    String res = await AuthServices().sendMsgChannel(
      widget.workspaceID,
      widget.channel["ID"],
      msg,
      widget.userEmailID,
      widget.userName,
    );
    if (res != "Success") {
      const SnackBar(content: Text("Failed to send message"));
    }
  }

  void handlemsgList() {
    // ChannelData?["Msg"].
  }

  void handleFloatButtonVisibility() {
    setState(() {
      _isfloatVisible = !_isfloatVisible;
    });
  }

  void handleChannelData() async {
    await AuthServices()
        .getChannel(widget.workspaceID, widget.channel["ID"])
        .then((value) => {ChannelData = value});
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    handleChannelData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(ChannelData?["Msg"]["Round1"]);

    List<Widget> pages = [
      //Chat,
      Channelchat(
          handleMsg: handlemsgSend,
          workspaceID: widget.workspaceID,
          channelID: widget.channel["ID"],
          data:
              ChannelData?["Msg"]?["currentRound"] == null ? {} : ChannelData),

      //Files,
      ChannelFiles(),

      //All Users
      ChannelUsers(),
    ];

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.channel["Name"] ?? 'Channel Name', style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 18),),
        ),
        floatingActionButton: selectedPage == 1
            ? GestureDetector(
                onTap: () => handleFloatButtonVisibility(),
                child: AnimatedContainer(
                    duration: Durations.extralong1,
                    child: _isfloatVisible
                        ? const Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FloatIcon(
                                icon: Icon(Icons.drive_folder_upload_outlined,
                                    color: Colors.white),
                              ),
                              SizedBox(height: 10),
                              FloatIcon(
                                  icon: Icon(Icons.add, color: Colors.white)),
                            ],
                          )
                        : GestureDetector(
                            onTap: () => handleFloatButtonVisibility(),
                            child: const FloatIcon(
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ))),
              )
            : null,
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: InkWell(
                        onTap: () => handlePageSelection(0),
                        child: const Text('Chat')),
                  ),
                ),
                Flexible(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: InkWell(
                        onTap: () => handlePageSelection(1),
                        child: const Text('Files')),
                  ),
                ),
                Flexible(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: InkWell(
                        onTap: () => handlePageSelection(2),
                        child: const Text('Users')),
                  ),
                ),
              ],
            ),
            Expanded(
                child: PageView(
              controller: _pageController,
              onPageChanged: handlePageSelection,
              children: pages,
            )),
          ],
        ));
  }
}
