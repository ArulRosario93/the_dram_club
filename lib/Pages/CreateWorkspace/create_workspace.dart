import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_dram_club/Pages/CreateWorkspace/form.dart';
import 'package:the_dram_club/Pages/CreateWorkspace/workspace_detail.dart';

class CreateWorkSpace extends StatefulWidget {
  const CreateWorkSpace({super.key});

  @override
  State<CreateWorkSpace> createState() => _CreateWorkSpaceState();
}

class _CreateWorkSpaceState extends State<CreateWorkSpace> {
  TextEditingController orgName = TextEditingController();
  TextEditingController orgDes = TextEditingController();

  int selectedIndex = 0;

  void gotonextPage() {
    setState(() {
      selectedIndex = 1;
    });
  }


  @override
  Widget build(BuildContext context) {
    List pages = [
      WorkspaceForm(
        orgName: orgName,
        orgDes: orgDes,
      ),
      const WorkspaceDetails(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      extendBody: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              pages[selectedIndex],
              //Submit is below
              Expanded(child: Container()),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.blue.shade400,
                      Colors.blue.shade600,
                    ]),
                    borderRadius: BorderRadius.circular(10)),
                child: GestureDetector(
                  onTap: gotonextPage,
                  child: Text(
                      selectedIndex == 0 ? "Create and Continue" : "Finish",
                      style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
