import 'package:attendance_management_system_app/screens/user_record_screen.dart';

import 'package:flutter/material.dart';

class UserPanel extends StatefulWidget {
  const UserPanel({super.key});

  @override
  State<UserPanel> createState() => _UserPanelState();
}

class _UserPanelState extends State<UserPanel> {
  String? selectedAttendance;
  bool isValueSelected = false;
  bool isAttendanceSubmitted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.80),
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('Student Attendance'),
        centerTitle: true,
        titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w200,
              color: const Color.fromARGB(255, 235, 234, 234),
              letterSpacing: 0.8,
            ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              decoration: const BoxDecoration(
                color: Colors.black54,
                border: Border.symmetric(
                  vertical: BorderSide(color: Colors.white),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: const Text(
                'Attendance for today',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: const Border.symmetric(
                  vertical: BorderSide(color: Colors.white),
                ),
                color:
                    (isAttendanceSubmitted) ? Colors.blue : Colors.red.shade700,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    (isAttendanceSubmitted)
                        ? 'submitted successfully'
                        : 'not submitted',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    (isAttendanceSubmitted)
                        ? Icons.assignment_turned_in
                        : Icons.assignment_late,
                    color: Colors.white,
                    size: 16,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32.0),
            Container(
              decoration: BoxDecoration(
                // color: Colors.green.shade400,
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton(
                  dropdownColor: Colors.green,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                  underline: const SizedBox.shrink(),
                  hint: const Text(
                    'Choose Attendance Status',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  value: isAttendanceSubmitted
                      ? null
                      : selectedAttendance, // in order for the [disabledHint] to display, the [value] should also be null as well as [onChanged]
                  isExpanded: true,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  borderRadius: BorderRadius.circular(10),
                  disabledHint: Text(
                    '$selectedAttendance - Submitted',
                    style: const TextStyle(color: Colors.white),
                  ),
                  onChanged: (isAttendanceSubmitted)
                      ? null
                      : (String? value) {
                          setState(() {
                            if (value == null) {
                              return;
                            }
                            selectedAttendance = value;
                            isValueSelected = true;
                          });
                        },
                  items: [
                    'Present',
                    'Absent',
                    'Leave',
                  ].map(
                    (String attendanceItem) {
                      return DropdownMenuItem(
                        value: attendanceItem,
                        child: Text(attendanceItem),
                      );
                    },
                  ).toList()),
            ),
            const SizedBox(height: 32.0),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      if (isValueSelected == false) {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please choose any attendance status to submit',
                            ),
                          ),
                        );
                        return;
                      }
                      showDialog(
                        context: context,
                        builder: (builder) {
                          return AlertDialog(
                            title: const Text('Confirmation'),
                            content: const Text(
                                "This can't be undone! Are you sure?"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    setState(() {
                                      isAttendanceSubmitted = true;
                                    });
                                  },
                                  child: const Text('Yes')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel')),
                            ],
                          );
                        },
                      );
                    },
                    style: FilledButton.styleFrom(
                      visualDensity: VisualDensity.comfortable,
                      backgroundColor: Colors.green,
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 0.8,
                      ),
                    ),
                    child: const Text('Submit'),
                    // label: Text('Submit'),
                    // icon: Icon(Icons.done),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            const Divider(
              height: 2,
              color: Colors.white60,
            ),
            const SizedBox(height: 20.0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.black54,
                border: const Border.symmetric(
                  vertical: BorderSide(color: Colors.white),
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Previous Attendance Record',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const UserRecordScreen();
                    }));
                  },
                  label: const Text('show my record'),
                  icon: const Icon(Icons.navigate_next),
                  iconAlignment: IconAlignment.end,
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
