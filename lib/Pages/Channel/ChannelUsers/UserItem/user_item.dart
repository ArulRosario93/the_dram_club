import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_dram_club/Utils/user_profile.dart';
import 'package:vibration/vibration.dart';

class UserItem extends StatelessWidget {
  const UserItem({super.key});

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
                content: const UserProfile(casualook: true,),
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
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                content: Text(
                    'Are you sure you want to promote Arul Rosario to Admin?', style: GoogleFonts.montserrat()),
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
                child: const UserProfile(casualook: true,)),
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
                const CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      'https://media.istockphoto.com/id/1146517111/photo/taj-mahal-mausoleum-in-agra.jpg?s=612x612&w=0&k=20&c=vcIjhwUrNyjoKbGbAQ5sOcEzDUgOfCsm9ySmJ8gNeRk='),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User Name',
                      style: GoogleFonts.montserrat(),
                    ),
                    Text(
                      'User Email',
                      style: GoogleFonts.montserrat(color: Colors.grey[500]),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              'Admin',
              style: GoogleFonts.montserrat(),
            )
          ],
        ),
      ),
    );
  }
}
