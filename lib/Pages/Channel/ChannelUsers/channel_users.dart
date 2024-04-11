import 'package:flutter/material.dart';
import 'package:the_dram_club/Pages/Channel/ChannelUsers/AddUserToWorkspace/add_user_to_workspace.dart';
import 'package:the_dram_club/Pages/Channel/ChannelUsers/GotoSelectUsersChannel/go_to_select_users_channel.dart';
import 'package:the_dram_club/Pages/Channel/ChannelUsers/UserItem/user_item.dart';
import 'package:the_dram_club/Pages/Channel/ChannelUsers/UserSearch/user_search.dart';

class ChannelUsers extends StatelessWidget {
  final String channelName;
  final allUsers;
  final String workSpaceID;
  final String workspaceName;
  final String userName;
  final String userEmailID;
  final String workspaceDescription;
  const ChannelUsers(
      {super.key,
      required this.channelName,
      required this.allUsers,
      required this.workSpaceID,
      required this.workspaceName,
      required this.userName,
      required this.userEmailID,
      required this.workspaceDescription});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // UserSearch(),
      AddUserToWorkspace(
          allUsers: allUsers,
          emailIDuser: userEmailID,
          nameUser: userName,
          workSpaceID: workSpaceID,
          workspaceName: workspaceName,
          userName: userName,
          userEmailID: userEmailID,
          workspaceDescription: workspaceDescription),
      const SizedBox(height: 10),
      GoToSelectUsersChannel(
          allUsers: allUsers, emailID: userEmailID, name: userName),
      for (var i = 0; i < allUsers.length; i++)
        UserItem(
            emailID: allUsers[i]["Email-ID"], username: allUsers[i]["Name"]),
      // UserItem(),
    ]);
  }
}
