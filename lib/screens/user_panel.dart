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
      backgroundColor: Colors.white60,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Student Attendance'),
        titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 235, 234, 234),
            ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              decoration: const BoxDecoration(
                color: Colors.green,
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
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              decoration: BoxDecoration(
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
                    (isAttendanceSubmitted) ? 'Done' : 'Not submitted',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 6),
                  if (isAttendanceSubmitted)
                    const Icon(
                      Icons.cloud_done,
                      color: Colors.white,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white38,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton(
                  dropdownColor: Colors.white,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: const Color.fromARGB(255, 8, 85, 148),
                      ),
                  underline: const SizedBox.shrink(),
                  hint: const Text('Choose Attendance Status'),
                  value: isAttendanceSubmitted
                      ? null
                      : selectedAttendance, // in order for the [disabledHint] to display, the [value] should also be null as well as [onChanged]
                  isExpanded: true,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  borderRadius: BorderRadius.circular(10),
                  disabledHint: Text(
                    '$selectedAttendance (submitted)',
                    style: const TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.bold),
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
            const SizedBox(height: 20.0),
            FilledButton(
              onPressed: () {
                if (isValueSelected == false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select a value for attendance.'),
                    ),
                  );
                  return;
                }
                showDialog(
                  context: context,
                  builder: (builder) {
                    return AlertDialog(
                      title: const Text('Confirmation'),
                      content:
                          const Text("This can't be undone! Are you sure?"),
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
              child: const Text('Submit'),
              // label: Text('Submit'),
              // icon: Icon(Icons.done),
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Your Attendance Record:",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                // letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const UserRecordScreen();
                }));
              },
              label: const Text('Show my record'),
              // icon: Icon(Icons.arrow_forward),
              icon: const Icon(Icons.navigate_next),
              iconAlignment: IconAlignment.end,
            ),
          ],
        ),
      ),
    );
  }
}
