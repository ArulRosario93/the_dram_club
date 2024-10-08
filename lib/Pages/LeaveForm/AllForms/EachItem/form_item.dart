import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormItem extends StatelessWidget {
  final dynamic form;
  const FormItem({super.key, required this.form});

  @override
  Widget build(BuildContext context) {
    print(form["Attandance-Percentage"]);
    void handleExpand() async {

      Timestamp time = form["Time"];
      Timestamp startTime = form["Start-Date"];
      Timestamp endTime = form["End-Date"];

      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              insetPadding: const EdgeInsets.all(10),
              contentPadding: const EdgeInsets.all(20),
              backgroundColor: Colors.black87,
              title: Text(
                'Form ${form["Status"]}',
                style: GoogleFonts.montserrat(
                    color: form["Status"] == "Rejected"
                        ? Colors.red
                        : form["Status"] == "Pending"
                            ? Colors.yellow
                            : Colors.green,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: form["Profile-Pic"] != ""
                                ? DecorationImage(
                                    image: NetworkImage(form["Profile-Pic"]),
                                    fit: BoxFit.cover)
                                : null,
                          ),
                          child: form["Profile-Pic"] == ""
                              ? const Icon(Icons.person, color: Colors.black,)
                              : null,
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              form["Name"],
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            subtitle: Text(
                              form["Email-ID"],
                              style: GoogleFonts.montserrat(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text("Attendance Percentage: ",
                            style: GoogleFonts.montserrat(
                                color: Colors.green,
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                        Text("${form?["Attandance-Percentage"] ?? ""} ",
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                        Text(
                            form?["Attandance-Percentage"] == null
                                ? ""
                                : form["Attandance-Percentage"] > 75
                                    ? "(Eligible)"
                                    : "(Not Eligible)",
                            style: GoogleFonts.montserrat(
                                color: form?["Attandance-Percentage"] == null
                                    ? Colors.red
                                    : form["Attandance-Percentage"] > 75
                                        ? Colors.green
                                        : Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Applied ${form["type"]} on ${time.toDate().day} / ${time.toDate().month}",
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "For: ${form["Reason"]} ",
                      style: GoogleFonts.montserrat(
                          color: const Color.fromARGB(216, 255, 255, 255),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "From: ${startTime.toDate().day}/${startTime.toDate().month} To: ${endTime.toDate().day}/${endTime.toDate().month} ",
                      style: GoogleFonts.montserrat(
                          color: const Color.fromARGB(216, 255, 255, 255),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    // // form["Status"] == "Approved"? Row(
                    // //   children: [
                    // //     Text(
                    // //       "Approved by: ",
                    // //       style: GoogleFonts.montserrat(
                    // //           color: Colors.green,
                    // //           fontSize: 14,
                    // //           fontWeight: FontWeight.w600),
                    // //     ),
                    // //     Text("Arul Rosario ",
                    // //         style: GoogleFonts.montserrat(
                    // //             color: Colors.white,
                    // //             fontSize: 14,
                    // //             fontWeight: FontWeight.w400)),
                    // //     Expanded(
                    // //       child: Text("(Higher Authority)",
                    // //           style: GoogleFonts.montserrat(
                    // //               color: Colors.white70,
                    // //               fontSize: 14,
                    // //               fontWeight: FontWeight.w400)),
                    // //     )
                    // //   ],
                    // // ),
                    // // Row(
                    // //   children: [
                    // //     Text(
                    // //       "Rejected by: ",
                    // //       style: GoogleFonts.montserrat(
                    // //           color: Colors.red,
                    // //           fontSize: 14,
                    // //           fontWeight: FontWeight.w600),
                    // //     ),
                    // //     Text("Arul Rosario ",
                    // //         style: GoogleFonts.montserrat(
                    // //             color: Colors.white,
                    // //             fontSize: 14,
                    // //             fontWeight: FontWeight.w400)),
                    // //     Expanded(
                    // //       child: Text("(Higher Authority)",
                    // //           style: GoogleFonts.montserrat(
                    // //               color: Colors.white70,
                    // //               fontSize: 14,
                    // //               fontWeight: FontWeight.w400)),
                    // //     )
                    // //   ],
                    // // ),
                    // const SizedBox(height: 10),
                    // Text(
                    //   "Reason: Going to Hospital is not a valid reason.",
                    //   style: GoogleFonts.montserrat(
                    //       color: Colors.white,
                    //       fontSize: 14,
                    //       fontWeight: FontWeight.w400),
                    // ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Done',
                    style: GoogleFonts.montserrat(color: Colors.white),
                  ),
                ),
              ],
            );
          });
    }

    // return Text("Maja sojana");

    return Container(
      // duration: const Duration(milliseconds: 300),
      // padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(bottom: 20),
      // color: Colors.teal,

      alignment: Alignment.center,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: handleExpand,
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0, left: 10.0),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  // color: Colors.white,
                  shape: BoxShape.circle,
                  image: form["Profile-Pic"] != ""
                      ? DecorationImage(
                          image: NetworkImage(form["Profile-Pic"]),
                          fit: BoxFit.cover)
                      : null,
                ),
                child:
                    form["Profile-Pic"] == "" ? const Icon(Icons.person) : null,
              ),
              Expanded(
                child: ListTile(
                  title: Text(
                    form["Name"],
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    form["Reason"].substring(0, 20) + "...",
                    style: GoogleFonts.montserrat(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const Icon(
                Icons.rule,
                color: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }
}
