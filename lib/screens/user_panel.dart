import 'package:flutter/material.dart';

enum AttendanceOptions { markAttendance, markLeave }

class UserPanel extends StatefulWidget {
  const UserPanel({super.key});

  @override
  State<UserPanel> createState() => _UserPanelState();
}

class _UserPanelState extends State<UserPanel> {
  AttendanceOptions? _character = AttendanceOptions.markLeave;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
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
            Card(
              child: ListTile(
                title: Text(
                  'Mark Attendance',
                  style: _character == AttendanceOptions.markAttendance
                      ? TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )
                      : TextStyle(
                          fontSize: 16,
                          // fontWeight: FontWeight.bold,
                        ),
                ),
                leading: Radio<AttendanceOptions?>(
                  value: AttendanceOptions.markAttendance,
                  groupValue: _character,
                  onChanged: (AttendanceOptions? value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
                // tileColor: Colors.blue,
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  'Mark Leave',
                  style: _character == AttendanceOptions.markAttendance
                      ? TextStyle(
                          fontSize: 16,
                          // fontWeight: FontWeight.bold,
                        )
                      : TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                ),
                leading: Radio<AttendanceOptions?>(
                  value: AttendanceOptions.markLeave,
                  groupValue: _character,
                  onChanged: (AttendanceOptions? value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
