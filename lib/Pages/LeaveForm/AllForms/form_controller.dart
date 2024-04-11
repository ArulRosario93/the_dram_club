import 'package:flutter/material.dart';
import 'package:the_dram_club/Pages/LeaveForm/AllForms/finalResponseForm/final_controller.dart';
import 'package:the_dram_club/Pages/LeaveForm/AllForms/finalResponseForm/response_form.dart';

class FormController extends StatelessWidget {
  final List lists;
  const FormController(
      {super.key, required this.lists});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // give the list of requests and responses to the form item according to time
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: lists.length,
                  itemBuilder: (context, index) {
                      return FinalController(form: lists[index]);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
