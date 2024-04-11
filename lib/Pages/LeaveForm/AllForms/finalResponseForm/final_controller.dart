import 'package:flutter/material.dart';
import 'package:the_dram_club/Pages/LeaveForm/AllForms/finalResponseForm/pending_form.dart';
import 'package:the_dram_club/Pages/LeaveForm/AllForms/finalResponseForm/response_form.dart';

class FinalController extends StatelessWidget {
  final dynamic form;
  const FinalController({super.key, required this.form});

  @override
  Widget build(BuildContext context) {
    return form?["Status"] == null
        ? const Text("Loading")
        : form?["Status"] == "Pending"
            ? PendingForm(form: form)
            : ResponseForm(form: form);
  }
}
