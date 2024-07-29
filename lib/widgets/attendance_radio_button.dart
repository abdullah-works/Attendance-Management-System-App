import 'package:flutter/material.dart';

enum AttendanceOptions { markAttendance, markLeave }

class AttendanceRadioButton extends StatelessWidget {
  const AttendanceRadioButton({
    super.key,
    required this.text,
    required this.value,
    required this.currentValue,
    required this.changeValue,
  });

  final String text;
  final AttendanceOptions value;
  final AttendanceOptions? currentValue;
  final void Function(AttendanceOptions? value) changeValue;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          text,
          style: currentValue == value
              ? const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )
              : const TextStyle(fontSize: 16),
        ),
        leading: Radio<AttendanceOptions?>(
          value: value,
          groupValue: currentValue,
          onChanged: changeValue,
        ),
      ),
    );
  }
}
