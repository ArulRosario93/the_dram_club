import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:vibration/vibration.dart';

class UserProfile extends StatelessWidget {
  final bool casualook;
  final String emailID;
  final String name;
  const UserProfile(
      {super.key,
      required this.casualook,
      required this.emailID,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(children: [
        Container(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () async {
              if (await Vibration.hasVibrator() ?? true) {
                Vibration.vibrate();
              }
              Navigator.pop(context);
            },
            child: const Icon(Icons.close),
          ),
        ),
        Row(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  'https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg'),
            ),
            const SizedBox(width: 10), //Spacing between the image and the text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold, fontSize: 10),
                ),
                Text(
                  emailID,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500, fontSize: 13),
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.only(top: 30, bottom: 30),
          child: CircularPercentIndicator(
            radius: 60.0,
            lineWidth: 12.0,
            percent: .7,
            center: Text(
              "70%",
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold, color: Colors.black),
            ),
            footer: Text(
              "Attendance Percentage",
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Colors.black),
            ),
            progressColor: Colors.blueGrey.shade900,
          ),
        ),
        // Text("Attendance", style: GoogleFonts.montserrat(fontSize: 12)),
        const SizedBox(height: 10),
        casualook
            ? Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 15),
                              child: Text(
                                "CA & Modal Marks",
                                style: GoogleFonts.montserrat(fontSize: 12),
                              ))),
                      const SizedBox(
                          width: 10), //Spacing between the two containers
                      Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 15),
                              child: Text(
                                "Semmeter Marks",
                                style: GoogleFonts.montserrat(fontSize: 12),
                              ))),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Request for Direct Message",
                      style: GoogleFonts.montserrat(fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      children: [
                        Text(
                          "This is a Stutus of tyhe user",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.montserrat(
                              fontSize: 12, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      children: [
                        Text(
                          "Create a workspace with Arul Rosario",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.montserrat(
                              fontSize: 12, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 15),
                              child: Text(
                                "CA & Modal Marks",
                                style: GoogleFonts.montserrat(fontSize: 12),
                              ))),
                      const SizedBox(
                          width: 10), //Spacing between the two containers
                      Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 15),
                              child: Text(
                                "Semmeter Marks",
                                style: GoogleFonts.montserrat(fontSize: 12),
                              ))),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Request for Direct Message",
                      style: GoogleFonts.montserrat(fontSize: 12),
                    ),
                  ),
                ],
              ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Text(
                "Report Arul Rosario",
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ]),
    );
  }
}
