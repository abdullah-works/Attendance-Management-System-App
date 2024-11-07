import 'package:cloud_firestore/cloud_firestore.dart';

class Attendance {
  Attendance({
    this.userId,
    this.attendanceId,
    this.attendanceStatus,
    this.attendanceDate,
    this.isLeaveAccepted,
    this.leaveRequestText,
  });

  String? userId;
  String? attendanceId;
  String? attendanceStatus;
  Timestamp? attendanceDate;
  bool? isLeaveAccepted;
  String? leaveRequestText;

  String get formattedDate {
    final dividedDateList =
        attendanceDate!.toDate().toString().substring(0, 10).split('-');
    // 2024-10-15 20:30:... TO 2024-10-15 TO ['2024', '10', '15']
    final formatted = dividedDateList.reversed.join('-');
    // ['2024', '10', '15'] TO ['15', '10', '2024'] TO 15-10-2024

    return formatted;
  }

  Attendance.fromJSON(Map<String, dynamic> jsonAttendance) {
    userId = jsonAttendance['userId'];
    attendanceId = jsonAttendance['attendanceId'];
    attendanceDate = jsonAttendance['date'];
    attendanceStatus = jsonAttendance['attendanceStatus'];
    isLeaveAccepted = jsonAttendance['isLeaveAccepted'];
    leaveRequestText = jsonAttendance['leaveRequest'];
  }
}
