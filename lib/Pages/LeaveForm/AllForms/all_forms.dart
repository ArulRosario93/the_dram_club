import 'package:flutter/material.dart';
import 'package:the_dram_club/Pages/LeaveForm/AllForms/EachItem/form_item.dart';

class AllForms extends StatelessWidget {
  const AllForms({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          FormItem(),
          Container(
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.only(bottom: 20),
            color: Colors.teal,
            alignment: Alignment.center,
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.only(bottom: 20),
            color: Colors.teal,
            alignment: Alignment.center,
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.only(bottom: 20),
            color: Colors.teal,
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}
