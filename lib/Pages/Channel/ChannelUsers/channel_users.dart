import 'package:flutter/material.dart';
import 'package:the_dram_club/Pages/Channel/ChannelUsers/UserItem/user_item.dart';
import 'package:the_dram_club/Pages/Channel/ChannelUsers/UserSearch/user_search.dart';

class ChannelUsers extends StatelessWidget {
  const ChannelUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        UserSearch(),
        UserItem(),
        UserItem(),
      ]
    );
  }
}