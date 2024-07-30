import 'package:flutter/material.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  // TextEditingController fullNameC = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String fullName, email, password;
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
        title: const Text('Create Account'),
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
                          'My Details',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          // controller: fullNameC,
                          validator: (value) {
                            final returnValue = defaultValidator(value);
                            if (returnValue == null) {
                              fullName = value!;
                            }
                            return returnValue;
                          },
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Type your full name here',
                            label: Text(
                              'Name',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
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
                        const Text(
                          'Password - minimum 8 characters, should be a combination of (letters and numbers)',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          // controller: passwordC,
                          validator: (value) {
                            final returnValue = defaultValidator(value);
                            if (returnValue == null) {
                              final bool isPasswordValid = RegExp(
                                      r"^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d!@#$%&*]{8,}$")
                                  .hasMatch(value!);
                              if (isPasswordValid) {
                                password = value;
                                return returnValue;
                              }
                              return 'Please use the above criteria for password';
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
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // Storing valid credentials

                        showDialog(
                          context: context,
                          builder: ((context) {
                            return AlertDialog(
                              title: const Text('Success'),
                              // contentPadding: EdgeInsets.all(16),
                              content: const Text(
                                  'Account Created! Your information has been saved.'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      formKey.currentState!.reset();
                                    },
                                    child: const Text('Okay'))
                              ],
                            );
                          }),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 196, 177),
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        // enabledMouseCursor: MouseCursor.defer,
                        shape: const BeveledRectangleBorder()),
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already Registered? Log in'),
                      TextButton(
                        onPressed: () {},
                        iconAlignment: IconAlignment.end,
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.only(
                            left: 5,
                          ),
                          alignment: Alignment.centerLeft,
                          backgroundColor: Colors.transparent,
                        ),
                        child: Text('here'),
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
