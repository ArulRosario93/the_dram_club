import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationForChatResponse extends StatelessWidget {
  const NotificationForChatResponse({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1622838320000-4b3b3b3b3b3b"),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "John Doe accepted your request",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text("Go to chat",
                          style: GoogleFonts.montserrat(
                            textStyle:
                                const TextStyle(fontSize: 13, color: Colors.black),
                          )),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              
              alignment: Alignment.bottomRight,
              child: Text("05:12pm",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            fontSize: 12,
                            color: Colors.black
                          ),
                        )),
            ),
          ],
        ));
  }
}
