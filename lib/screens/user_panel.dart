import 'package:flutter/cupertino.dart';
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
        title: Text('Student Attendance'),
        titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 235, 234, 234),
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
          ],
        ),
      ),
    );
  }
}
