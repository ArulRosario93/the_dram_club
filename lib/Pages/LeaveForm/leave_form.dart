import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_dram_club/Pages/LeaveForm/AllForms/all_forms.dart';
import 'package:the_dram_club/Pages/LeaveForm/StudentForm/studnet_form.dart';

class LeaveForm extends StatefulWidget {
  final int role;
  final int strict;

  const LeaveForm({super.key, required this.role, required this.strict});

  @override
  State<LeaveForm> createState() => _LeaveFormState();
}

class _LeaveFormState extends State<LeaveForm> {
  int _selectedIndex = 0;
  PageController _pageController = PageController(
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
      StudentForm(),

      //Student form or All Forms
      AllForms(),
    ];

    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 1,
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
                      child: InkWell(
                        onTap: () => handlePage(0),
                        child: Text(
                          "Student Form",
                          style: GoogleFonts.montserrat(
                              color: _selectedIndex == 0
                                  ? Colors.black
                                  : Colors.grey[700]!,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ))),
              Expanded(
                  flex: 1,
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
                      child: InkWell(
                        onTap: () => handlePage(1),
                        child: Text(
                          "All Forms",
                          style: GoogleFonts.montserrat(
                              color: _selectedIndex == 1
                                  ? Colors.black
                                  : Colors.grey[700]!,
                              fontSize: 18,
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
