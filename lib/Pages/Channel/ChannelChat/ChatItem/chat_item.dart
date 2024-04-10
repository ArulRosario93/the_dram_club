import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_dram_club/Utils/user_profile.dart';

class ChatItem extends StatelessWidget {
  final bool sameUser;
  final bool sameTime;
  final bool samedate;
  final String msg;
  final String sender;
  final String date;
  final String time;
  final String userEmailID;
  const ChatItem(
      {super.key,
      required this.sameUser,
      required this.sameTime,
      required this.date,
      required this.samedate,
      required this.msg,
      required this.sender,
      required this.time,
      required this.userEmailID});

  @override
  Widget build(BuildContext context) {
    void handleUserProfile() {
      // showModalBottomSheet<void>(
      //   context: context,
      //   scrollControlDisabledMaxHeightRatio: .8,
      //   builder: (BuildContext context) {
      //     return Container(
      //       decoration: const BoxDecoration(
      //         color: Colors.white,
      //         borderRadius: BorderRadius.only(
      //           topLeft: Radius.circular(20),
      //           topRight: Radius.circular(20),
      //         ),
      //       ),
      //       padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      //       child: const UserProfile(),
      //     );
      //   },
      // );
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                insetPadding: const EdgeInsets.all(10),
                contentPadding: const EdgeInsets.all(10),
                backgroundColor: Colors.grey.shade200,
                // title: Text(
                //   'Form Rejected',
                //   style: GoogleFonts.montserrat(
                //       color: Colors.red,
                //       fontSize: 22,
                //       fontWeight: FontWeight.w600),
                // ),
                content: const UserProfile(
                  casualook: false,
                ),
              ));
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: sender == userEmailID
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        sender == userEmailID
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(top: 20, left: 5),
                child: GestureDetector(
                  onTap: handleUserProfile,
                  child: const CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.blue,
                    backgroundImage: NetworkImage(
                      "https://i.pinimg.com/236x/c7/e9/36/c7e9362f57ee015410dcf3dbb5f6178a.jpg",
                    ),
                  ),
                ),
              ),
        Column(
          crossAxisAlignment: sender == userEmailID
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            // !samedate? ChatDate(date: date): const SizedBox(),
            sender != userEmailID
                ? Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: GestureDetector(
                      onTap: handleUserProfile,
                      child: Text("Arul Rosario",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade100,
                            fontSize: 12,
                          )),
                    ),
                  )
                : const SizedBox(),
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              margin: EdgeInsets.only(
                right: 5,
                left: 5,
                top: !sameTime ? 3 : 0,
              ),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: sender == userEmailID
                    ? Colors.white
                    : Colors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                msg,
                style: GoogleFonts.montserrat(
                    color: sender == userEmailID
                        ? Colors.black
                        : Colors.white,
                    fontSize: 12),
              ),
            ),
            !sameTime
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      time,
                      style: GoogleFonts.montserrat(
                          color: Colors.grey, fontSize: 10),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ],
    );
  }
}
