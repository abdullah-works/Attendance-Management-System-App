import 'package:attendance_management_system_app/models/attendance_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

List<Attendance> userAttendanceList = [
  Attendance(
    attendanceStatus: 'Present',
    attendanceDate: Timestamp.fromDate(DateTime.now()),

  ),
  Attendance(
    attendanceStatus: 'Absent',
    attendanceDate: Timestamp.fromDate(DateTime.now()),
    
  ),Attendance(
    attendanceStatus: 'Present',
    attendanceDate: Timestamp.fromDate(DateTime.now()),
    
  ),Attendance(
    attendanceStatus: 'Present',
    attendanceDate: Timestamp.fromDate(DateTime.now()),
    
  ),Attendance(
    attendanceStatus: 'Absent',
    attendanceDate: Timestamp.fromDate(DateTime.now()),
    
  ),Attendance(
    attendanceStatus: 'Present',
    attendanceDate: Timestamp.fromDate(DateTime.now()),
    
  ),Attendance(
    attendanceStatus: 'Absent',
    attendanceDate: Timestamp.fromDate(DateTime.now()),
    
  ),Attendance(
    attendanceStatus: 'Present',
    attendanceDate: Timestamp.fromDate(DateTime.now()),
    
  ),Attendance(
    attendanceStatus: 'Present',
    attendanceDate: Timestamp.fromDate(DateTime.now()),
    
  ),Attendance(
    attendanceStatus: 'Present',
    attendanceDate: Timestamp.fromDate(DateTime.now()),
    
  ),Attendance(
    attendanceStatus: 'Absent',
    attendanceDate: Timestamp.fromDate(DateTime.now()),
    
  ),
];
