import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_dram_club/Auth_services/auth_services.dart';
import 'package:the_dram_club/Pages/Home/home.dart';

class TeacherItem extends StatefulWidget {
  final dynamic form;
  final String workspaceID;
  final String userID;
  final String userName;
  final String roleName;
  const TeacherItem(
      {super.key,
      required this.form,
      required this.userID,
      required this.userName,
      required this.roleName,
      required this.workspaceID});

  @override
  State<TeacherItem> createState() => _TeacherItemState();
}

class _TeacherItemState extends State<TeacherItem> {
  bool expanded = false;
  String responseType = "Standard";
  TextEditingController note = TextEditingController();

  void showMessage(String res) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(res),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void gohome() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()));
  }

  void handleSubmit(String res) async {
    String time = widget.form["Time"];
    // Timestamp startTime = widget.form["Start-Date"];
    // Timestamp endTime = widget.form["End-Date"];

    String responsefromServer = await AuthServices().sendLeaveResponse(
      widget.workspaceID,
      widget.form["Email-ID"],
      widget.form["Name"],
      widget.form["Reason"],
      widget.form["type"],
      widget.form["Start-Date"],
      widget.form["End-Date"],
      widget.form["Request-ID"],
      responseType,
      widget.form["Attandance-Percentage"],
      time,
      widget.userID,
      widget.roleName,
      res,
      note.text.trim(),
      widget.form["Profile-Pic"],
    );

    if (responsefromServer == "Success") {
      showMessage("Response sent successfully");
      gohome();
    } else {
      showMessage(responsefromServer);
    }
  }

  void handleExpanded(String res) async {
    // String time = widget.form["Time"];
    // Timestamp startTime = widget.form["Start-Date"];
    // Timestamp endTime = widget.form["End-Date"];
    setState(() {
      expanded = !expanded;
      responseType = "Note";
    });

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.all(10),
            contentPadding: const EdgeInsets.all(20),
            backgroundColor: Colors.black87,
            title: Text(
              'Form',
              style: GoogleFonts.montserrat(
                  color: Colors.white,
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
                          image: widget.form["Profile-Pic"] != ""
                              ? DecorationImage(
                                  image:
                                      NetworkImage(widget.form["Profile-Pic"]),
                                  fit: BoxFit.cover)
                              : null,
                        ),
                        child: widget.form["Profile-Pic"] == ""
                            ? const Icon(
                                Icons.person,
                                color: Colors.white,
                              )
                            : null,
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(
                            widget.form["Name"],
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            widget.form["Email-ID"],
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
                      Text("${widget.form?["Attandance-Percentage"] ?? ""} ",
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                      Text(
                          widget.form?["Attandance-Percentage"] == null
                              ? ""
                              : widget.form["Attandance-Percentage"] > 75
                                  ? "(Eligible)"
                                  : "(Not Eligible)",
                          style: GoogleFonts.montserrat(
                              color: widget.form?["Attandance-Percentage"] ==
                                      null
                                  ? Colors.red
                                  : widget.form["Attandance-Percentage"] > 75
                                      ? Colors.green
                                      : Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Text(
                  //   "Applied ${widget.form["type"]} on ${time.toDate().day} / ${time.toDate().month}",
                  //   style: GoogleFonts.montserrat(
                  //       color: Colors.white,
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.w400),
                  // ),
                  const SizedBox(height: 10),
                  Text(
                    "For: ${widget.form["Reason"]} ",
                    style: GoogleFonts.montserrat(
                        color: const Color.fromARGB(216, 255, 255, 255),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "From: ${widget.form["Start-Date"]} To: ${widget.form["End-Date"]}",
                    style: GoogleFonts.montserrat(
                        color: const Color.fromARGB(216, 255, 255, 255),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  // form["Status"] == "Approved"? Row(
                  //   children: [
                  //     Text(
                  //       "Approved by: ",
                  //       style: GoogleFonts.montserrat(
                  //           color: Colors.green,
                  //           fontSize: 14,
                  //           fontWeight: FontWeight.w600),
                  //     ),
                  //     Text("Arul Rosario ",
                  //         style: GoogleFonts.montserrat(
                  //             color: Colors.white,
                  //             fontSize: 14,
                  //             fontWeight: FontWeight.w400)),
                  //     Expanded(
                  //       child: Text("(Higher Authority)",
                  //           style: GoogleFonts.montserrat(
                  //               color: Colors.white70,
                  //               fontSize: 14,
                  //               fontWeight: FontWeight.w400)),
                  //     )
                  //   ],
                  // ): form["Status"] == "Approved"?
                  // Row(
                  //   children: [
                  //     Text(
                  //       "Rejected by: ",
                  //       style: GoogleFonts.montserrat(
                  //           color: Colors.red,
                  //           fontSize: 14,
                  //           fontWeight: FontWeight.w600),
                  //     ),
                  //     Text("Arul Rosario ",
                  //         style: GoogleFonts.montserrat(
                  //             color: Colors.white,
                  //             fontSize: 14,
                  //             fontWeight: FontWeight.w400)),
                  //     Expanded(
                  //       child: Text("(Higher Authority)",
                  //           style: GoogleFonts.montserrat(
                  //               color: Colors.white70,
                  //               fontSize: 14,
                  //               fontWeight: FontWeight.w400)),
                  //     )
                  //   ],
                  // ): Row(
                  //   children: [
                  //     Text(
                  //       "Pending for Approval",
                  //       style: GoogleFonts.montserrat(
                  //           color: Colors.yellow,
                  //           fontSize: 14,
                  //           fontWeight: FontWeight.w600),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 10),
                  Text(
                    "Reason: ${widget.form["Reason"]} ",
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 20),
                  expanded
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Note: ",
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: note,
                              minLines: 1,
                              maxLines: 5,
                              style: GoogleFonts.montserrat(
                                  color: Colors.white, fontSize: 16),
                              decoration: InputDecoration(
                                hintText: "Enter your note here",
                                suffixIcon: GestureDetector(
                                  onTap: () => handleSubmit(res),
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                hintStyle: TextStyle(color: Colors.white70),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                  !expanded
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Reject',
                                style:
                                    GoogleFonts.montserrat(color: Colors.white),
                              ),
                            ),
                            TextButton(
                              onPressed: () => handleExpanded("Rejected"),
                              child: Text(
                                'Reject With Note',
                                style:
                                    GoogleFonts.montserrat(color: Colors.white),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Approve',
                                style:
                                    GoogleFonts.montserrat(color: Colors.white),
                              ),
                            ),
                            // TextButton(
                            //   onPressed: () => handleExpanded("Approved"),
                            //   child: Text(
                            //     'Approve With Note',
                            //     style:
                            //         GoogleFonts.montserrat(color: Colors.white),
                            //   ),
                            // ),
                          ],
                        )
                      : const SizedBox()
                ],
              ),
            ),
            // actions: [
            //   TextButton(
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //     child: Text(
            //       'Reject',
            //       style: GoogleFonts.montserrat(color: Colors.white),
            //     ),
            //   ),
            //   TextButton(
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //     child: Text(
            //       'Reject With Note',
            //       style: GoogleFonts.montserrat(color: Colors.white),
            //     ),
            //   ),
            //   TextButton(
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //     child: Text(
            //       'Approve',
            //       style: GoogleFonts.montserrat(color: Colors.white),
            //     ),
            //   ),
            // ],
          );
        });
  }

  void handleExpand() async {
    String time = widget.form["Time"];
    // String startTime = widget.form["Start-Date"];
    // String endTime = widget.form["End-Date"];

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.all(10),
            contentPadding: const EdgeInsets.all(20),
            backgroundColor: Colors.black87,
            title: Text(
              'Form',
              style: GoogleFonts.montserrat(
                  color: Colors.white,
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
                          image: widget.form["Profile-Pic"] != ""
                              ? DecorationImage(
                                  image:
                                      NetworkImage(widget.form["Profile-Pic"]),
                                  fit: BoxFit.cover)
                              : null,
                        ),
                        child: widget.form["Profile-Pic"] == ""
                            ? const Icon(
                                Icons.person,
                                color: Colors.white,
                              )
                            : null,
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(
                            widget.form["Name"],
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            widget.form["Email-ID"],
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
                      Text("${widget.form?["Attandance-Percentage"] ?? ""} ",
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                      Text(
                          widget.form?["Attandance-Percentage"] == null
                              ? ""
                              : widget.form["Attandance-Percentage"] > 75
                                  ? "(Eligible)"
                                  : "(Not Eligible)",
                          style: GoogleFonts.montserrat(
                              color: widget.form?["Attandance-Percentage"] ==
                                      null
                                  ? Colors.red
                                  : widget.form["Attandance-Percentage"] > 75
                                      ? Colors.green
                                      : Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Applied ${widget.form["type"]} on ${time}",
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "For: ${widget.form["Reason"]} ",
                    style: GoogleFonts.montserrat(
                        color: const Color.fromARGB(216, 255, 255, 255),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "From: ${widget.form["Start-Date"]} To: ${widget.form["end-Date"]} ",
                    style: GoogleFonts.montserrat(
                        color: const Color.fromARGB(216, 255, 255, 255),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  // form["Status"] == "Approved"? Row(
                  //   children: [
                  //     Text(
                  //       "Approved by: ",
                  //       style: GoogleFonts.montserrat(
                  //           color: Colors.green,
                  //           fontSize: 14,
                  //           fontWeight: FontWeight.w600),
                  //     ),
                  //     Text("Arul Rosario ",
                  //         style: GoogleFonts.montserrat(
                  //             color: Colors.white,
                  //             fontSize: 14,
                  //             fontWeight: FontWeight.w400)),
                  //     Expanded(
                  //       child: Text("(Higher Authority)",
                  //           style: GoogleFonts.montserrat(
                  //               color: Colors.white70,
                  //               fontSize: 14,
                  //               fontWeight: FontWeight.w400)),
                  //     )
                  //   ],
                  // ): form["Status"] == "Approved"?
                  // Row(
                  //   children: [
                  //     Text(
                  //       "Rejected by: ",
                  //       style: GoogleFonts.montserrat(
                  //           color: Colors.red,
                  //           fontSize: 14,
                  //           fontWeight: FontWeight.w600),
                  //     ),
                  //     Text("Arul Rosario ",
                  //         style: GoogleFonts.montserrat(
                  //             color: Colors.white,
                  //             fontSize: 14,
                  //             fontWeight: FontWeight.w400)),
                  //     Expanded(
                  //       child: Text("(Higher Authority)",
                  //           style: GoogleFonts.montserrat(
                  //               color: Colors.white70,
                  //               fontSize: 14,
                  //               fontWeight: FontWeight.w400)),
                  //     )
                  //   ],
                  // ): Row(
                  //   children: [
                  //     Text(
                  //       "Pending for Approval",
                  //       style: GoogleFonts.montserrat(
                  //           color: Colors.yellow,
                  //           fontSize: 14,
                  //           fontWeight: FontWeight.w600),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 10),
                  Text(
                    "Reason: ${widget.form["Reason"]} ",
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 20),
                  expanded
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Note: ",
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: note,
                              maxLines: 5,
                              decoration: const InputDecoration(
                                hintText: "Enter your note here",
                                prefixIcon: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                hintStyle: TextStyle(color: Colors.white70),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => handleSubmit("Rejected"),
                        child: Text(
                          'Reject',
                          style: GoogleFonts.montserrat(color: Colors.white),
                        ),
                      ),
                      TextButton(
                        onPressed: () => handleExpanded("Rejected"),
                        child: Text(
                          'Reject With Note',
                          style: GoogleFonts.montserrat(color: Colors.white),
                        ),
                      ),
                      TextButton(
                        onPressed: () => handleSubmit("Approved"),
                        child: Text(
                          'Approve',
                          style: GoogleFonts.montserrat(color: Colors.white),
                        ),
                      ),
                      // TextButton(
                      //   onPressed: () => handleExpanded("Approved"),
                      //   child: Text(
                      //     'Approve With Note',
                      //     style: GoogleFonts.montserrat(color: Colors.white),
                      //   ),
                      // ),
                    ],
                  )
                ],
              ),
            ),
            // actions: [
            //   TextButton(
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //     child: Text(
            //       'Reject',
            //       style: GoogleFonts.montserrat(color: Colors.white),
            //     ),
            //   ),
            //   TextButton(
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //     child: Text(
            //       'Reject With Note',
            //       style: GoogleFonts.montserrat(color: Colors.white),
            //     ),
            //   ),
            //   TextButton(
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //     child: Text(
            //       'Approve',
            //       style: GoogleFonts.montserrat(color: Colors.white),
            //     ),
            //   ),
            // ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.form["Attandance-Percentage"]);

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
                  image: widget.form["Profile-Pic"] != ""
                      ? DecorationImage(
                          image: NetworkImage(widget.form["Profile-Pic"]),
                          fit: BoxFit.cover)
                      : null,
                ),
                child: widget.form["Profile-Pic"] == ""
                    ? const Icon(Icons.person)
                    : null,
              ),
              Expanded(
                child: ListTile(
                  title: Text(
                    widget.form["Name"],
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    widget.form["Reason"].length > 40
                        ? widget.form["Reason"].substring(0, 40) + "..."
                        : widget.form["Reason"],
                    style: GoogleFonts.montserrat(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
