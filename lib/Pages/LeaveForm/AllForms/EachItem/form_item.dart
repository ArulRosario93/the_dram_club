import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormItem extends StatefulWidget {
  const FormItem({super.key});

  @override
  State<FormItem> createState() => _FormItemState();
}

class _FormItemState extends State<FormItem> {
  bool expanded = false;

  void handleExpand() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.all(10),
            contentPadding: const EdgeInsets.all(20),
            backgroundColor: Colors.black87,
            title: Text(
              'Form Rejected',
              style: GoogleFonts.montserrat(
                  color: Colors.red, fontSize: 22, fontWeight: FontWeight.w600),
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
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(
                            "Arul Rosario",
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            "itsarrowhere380@gmail.com",
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
                      Text("80% ",
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                      Text("(valid)",
                          style: GoogleFonts.montserrat(
                              color: Colors.green,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Applied OD on 20th August 2021",
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "For: Going to Hospital for Checkup. Then going to home. ",
                    style: GoogleFonts.montserrat(
                        color: const Color.fromARGB(216, 255, 255, 255),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Rejected by: ",
                        style: GoogleFonts.montserrat(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      Text("Arul Rosario ",
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400)),
                      Expanded(
                        child: Text("(Higher Authority)",
                            style: GoogleFonts.montserrat(
                                color: Colors.white70,
                                fontSize: 14,
                                fontWeight: FontWeight.w400)),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Reason: Going to Hospital is not a valid reason.",
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
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

  @override
  Widget build(BuildContext context) {
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
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: expanded ? 20 : 40,
                height: expanded ? 20 : 40,
                decoration: const BoxDecoration(
                    // color: Colors.white,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg'),
                        fit: BoxFit.cover)),
              ),
              Expanded(
                child: ListTile(
                  title: Text(
                    "Arul Rosario",
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    "Going to Hospital",
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
