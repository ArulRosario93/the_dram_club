import 'package:flutter/material.dart';
import 'package:the_dram_club/Pages/Channel/ChannelFiles/FolderChannel/channel_folder.dart';

class ChannelFiles extends StatelessWidget {
  const ChannelFiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ChannelFolder(
          name: "Main Folder",
        ),
        const ChannelFolder(
          name: "Uploaded",
        ),
      ],
    );
  }
}
