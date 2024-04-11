// import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatBot extends StatefulWidget {
  final List messages;
  final Function toClose;
  final Function bottomScroll;
  final Function(String msg) handleMsg;
  final ScrollController scroller;
  final bool boolval;
  const ChatBot(
      {super.key,
      required this.handleMsg,
      required this.messages,
      required this.toClose,
      required this.bottomScroll,
      required this.scroller,
      required this.boolval});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  TextEditingController _controller = TextEditingController();

  void handleMsg(String msg) {
    setState(() {
      widget.messages.add({'text': msg, 'isUser': true});
    });
    widget.handleMsg(msg);

    _controller.clear();
    widget.bottomScroll();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () => widget.toClose(),
              child: const Icon(Icons.close),
            )),
        Text(
          'ChatBot',
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600, color: Colors.black),
        ),
        Expanded(
            child: SingleChildScrollView(
          controller: widget.scroller,
          physics: const BouncingScrollPhysics(),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.messages.length,
            itemBuilder: (context, index) => Column(
              crossAxisAlignment: widget.messages[index]['isUser']
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: widget.messages[index]['isUser']
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7),
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: widget.messages[index]['isUser']
                          ? Colors.blue
                          : Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      widget.messages[index]['text'],
                      style: GoogleFonts.montserrat(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
        Container(
            // alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3)),
                ]),
            // height: 70,
            child: TextField(
              controller: _controller,
              maxLines: 3,
              minLines: 1,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 10),
                hintText: 'Ask Drammy anything',
                hintStyle: GoogleFonts.montserrat(color: Colors.black),
                suffixIcon: GestureDetector(
                  onTap: () => handleMsg(_controller.text),
                  child: const Icon(Icons.send),
                ),
                border: InputBorder.none,
              ),
            ))
      ],
    );
  }
}
