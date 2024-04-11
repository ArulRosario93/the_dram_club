import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:the_dram_club/Auth_services/auth_services.dart';

class Profile extends StatelessWidget {
  final String emailID;
  final String name;
  final String status;
  final int attandancePercentage;
  const Profile(
      {super.key,
      required this.emailID,
      required this.name,
      required this.status,
      required this.attandancePercentage});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nameController =
        TextEditingController(text: name);
    final TextEditingController _email = TextEditingController(text: emailID);
    final TextEditingController _status = TextEditingController(text: status);

    void handleName(String value) async {
      await AuthServices().changeUserName(emailID, name);
    }

    void handleStatus(String value) async {
      await AuthServices().changeUserStatus(emailID, status);
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        // color: Colors.grey.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        name[0] + name[1],
                        style: GoogleFonts.montserrat(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                    // const Positioned(
                    //     right: 0,
                    //     bottom: 0,
                    //     child: Icon(
                    //       Icons.edit,
                    //       color: Colors.black,
                    //     ))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Name:",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.montserrat(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: _nameController,
                      onChanged: handleName,
                      onSubmitted: handleName,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        hintStyle: GoogleFonts.montserrat(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Email-ID:",
                        style: GoogleFonts.montserrat(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: _email,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: 'Email-ID',
                        hintStyle: GoogleFonts.montserrat(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Status:",
                        style: GoogleFonts.montserrat(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: _status,
                      onChanged: handleStatus,
                      onSubmitted: handleStatus,
                      decoration: InputDecoration(
                        hintText: 'Status',
                        hintStyle: GoogleFonts.montserrat(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 30),
                  child: CircularPercentIndicator(
                    radius: 60.0,
                    lineWidth: 12.0,
                    percent: attandancePercentage / 100,
                    center: Text(
                      attandancePercentage.toString(),
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
                Column(
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
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    children: [
                      const Icon(Icons.logout, color: Colors.red),
                      const SizedBox(width: 10),
                      Text(
                        "Logout",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.montserrat(
                            fontSize: 12,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 80,
          )
        ],
      ),
    );
  }
}
