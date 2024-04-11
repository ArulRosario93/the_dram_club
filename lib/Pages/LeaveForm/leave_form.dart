import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_dram_club/Pages/LeaveForm/AllForms/all_forms.dart';
import 'package:the_dram_club/Pages/LeaveForm/StudentForm/studnet_form.dart';
import 'package:the_dram_club/Pages/LeaveForm/TeacherForm/teacher_form.dart';

class LeaveForm extends StatefulWidget {
  final String role;
  final int strict;
  final List allForms;
  final String workspaceID;
  final String emailID;
  final String userName;
  final String userDP;
  final int userAttandance;
  final int roleInt;
  const LeaveForm(
      {super.key,
      required this.role,
      required this.strict,
      required this.workspaceID,
      required this.emailID,
      required this.userName,
      required this.allForms,
      required this.userDP,
      required this.userAttandance,
      required this.roleInt});

  @override
  State<LeaveForm> createState() => _LeaveFormState();
}

class _LeaveFormState extends State<LeaveForm> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  void handlePage(int val) {
    setState(() {
      _pageController.animateToPage(val,
          duration: Durations.short1, curve: Curves.easeIn);
      _selectedIndex = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> Pages = [
      // Student Form/ Teacher Form
      widget.roleInt == 0 || widget.roleInt == 1
          ? TeacherForm(
              requests: widget.allForms[0],
              userID: widget.emailID,
              userName: widget.userName,
              roleName: widget.role,
              workspaceID: widget.workspaceID)
          : StudentForm(
              workspaceID: widget.workspaceID,
              emailID: widget.emailID,
              name: widget.userName,
              userDP: widget.userDP,
              userAttandance: widget.userAttandance),

      //Student form or All Forms
      AllForms(
        allForms: widget.allForms,
      ),
    ];

    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () => handlePage(0),
                      child: Container(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(10),
                            // color: _selectedIndex == 0
                            //     ? Colors.grey[300]
                            //     : Colors.white,
                            border: Border(
                          bottom: BorderSide(
                              color: _selectedIndex == 0
                                  ? Colors.grey[700]!
                                  : Colors.white,
                              width: 2),
                        )),
                        alignment: Alignment.center,
                        child: Text(
                          widget.roleInt == 0 ? "Admin Forms" : "Student Form",
                          style: GoogleFonts.montserrat(
                              color: _selectedIndex == 0
                                  ? Colors.black
                                  : Colors.grey[700]!,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ))),
              Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () => handlePage(1),
                      child: Container(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(10),
                            // color: _selectedIndex == 1
                            //     ? Colors.grey[300]
                            //     : Colors.white,
                            border: Border(
                          bottom: BorderSide(
                              color: _selectedIndex == 1
                                  ? Colors.grey[700]!
                                  : Colors.white,
                              width: 2),
                        )),
                        alignment: Alignment.center,
                        child: Text(
                          "All Forms",
                          style: GoogleFonts.montserrat(
                              color: _selectedIndex == 1
                                  ? Colors.black
                                  : Colors.grey[700]!,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ))),
            ],
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: handlePage,
              children: Pages,
            ),
          ),
        ],
      ),
    );
  }
}
