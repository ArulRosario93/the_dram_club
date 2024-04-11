import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_dram_club/Auth_services/auth_services.dart';
import 'package:the_dram_club/Pages/DirectMessages/MessageRoom/nested_room.dart';

class MessageRoom extends StatelessWidget {
  final String emailID;
  final String name;
  final String roomID;

  const MessageRoom(
      {super.key,
      required this.emailID,
      required this.name,
      required this.roomID});

  @override
  Widget build(BuildContext context) {
    final TextEditingController msgController = TextEditingController();

    void handleMsg(String val) async {
      String res = await AuthServices()
          .sendDirectMessage(emailID, name, roomID, msgController.text.trim());
      if (res == 'Success') {
        msgController.clear();
      } else {
        print(res);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        foregroundColor: Colors.white,
        toolbarHeight: 80.0,
        title: ListTile(
          contentPadding: const EdgeInsets.all(0.0),
          title: Text(
            name,
            style: GoogleFonts.montserrat(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          subtitle: Text(
            emailID,
            style: GoogleFonts.montserrat(
                fontSize: 16, fontWeight: FontWeight.w300, color: Colors.white),
          ),
        ),
      ),
      body: Column(children: [
        Expanded(
            child: StreamBuilder(
          stream: AuthServices().getDirectMessages(roomID),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data == null) {
              return const Center(
                child: Text("No data found"),
              );
            }

            final data = snapshot.data["Msg"];

            return ListView.builder(
              itemBuilder: (context, index) =>
                  NestedRoom(msg: data["Round${index + 1}"], userID: emailID),
              itemCount: data["currentRound"],
            );
          },
        )),
        Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.deepPurple[300],
                borderRadius: BorderRadius.circular(30)),
            margin: const EdgeInsets.only(left: 5, right: 5, bottom: 8),
            child: TextField(
              maxLines: 7,
              controller: msgController,
              minLines: 1,
              // onFieldSubmitted: handleMsg,
              decoration: InputDecoration(
                hintText: 'Type a message',
                hintStyle: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
                prefixIcon: const Icon(
                  Icons.attach_file_sharp,
                  color: Colors.white,
                ),
                suffixIcon: GestureDetector(
                    onTap: () => handleMsg(msgController.text),
                    child: const Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                    )),
                contentPadding: const EdgeInsets.all(15),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
            ))
      ]),
    );
  }
}
