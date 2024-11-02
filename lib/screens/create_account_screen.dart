import 'package:attendance_management_system_app/screens/login_screen.dart';
import 'package:attendance_management_system_app/screens/user_panel.dart';
import 'package:attendance_management_system_app/utility/helper_functions.dart';
import 'package:attendance_management_system_app/widgets/email_input_field.dart';
import 'package:attendance_management_system_app/widgets/password_input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController emailC;
  late TextEditingController passC;
  late String fullName, email, password;
  bool passHidden = true;

  void createUserAccount(BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (builder) {
          return const SpinKitFadingCircle(
            color: Colors.white,
          );
        });

    final isConnected = await checkInternetConnection(context);
    if (!isConnected) {
      return;
    }
    // Storing valid credentials
    try {
      FirebaseAuth auth = FirebaseAuth.instance;

      email = emailC.text.trim();
      password = passC.text;

      UserCredential userCredentials = await auth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredentials.user != null) {
        FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

        await firebaseFirestore
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set({
          'id': userCredentials.user!.uid,
          'name': fullName,
          'email': email,
          'password': password,
          'createdOn': DateTime.now(),
          'photo': null,
        });

        if (context.mounted) {
          Navigator.of(context).pop();
        }

        if (context.mounted) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: ((context) {
              return AlertDialog(
                title: const Text('Success'),
                content: const Text(
                    'Account Created! Your information has been saved.'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        formKey.currentState!.reset();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'Account created. Please Sign In to continue.')));
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                          return const LoginScreen();
                        }));
                      },
                      child: const Text('Okay'))
                ],
              );
            }),
          );
        }
      }
    } on FirebaseException catch (error) {
      // check other exceptions as well
      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: ${error.message}')));
      }
    }
  }

  @override
  void initState() {
    emailC = TextEditingController();
    passC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailC.dispose();
    passC.dispose();
    super.dispose();
  }

  Widget get nameInputWidget {
    return TextFormField(
      cursorColor: Colors.white,
      validator: (value) {
        final returnValue = defaultUserInputValidator(value);
        if (returnValue == null) {
          fullName = value!.trim();
        }
        return returnValue;
      },
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white.withOpacity(0.8),
      ),
      decoration: InputDecoration(
        errorStyle: const TextStyle(
          color: Color.fromARGB(255, 255, 111, 102),
        ),
        hintText: 'Type your full name here',
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.6),
        ),
        label: const Text(
          'Name',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.2),
        centerTitle: true,
        titleSpacing: 30,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(36),
          child: Center(
            heightFactor: 2,
            child: Text(
              'CREATE ACCOUNT',
              style: TextStyle(
                fontWeight: FontWeight.w100,
                color: Colors.white,
                fontSize: 24,
                letterSpacing: 2,
                wordSpacing: 4,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 24),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: const [
                          BoxShadow(color: Colors.white, blurRadius: 2)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'My Details',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 20.0),
                        nameInputWidget,
                        const SizedBox(height: 16.0),
                        EmailInputField(controller: emailC),
                        const SizedBox(height: 16.0),
                        Text(
                          'Password - minimum 8 characters, should be a combination of (letters & numbers)',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.white.withOpacity(0.8),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 16.0),
                        PasswordInputField(
                          controller: passC,
                          obscureText: passHidden,
                          switchObscure: () {
                            setState(() {
                              passHidden = !passHidden;
                            });
                          },
                        ),
                        const SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                  TextButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        createUserAccount(context);
                      }
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.white12,
                        elevation: 1,
                        shadowColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        shape: const BeveledRectangleBorder()),
                    child: const Text(
                      'SIGN - UP',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.8,
                        fontWeight: FontWeight.bold,
                        wordSpacing: 4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),
                  const Divider(
                    color: Colors.white24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already Registered? Log in  ',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 24,
                        child: TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context)
                                .clearMaterialBanners();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return const LoginScreen();
                            }));
                          },
                          iconAlignment: IconAlignment.end,
                          style: TextButton.styleFrom(
                            alignment: Alignment.centerLeft,
                            backgroundColor: Colors.black54,
                            elevation: 1,
                            shadowColor: Colors.white30,
                            // padding: EdgeInsets.only(left: 16)
                          ),
                          child: Text(
                            'here',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.white24,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
