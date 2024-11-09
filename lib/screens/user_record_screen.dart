import 'dart:async';

import 'package:attendance_management_system_app/data/data_store.dart';
import 'package:attendance_management_system_app/models/attendance_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UserRecordScreen extends StatelessWidget {
  const UserRecordScreen({super.key});

  Future<List<Attendance>> getAttendanceData() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    return userAttendanceList;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.80),
      appBar: AppBar(
        leading: IconButton.outlined(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_rounded)),
        title: const Text('Attendance Record'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
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
                    final attendanceItem = snapshotData[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      shadowColor: Colors.white,
                      elevation: 2,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: ListTile(
                        minTileHeight: height * 0.06,
                        minVerticalPadding: 4,
                        leading: Icon(
                          attendanceItem.attendanceStatus == 'Present'
                              ? Icons.done
                              : Icons.cancel,
                          size: height * 0.025,
                          color: Colors.white70,
                        ),
                        title: Text(
                          attendanceItem.attendanceStatus!,
                        ),
                        trailing: Text(
                          attendanceItem.formattedDate,
                        ),
                        leadingAndTrailingTextStyle:
                            Theme.of(context).textTheme.labelSmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: width * 0.025,
                                ),
                        tileColor: attendanceItem.attendanceStatus == 'Present'
                            ? Colors.green.shade600
                            : Colors.red.shade700,
                        titleTextStyle:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                  letterSpacing: 0.8,
                                  // fontSize: aspectRatio * 20,
                                  fontSize: width * 0.03,
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
