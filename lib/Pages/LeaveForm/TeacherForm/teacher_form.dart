import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_dram_club/Pages/LeaveForm/TeacherForm/TeacherItem/teacher_item.dart';

class TeacherForm extends StatelessWidget {
  final List requests;
  final String userID;
  final String userName;
  final String roleName;
  final String workspaceID;
  const TeacherForm(
      {super.key,
      required this.requests,
      required this.userID,
      required this.userName,
      required this.roleName,
      required this.workspaceID});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Expanded(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: requests.isEmpty
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            requests.isEmpty
                ? Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "No Forms",
                        style: GoogleFonts.montserrat(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ],
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => TeacherItem(
                        form: requests[index],
                        userID: userID,
                        userName: userName,
                        roleName: roleName,
                        workspaceID: workspaceID),
                    itemCount: requests.length,
                  ),
          ],
        ),
      ))
    ]);
  }
}
