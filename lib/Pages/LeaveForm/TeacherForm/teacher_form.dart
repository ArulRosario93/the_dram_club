import 'package:flutter/material.dart';
import 'package:the_dram_club/Pages/LeaveForm/AllForms/EachItem/form_item.dart';

class TeacherForm extends StatelessWidget {
  const TeacherForm({super.key});

  @override
  Widget build(BuildContext context) {
    

    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(children: [
        FormItem(),
        FormItem(),
        FormItem(),
      ]),
    );
  }
}
