import 'package:attendance_management_system_app/widgets/attendance_radio_button.dart';

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
