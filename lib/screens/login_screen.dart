import 'dart:js_interop';

import 'package:attendance_management_system_app/screens/create_account_screen.dart';
import 'package:attendance_management_system_app/screens/user/user_attendance_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String email, password;
  bool passHidden = true;

  String? defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please provide the requested credentials';
    }
    if (value.trim().isEmpty) {
      return 'Only Whitespaces are not accepted';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Log In'),
        titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 235, 234, 234),
            ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Your Credentails',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          // controller: emailC,
                          validator: (value) {
                            final returnValue = defaultValidator(value);

                            if (returnValue == null) {
                              final bool isEmailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value!);
                              if (isEmailValid) {
                                email = value;
                                return returnValue;
                              }
                              return 'Please enter a valid email';
                            }
                            return returnValue;
                          },
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Type your email address here',
                            label: Text(
                              'Email Address',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          // controller: passwordC,
                          validator: (value) {
                            final returnValue = defaultValidator(value);
                            if (returnValue == null) {
                              password = value!;
                              return returnValue;
                            }

                            return returnValue;
                          },
                          obscureText: passHidden,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    passHidden = !passHidden;
                                  });
                                },
                                icon: (passHidden)
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                              ),
                              label: const Text(
                                'Password',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              hintText: 'Type your password here'),
                        ),
                        const SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          FirebaseAuth auth = FirebaseAuth.instance;
                          // UserCredential userCredentials =
                          await auth.signInWithEmailAndPassword(
                              email: email, password: password);
                          formKey.currentState!.reset();

                          SnackBar snackBar = const SnackBar(
                              content: Text('Successfully Logged In'));
                          if (context.mounted) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);

                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return const UserAttendanceScreen();
                              // return const AdminPanel();
                            }));
                          }
                        } on FirebaseAuthException catch (error) {
                          if (error.code == 'user-not-found') {
                            SnackBar snackBar = const SnackBar(
                                content: Text(
                                    'No user corresponding to given email'));
                            if (context.mounted) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                            return;
                          }
                          if (error.code == 'wrong-password' ||
                              error.code == 'invalid-credential') {
                            SnackBar snackBar = const SnackBar(
                                content: Text(
                                    'Either email or password entered is invalid'));
                            if (context.mounted) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                            return;
                          }
                          SnackBar snackBar =
                              SnackBar(content: Text(error.code));
                          if (context.mounted) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }

                          // showDialog(
                          //   context: context,
                          //   builder: ((context) {
                          //     return AlertDialog(
                          // title: const Text('Success'),
                          // // contentPadding: EdgeInsets.all(16),
                          // content: const Text(
                          //     'Account Logged In.'),
                          // actions: [
                          //   TextButton(
                          //       onPressed: () {
                          //         Navigator.pop(context);
                          //         formKey.currentState!.reset();
                          //       },
                          //       child: const Text('Okay'))
                          // ],
                          //         );
                          //   }),
                          // );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 196, 177),
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        // enabledMouseCursor: MouseCursor.defer,
                        shape: const BeveledRectangleBorder()),
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Not Registered yet? Create Account'),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return const CreateAccountScreen();
                          }));
                        },
                        iconAlignment: IconAlignment.end,
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.only(
                            left: 5,
                          ),
                          alignment: Alignment.centerLeft,
                          backgroundColor: Colors.transparent,
                        ),
                        child: const Text('here'),
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
