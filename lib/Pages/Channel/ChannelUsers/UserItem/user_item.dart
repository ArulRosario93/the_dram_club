import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_dram_club/Utils/user_profile.dart';
import 'package:vibration/vibration.dart';

class UserItem extends StatelessWidget {
  final String emailID;
  final String username;
  const UserItem({super.key, required this.emailID, required this.username});

  @override
  Widget build(BuildContext context) {
    void handleDialog() {
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
                content: UserProfile(
                  casualook: true,
                  emailID: emailID,
                  name: username,
                ),
              ));
    }

    void handlepromoteUser() {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                insetPadding: const EdgeInsets.all(10),
                contentPadding: const EdgeInsets.all(10),
                backgroundColor: Colors.grey.shade200,
                title: Text(
                  'Promote Arul Rosario?',
                  style: GoogleFonts.montserrat(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                content: Text(
                    'Are you sure you want to promote Arul Rosario to Admin?',
                    style: GoogleFonts.montserrat()),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Promote'),
                  ),
                ],
              ));
    }

    void handleBottomSheet() async {
      // Vibrate the device if it has a vibrator
      if (await Vibration.hasVibrator() ?? true) {
        Vibration.vibrate();
      }

      showModalBottomSheet<void>(
        context: context,
        scrollControlDisabledMaxHeightRatio: .8,
        builder: (BuildContext context) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 7,
              child: UserProfile(
                casualook: true,
                emailID: emailID,
                name: username,
              ),
            ),
          );
        },
      );
    }

    return GestureDetector(
      onTap: handleDialog,
      onLongPress: handleBottomSheet,
      onDoubleTap: handlepromoteUser,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    // color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    username[0] + username[1],
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: GoogleFonts.montserrat(),
                    ),
                    Text(
                      emailID,
                      style: GoogleFonts.montserrat(color: Colors.grey[500]),
                    ),
                  ],
                ),
              ],
            ),
            // Text(
            //   'Admin',
            //   style: GoogleFonts.montserrat(),
            // )
          ],
        ),
      ),
    );
  }
}
