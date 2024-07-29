import 'package:attendance_management_system_app/data/data_store.dart';
import 'package:attendance_management_system_app/widgets/attendance_radio_button.dart';
import 'package:flutter/material.dart';

class UserRecordScreen extends StatelessWidget {
  const UserRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Record'),
        titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 235, 234, 234),
            ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
            itemCount: attendanceData.length,
            itemBuilder: (context, index) {
              final attendanceItem = attendanceData[index];
              final attendance = attendanceItem.attendanceStatus;
              return Card(
                clipBehavior: Clip.antiAlias,
                // surfaceTintColor: Colors.blue,
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: attendance == AttendanceOptions.markAttendance
                      ? Text('Present')
                      : Text('On Leave'),
                  subtitle: Text(attendanceItem.attendanceDate
                      .toString()
                      .substring(0, 10)),
                  tileColor: attendance == AttendanceOptions.markAttendance
                      ? Colors.green.shade300
                      : Colors.red.shade300,
                ),
              );
            }),
      ),
    );
  }
}
