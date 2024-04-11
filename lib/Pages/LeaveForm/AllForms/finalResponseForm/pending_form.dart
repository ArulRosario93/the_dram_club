import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PendingForm extends StatelessWidget {
  final dynamic form;
  const PendingForm({super.key, required this.form});

  @override
  Widget build(BuildContext context) {
    void handleExpand() async {
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
                    color: Colors.yellow,
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
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: form?["Profile-Pic"] == null || form["Profile-Pic"] == "" 
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
                      "Applied ${form["type"]} on ${form["Time"]}",
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
                      "From: ${form["Start-Date"]} To: ${form["End-Date"]} ",
                      style: GoogleFonts.montserrat(
                          color: const Color.fromARGB(216, 255, 255, 255),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "Pending",
                          style: GoogleFonts.montserrat(
                              color: Colors.yellow,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    
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
                Icons.pending_actions,
                color: Colors.yellow,
              )
            ],
          ),
        ),
      ),
    );
  }
}
