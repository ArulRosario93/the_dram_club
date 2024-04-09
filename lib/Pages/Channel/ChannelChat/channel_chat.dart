import 'package:flutter/material.dart';
import 'package:the_dram_club/Pages/Channel/ChannelChat/ChatController/ChatControllerParent/chat_controller_parent.dart';
// import 'package:the_dram_club/Pages/Channel/ChannelChat/ChatController/chat_controller.dart';

class Channelchat extends StatefulWidget {
  final data;
  final Function(String msg) handleMsg;
  final String workspaceID;
  final String channelID;
  const Channelchat({super.key, required this.data, required this.workspaceID, required this.channelID, required this.handleMsg});

  @override
  State<Channelchat> createState() => _ChannelchatState();
}

class _ChannelchatState extends State<Channelchat> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController msgController = TextEditingController();

    void handleMsg() {
      widget.handleMsg(msgController.text);
      msgController.clear();
    }

    return Container(
      color: Colors.red[100],
      child: Column(
        children: [
          Expanded(
              child: ChatControllerParent(
            data: widget.data,
            workspaceID: widget.workspaceID,
            channelID: widget.channelID,
          )),
          Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(30)),
              margin: const EdgeInsets.only(left: 5, right: 5, bottom: 8),
              child: TextFormField(
                maxLines: 7,
                controller: msgController,
                minLines: 1,
                decoration: InputDecoration(
                  hintText: 'Type a message',
                  prefixIcon: const Icon(Icons.attach_file_sharp),
                  suffixIcon: GestureDetector(
                      onTap: handleMsg, child: const Icon(Icons.send_rounded)),
                  contentPadding: const EdgeInsets.all(15),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
