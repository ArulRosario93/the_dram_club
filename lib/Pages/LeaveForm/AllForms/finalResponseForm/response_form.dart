import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class ResponseForm extends StatelessWidget {
  final dynamic form;
  const ResponseForm({super.key, required this.form});

  @override
  Widget build(BuildContext context) {
    print(form);

    void handleExpand() async {
      // Timestamp time = form["Time"];
      // Timestamp startTime = form["Start-Date"];
      // Timestamp endTime = form["End-Date"];

      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              insetPadding: const EdgeInsets.all(10),
              contentPadding: const EdgeInsets.all(20),
              backgroundColor: Colors.black87,
              title: Text(
                'Form ${form?["Response-Behavior"]}',
                style: GoogleFonts.montserrat(
                    color: form["Response-Behavior"] == "Rejected"
                        ? Colors.red
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
                            image: form?["Profile-Pic"] == null ||
                                    form?["Profile-Pic"] == ""
                                ? null
                                : DecorationImage(
                                    image: NetworkImage(form["Profile-Pic"]),
                                    fit: BoxFit.cover),
                          ),
                          child: form?["Profile-Pic"] == null ||
                                  form["Profile-Pic"] == ""
                              ? const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              form?["Name"],
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            subtitle: Text(
                              form?["Email-ID"],
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
                        Text("Attandance-Percentage: ",
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
                      "Applied ${form?["type"]} on ${form["userSubmittedtime"]}",
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "For: ${form?["Reason"]} ",
                      style: GoogleFonts.montserrat(
                          color: const Color.fromARGB(216, 255, 255, 255),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "From: ${form?["Start-Date"]} To: ${form?["End-Date"]} ",
                      style: GoogleFonts.montserrat(
                          color: const Color.fromARGB(216, 255, 255, 255),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    form?["Response-Behavior"] == "Approved"
                        ? Row(
                            children: [
                              Text(
                                "Approved by: ",
                                style: GoogleFonts.montserrat(
                                    color: Colors.green,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              Expanded(
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(0),
                                  // titleAlignment: ListTileTitleAlignment.,
                                  title: Text(form["Response-By"],
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                  subtitle: Text(form["Role"],
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white70,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                ),
                              )
                              // Text(form["Response-By"],
                              //     style: GoogleFonts.montserrat(
                              //         color: Colors.white,
                              //         fontSize: 14,
                              //         fontWeight: FontWeight.w400)),
                              // Expanded(
                              //   child: Text(form["Role"],
                              //       style: GoogleFonts.montserrat(
                              //           color: Colors.white70,
                              //           fontSize: 14,
                              //           fontWeight: FontWeight.w400)),
                              // )
                            ],
                          )
                        : Row(
                            children: [
                              Text(
                                "Rejected by: ",
                                style: GoogleFonts.montserrat(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              Expanded(
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(0),
                                  title: Text(form["Response-By"],
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                  subtitle: Text(form["Role"],
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white70,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                ),
                              )
                            ],
                          ),
                    const SizedBox(height: 10),
                    form["Status"] == "Note"
                        ? Text(
                            "With Note: ${form["Response"]}.",
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          )
                        : const SizedBox(),
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
                  image:
                      form?["Profile-Pic"] == null || form["Profile-Pic"] == ""
                          ? null
                          : DecorationImage(
                              image: NetworkImage(form["Profile-Pic"]),
                              fit: BoxFit.cover),
                ),
                child: form?["Profile-Pic"] == null || form["Profile-Pic"] == ""
                    ? const Icon(Icons.person)
                    : form?["Profile-Pic"] == ""
                        ? const SizedBox()
                        : null,
              ),
              Expanded(
                child: ListTile(
                  title: Text(
                    form?["Name"],
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    form?["Reason"].length > 30
                        ? form["Reason"].substring(0, 25) + "..."
                        : form?["Reason"],
                    style: GoogleFonts.montserrat(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              Icon(
                form["Response-Behavior"] == "Approved"
                    ? Icons.done
                    : Icons.close,
                color: form["Response-Behavior"] == "Approved"
                    ? Colors.green
                    : Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }
}
