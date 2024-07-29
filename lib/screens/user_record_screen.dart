import 'dart:async';

import 'package:attendance_management_system_app/data/data_store.dart';
import 'package:attendance_management_system_app/widgets/attendance_radio_button.dart';
import 'package:flutter/material.dart';

class UserRecordScreen extends StatelessWidget {
  const UserRecordScreen({super.key});

  Future<List<AttendanceValue>> getAttendanceData() async {
    await Future.delayed(const Duration(seconds: 3));
    return attendanceData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Record'),
        titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 235, 234, 234),
            ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: getAttendanceData(),
          builder: (context, snapshot) {
            // just for fun - for now, will change later when data is dynamic
            if (snapshot.hasData) {
              final snapshotData = snapshot.data;
              return ListView.builder(
                  itemCount: snapshotData!.length,
                  itemBuilder: (context, index) {
                    final attendanceItem = attendanceData[index];
                    final attendance = attendanceItem.attendanceStatus;
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      // surfaceTintColor: Colors.blue,
                      child: ListTile(
                        leading: const Icon(Icons.person),
                        title: attendance == AttendanceOptions.markAttendance
                            ? const Text('Present')
                            : const Text('On Leave'),
                        subtitle: Text(attendanceItem.attendanceDate
                            .toString()
                            .substring(0, 10)),
                        subtitleTextStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                        tileColor:
                            attendance == AttendanceOptions.markAttendance
                                ? Colors.green.shade300
                                : Colors.red.shade300,
                      ),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
