import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:the_dram_club/Pages/Channel/ChannelChat/channel_chat.dart';
import 'package:the_dram_club/Pages/Channel/ChannelFiles/channel_files.dart';
import 'package:the_dram_club/Pages/Channel/ChannelUsers/channel_users.dart';

class Channel extends StatefulWidget {
  const Channel({super.key});

  @override
  State<Channel> createState() => _ChannelState();
}

class _ChannelState extends State<Channel> {
  // int _selectedPage = 0;
  final PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  void handlePageSelection(int index) {
    setState(() {
      // _selectedPage = index;
      // setState(() {
      _pageController.animateToPage(index,
          duration: Durations.short1, curve: Curves.easeIn);
      // _selectedIndex = val;
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      //Chat,
      Channelchat(),

      //Files,
      ChannelFiles(),

      //All Users
      ChannelUsers(),
    ];

    return Scaffold(
        appBar: AppBar(
          title: Text('Channel'),
        ),
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
