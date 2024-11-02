import 'package:attendance_management_system_app/utility/helper_functions.dart';
import 'package:flutter/material.dart';

class EmailInputField extends StatelessWidget {
  const EmailInputField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.white,
      validator: (value) {
        final returnValue = defaultUserInputValidator(value);

        if (returnValue == null) {
          final bool isEmailValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value!);
          if (isEmailValid) {
            return returnValue;
          }
          return 'Please enter a valid email';
        }
        return returnValue;
      },
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white.withOpacity(0.8),
      ),
      decoration: InputDecoration(
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.6),
        ),
        errorStyle: const TextStyle(
          color: Color.fromARGB(255, 255, 111, 102),
        ),
        hintText: 'Type your email address here',
        label: const Text(
          'Email Address',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
