import 'package:attendance_management_system_app/models/attendance_model.dart';
import 'package:attendance_management_system_app/widgets/attendance_radio_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceValue {
  AttendanceValue(
      {required this.attendanceStatus, required this.attendanceDate});

  final AttendanceOptions attendanceStatus;
  final DateTime attendanceDate;
}

List<AttendanceValue> attendanceData = [
  AttendanceValue(
      attendanceStatus: AttendanceOptions.markAttendance,
      attendanceDate: DateTime.now()),
  AttendanceValue(
      attendanceStatus: AttendanceOptions.markLeave,
      attendanceDate: DateTime.now()),
  AttendanceValue(
      attendanceStatus: AttendanceOptions.markAttendance,
      attendanceDate: DateTime.now()),
  AttendanceValue(
      attendanceStatus: AttendanceOptions.markAttendance,
      attendanceDate: DateTime.now()),
  AttendanceValue(
      attendanceStatus: AttendanceOptions.markAttendance,
      attendanceDate: DateTime.now()),
  AttendanceValue(
      attendanceStatus: AttendanceOptions.markAttendance,
      attendanceDate: DateTime.now()),
  AttendanceValue(
      attendanceStatus: AttendanceOptions.markLeave,
      attendanceDate: DateTime.now()),
];

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
