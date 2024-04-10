import 'package:flutter/material.dart';
import 'package:the_dram_club/Pages/Channel/ChannelUsers/AddUserToWorkspace/add_user_to_workspace.dart';
import 'package:the_dram_club/Pages/Channel/ChannelUsers/GotoSelectUsersChannel/go_to_select_users_channel.dart';
import 'package:the_dram_club/Pages/Channel/ChannelUsers/UserItem/user_item.dart';
import 'package:the_dram_club/Pages/Channel/ChannelUsers/UserSearch/user_search.dart';

class ChannelUsers extends StatelessWidget {
  final String channelName;
  final List allUsers;
  const ChannelUsers(
      {super.key, required this.channelName, required this.allUsers});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      UserSearch(),
      AddUserToWorkspace(),
      GoToSelectUsersChannel(allUsers: allUsers),
      UserItem(),
      UserItem(),
    ]);
  }
}
