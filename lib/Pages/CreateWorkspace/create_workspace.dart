import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_dram_club/Auth_services/auth_services.dart';
import 'package:the_dram_club/Pages/CreateWorkspace/form.dart';
import 'package:the_dram_club/Pages/CreateWorkspace/workspace_detail.dart';
import 'package:the_dram_club/Pages/Home/home.dart';

class CreateWorkSpace extends StatefulWidget {
  final String emailID;
  final String userName;
  const CreateWorkSpace(
      {super.key, required this.emailID, required this.userName});

  @override
  State<CreateWorkSpace> createState() => _CreateWorkSpaceState();
}

class _CreateWorkSpaceState extends State<CreateWorkSpace> {
  TextEditingController orgName = TextEditingController();
  TextEditingController orgDes = TextEditingController();

  int selectedIndex = 0;
  int strict = 0;
  List roles = [];

  void gotonextPage() {
    setState(() {
      selectedIndex = 1;
    });
  }

  void handleStrict(int val) {
    setState(() {
      strict = val;
    });
  }

  void goHomePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  void handleShowErr(String res) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Sign in failed: $res",
          style: GoogleFonts.montserrat(),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void handleSubmit() async {
    // Create Workspace
    // print(orgName.text);
    // print(strict);
    // print(roles);
    String res = await AuthServices().createWorkspace(
        widget.userName, widget.emailID, orgName.text, strict, roles, "Admin", orgDes.text);

    if (res == "Success") {
      goHomePage();
    } else {
      // Error
      handleShowErr(res);
    }
  }

  @override
  Widget build(BuildContext context) {
    List pages = [
      WorkspaceForm(
        orgName: orgName,
        orgDes: orgDes,
      ),
      WorkspaceDetails(strict: handleStrict),
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
              GestureDetector(
                onTap: selectedIndex == 0 ? gotonextPage : handleSubmit,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.blue.shade400,
                        Colors.blue.shade600,
                      ]),
                      borderRadius: BorderRadius.circular(10)),
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
