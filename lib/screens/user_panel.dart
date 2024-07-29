import 'package:attendance_management_system_app/screens/user_record_screen.dart';

import 'package:flutter/material.dart';
import 'package:attendance_management_system_app/widgets/attendance_radio_button.dart';

class UserPanel extends StatefulWidget {
  const UserPanel({super.key});

  @override
  State<UserPanel> createState() => _UserPanelState();
}

class _UserPanelState extends State<UserPanel> {
  AttendanceOptions? _character;
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
            const Text(
              "Today's Attendance:",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                // letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 20.0),
            AttendanceRadioButton(
              text: 'Mark Attendance',
              value: AttendanceOptions.markAttendance,
              currentValue: _character,
              changeValue: (value) {
                setState(() {
                  _character = value;
                });
              },
            ),
            AttendanceRadioButton(
              text: 'Mark Leave',
              value: AttendanceOptions.markLeave,
              currentValue: _character,
              changeValue: (value) {
                setState(() {
                  _character = value;
                });
              },
            ),
            const SizedBox(height: 10.0),
            // FilledButton.icon(
            //   onPressed: () {},
            //   label: Text('Submit'),
            //   icon: Icon(Icons.done),
            // ),
            FilledButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (builder) {
                      return AlertDialog(
                        title: const Text('Confirmation'),
                        content:
                            const Text("This can't be undone! Are you sure?"),
                        actions: [
                          TextButton(
                              onPressed: () {}, child: const Text('Yes')),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel')),
                        ],
                      );
                    });
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
