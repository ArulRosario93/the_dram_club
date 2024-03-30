import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserItem extends StatelessWidget {
  const UserItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
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
              Text('User Name',
            style: GoogleFonts.montserrat(),),
              Text('User Email',
            style: GoogleFonts.montserrat(color: Colors.grey[500]),),
            ],
          ),
          Spacer(),
          Text(
            'Admin',
            style: GoogleFonts.montserrat(),
          )
        ],
      ),
    );
  }
}
