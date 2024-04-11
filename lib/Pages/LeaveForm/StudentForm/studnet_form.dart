import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_dram_club/Auth_services/auth_services.dart';
import 'package:the_dram_club/Utils/get_info.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class StudentForm extends StatefulWidget {
  final String workspaceID;
  final String emailID;
  final String name;
  final String userDP;
  final int userAttandance;
  const StudentForm({
    super.key,
    required this.workspaceID,
    required this.emailID,
    required this.name,
    required this.userDP,
    required this.userAttandance,
  });

  @override
  State<StudentForm> createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final TextEditingController reason = TextEditingController();

  String groupValue = "";
  DateTime date = DateTime.now();
  bool showDate = false;
  PickerDateRange dateRange = PickerDateRange(DateTime.now(), DateTime.now());

  void onChanged(val) {
    setState(() {
      groupValue = val;
    });
  }

  void _showDatePickerDialog() {
    setState(() {
      showDate = !showDate;
    });
  }

  String reverseEndDate(String date) {
    //remove the zeros before date

    var dateList = date.split('-');
    // var year = dateList[0];
    var month = dateList[1];
    var day = dateList[2];

    // Remove leading zeros if present
    if (month.startsWith('0')) {
      month = month.substring(1);
    }
    if (day.startsWith('0')) {
      day = day.substring(1);
    }

    // Return the formatted date
    return '$day / $month';
  }

  void showSnackBar(String message, icon) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ));
  }

  void handleSubmitLeaveRequest() async {
    if (groupValue.isNotEmpty &&
        reason.text.isNotEmpty &&
        dateRange.startDate != null &&
        dateRange.endDate != null) {
      String res = await AuthServices().sendLeaveRequest(
          widget.workspaceID,
          widget.emailID,
          widget.name,
          reason.text.trim(),
          "${dateRange.startDate?.day.toString()} / ${dateRange.startDate?.month.toString()}",
          reverseEndDate(dateRange.endDate.toString().substring(0, 10)),
          groupValue,
          widget.userDP,
          widget.userAttandance);

      if (res == "Success") {
        reason.clear();
        setState(() {
          groupValue = "";
          dateRange = PickerDateRange(DateTime.now(), DateTime.now());
        });
        showSnackBar("Leave Request Sent", Icons.check);
      } else {
        showSnackBar("Failed to send Leave Request", Icons.error);
      }
    } else {
      showSnackBar("Fill all the fields", Icons.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text('Student Form', style: GoogleFonts.montserrat(fontSize: 22, fontWeight: FontWeight.w600),),
          // const SizedBox(height: 20, ),
          Text(
            "Type of Leave:",
            style: GoogleFonts.montserrat(
                fontSize: 16, fontWeight: FontWeight.w500),
          ),
          // GetInfo(controller: odOleave, hintText: "Reason", autoFocus: true, maxLines: false,),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Radio(
                        value: "OD",
                        groupValue: groupValue,
                        onChanged: onChanged),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      "OD",
                      style: GoogleFonts.montserrat(),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 30,
                ),
                Row(
                  children: [
                    Radio(
                        value: "Leave",
                        groupValue: groupValue,
                        onChanged: onChanged),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      "Leave",
                      style: GoogleFonts.montserrat(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Date: ",
                style: GoogleFonts.montserrat(
                    fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                width: 10,
              ),
              !showDate
                  ? InkWell(
                      onTap: _showDatePickerDialog,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Text(
                          "${dateRange.startDate?.day.toString()} / ${dateRange.startDate?.month.toString()} - ${dateRange.endDate.toString().length > 10 ? reverseEndDate(dateRange.endDate.toString().substring(0, 10)) : dateRange.startDate!.day.toString() + ' ' + dateRange.startDate!.month.toString()}",
                          style: GoogleFonts.montserrat(),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          showDate
              ? SizedBox(
                  // alignment: Alignment.center,
                  height: 500,
                  child: SfDateRangePicker(
                    maxDate: DateTime.now().add(const Duration(days: 90)),
                    showActionButtons: true,
                    backgroundColor: Colors.white,
                    enablePastDates: false,
                    selectionShape: DateRangePickerSelectionShape.circle,
                    selectionColor: Colors.blue.withOpacity(0.3),
                    startRangeSelectionColor: Colors.blue,
                    endRangeSelectionColor: Colors.blue,
                    rangeSelectionColor: Colors.blue.withOpacity(0.2),
                    headerStyle: DateRangePickerHeaderStyle(
                      backgroundColor: Colors.blue,
                      textStyle: GoogleFonts.montserrat(color: Colors.white),
                    ),
                    onSubmit: (p0) => setState(() {
                      // print(p0);
                      showDate = false;
                    }),
                    onCancel: () => setState(() {
                      showDate = false;
                    }),
                    onSelectionChanged:
                        (DateRangePickerSelectionChangedArgs args) {
                      setState(() {
                        dateRange = args.value;
                      });
                    },
                    selectionMode: DateRangePickerSelectionMode.range,
                    initialSelectedDate: date,
                  ),
                )
              : Container(),
          !showDate
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Reason for Leave:",
                      style: GoogleFonts.montserrat(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    GetInfo(
                      controller: reason,
                      hintText: "Reason",
                      autoFocus: true,
                      maxLines: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: handleSubmitLeaveRequest,
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [Colors.blue.shade600, Colors.blue],
                          ),
                        ),
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Text(
                          'Submit',
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
