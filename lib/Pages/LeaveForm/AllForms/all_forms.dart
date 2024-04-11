import 'package:flutter/material.dart';
import 'package:the_dram_club/Pages/LeaveForm/AllForms/EachItem/form_item.dart';
import 'package:the_dram_club/Pages/LeaveForm/AllForms/form_controller.dart';

class AllForms extends StatefulWidget {
  final List allForms;
  const AllForms({super.key, required this.allForms});

  @override
  State<AllForms> createState() => _AllFormsState();
}

class _AllFormsState extends State<AllForms> {
  List list = [];

  void handledata() {
    setState(() {
      list = widget.allForms[0] + widget.allForms[1];
    });
  }

  @override
  void initState() {
    super.initState();
    handledata();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: widget.allForms[0].length == 0 && widget.allForms[1].length == 0
          ? const Text("No Forms")
          : FormController(
              lists: list,
            ),
    );
  }
}
