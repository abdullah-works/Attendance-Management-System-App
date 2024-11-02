import 'package:attendance_management_system_app/utility/helper_functions.dart';
import 'package:flutter/material.dart';

class PasswordInputField extends StatelessWidget {
  const PasswordInputField({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.switchObscure,
  });

  final TextEditingController controller;
  final bool obscureText;
  final void Function() switchObscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.white,
      controller: controller,
      validator: (value) {
        final returnValue = defaultUserInputValidator(value);
        if (returnValue == null) {
          final bool isPasswordValid =
              RegExp(r"^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d!@#$%&*]{8,}$")
                  .hasMatch(value!);
          if (isPasswordValid) {
            return returnValue;
          }
          return 'Please use the above criteria for password';
        }
        return returnValue;
      },
      obscureText: obscureText,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white.withOpacity(0.8),
      ),
      decoration: InputDecoration(
          errorStyle: const TextStyle(
            color: Color.fromARGB(255, 255, 111, 102),
          ),
          suffixIcon: IconButton(
            onPressed: switchObscure,
            color: Colors.white.withOpacity(0.6),
            icon: (obscureText)
                ? const Icon(Icons.visibility_off)
                : const Icon(Icons.visibility),
          ),
          label: const Text(
            'Password',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          hintText: 'Type your password here',
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.6),
          )),
    );
  }
}
