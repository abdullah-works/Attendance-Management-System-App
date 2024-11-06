import 'dart:async';

import 'package:attendance_management_system_app/data/data_store.dart';
import 'package:attendance_management_system_app/widgets/attendance_radio_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UserRecordScreen extends StatelessWidget {
  const UserRecordScreen({super.key});

  Future<List<AttendanceValue>> getAttendanceData() async {
    await Future.delayed(const Duration(seconds: 3));
    return attendanceData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.80),
      appBar: AppBar(
        title: const Text('Attendance Record'),
        titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w200,
              color: const Color.fromARGB(255, 235, 234, 234),
              letterSpacing: 0.8,
            ),
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: getAttendanceData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final snapshotData = snapshot.data;
              return ListView.builder(
                  itemCount: snapshotData!.length,
                  itemBuilder: (context, index) {
                    final attendanceItem = attendanceData[index];
                    final attendance = attendanceItem.attendanceStatus;
                    return Card(
                      shadowColor: Colors.white,
                      elevation: 2,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: ListTile(
                        leading: Icon(
                          attendance == AttendanceOptions.markAttendance
                              ? Icons.done
                              : Icons.cancel,
                          color: Colors.white70,
                        ),
                        title: attendance == AttendanceOptions.markAttendance
                            ? const Text('PRESENT')
                            : const Text('LEAVE'),
                        trailing: Text(attendanceItem.attendanceDate
                            .toString()
                            .substring(0, 10)),
                        leadingAndTrailingTextStyle:
                            Theme.of(context).textTheme.labelSmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                        tileColor:
                            attendance == AttendanceOptions.markAttendance
                                ? Colors.green.shade600
                                : Colors.red.shade700,
                        titleTextStyle:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                  letterSpacing: 0.8,
                                ),
                      ),
                    );
                  });
            } else {
              return const Center(
                child: SpinKitFadingCircle(
                  color: Colors.white,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
