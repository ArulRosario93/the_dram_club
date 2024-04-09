import 'package:flutter/material.dart';

class GetName extends StatelessWidget {
  final TextEditingController channelName;
  final TextEditingController channelDes;
  final Function()? handleNext;
  const GetName({super.key, required this.channelName, required this.channelDes, required this.handleNext});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          TextField(
            controller: channelName,
            decoration: const InputDecoration(hintText: "Channel Name"),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: channelDes,
            decoration: const InputDecoration(hintText: "Channel Description"),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: handleNext,
            child: const Text("Next"),
          )
        ],
      ),
    );
  }
}
