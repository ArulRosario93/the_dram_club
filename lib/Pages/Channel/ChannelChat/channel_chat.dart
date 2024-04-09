import 'package:flutter/material.dart';
import 'package:the_dram_club/Pages/Channel/ChannelChat/ChatController/ChatControllerParent/chat_controller_parent.dart';
import 'package:the_dram_club/Pages/Channel/ChannelChat/ChatController/chat_controller.dart';

class Channelchat extends StatelessWidget {
  final data;
  final Function(String round) handleRound;
  final Function(String msg) handleMsg;
  const Channelchat({super.key, required this.data, required this.handleRound, required this.handleMsg});

  @override
  Widget build(BuildContext context) {
    final TextEditingController msgController = TextEditingController();

    return Container(
      color: Colors.red[100],
      child: Column(
        children: [
          Expanded(child: ChatControllerParent(data: data, handleRound: handleRound)),
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
                      onTap: handleMsg(msgController.text),
                      child: const Icon(Icons.send_rounded)),
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
