import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationForChatRequest extends StatelessWidget {
  const NotificationForChatRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1622838320000-4b3b3b3b3b3b"),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "John Doe",
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text("wants to text with you",
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        fontSize: 13,
                      ),
                    )),
              ],
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.done, color: Colors.blue),
            ),
            const SizedBox(width: 5),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.clear_outlined, color: Colors.red),
            ),
            const SizedBox(width: 10)
          ],
        ));
  }
}
