import 'package:attendance_management_system_app/screens/create_account_screen.dart';
import 'package:attendance_management_system_app/screens/user_panel.dart';
import 'package:attendance_management_system_app/utility/helper_functions.dart';
import 'package:attendance_management_system_app/widgets/email_input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController emailC;
  late String email, password;
  bool passHidden = true;

  void submitCredentials() {
    if (formKey.currentState!.validate()) {
      signIn(context);
    }
    // return null;
  }

  void signIn(BuildContext context) async {
    Widget activeScreen = const UserPanel();
    String errorMessage = 'An error occured';
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (builder) {
          return const PopScope(
              child: SpinKitFadingCube(
            color: Colors.white,
          ));
        });

    final isConnected = await checkInternetConnection(context);
    if (!isConnected) {
      return;
    }
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    email = emailC.text.trim();

    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      //     .then((userCredential) {
      //   if (userCredential.user == null) {
      //     return;
      //   }
      //   print(userCredential.user);
      //   formKey.currentState!.reset();
      // });

      if (user != null) {
        FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

        await firebaseFirestore
            .collection("admin")
            .where('email', isEqualTo: email)
            .get()
            .then(
          (querySnapshot) {
            if (querySnapshot.size == 1) {
              // means the email is present among the ADMIN list
              // activeScreen = const AdminPanel();
              // will switch to the admin panel when available
              activeScreen = const UserPanel();
            }
          },
          // onError: (e) => print("Error completing: $e"),
        );
      }
    } on FirebaseAuthException catch (error) {
      errorMessage = error.message.toString();
      if (error.code == 'user-not-found') {
        errorMessage = 'No user corresponding to given email.';
      }
      if (error.code == 'invalid-credential') {
        errorMessage = 'The credentials provided are incorrect.';
      }
      if (error.code == 'wrong-password') {
        errorMessage = 'The password entered is incorrect.';
      }

      // This error message is also necessary, because maybe the user is accessing someone else's email, hence account with their correct password.
      // In this case, the user will try to change their correct password but won't get a hint on whether, maybe take a look at the email address. As the password is only incorrect for other person account in this case, not specifically for the user own account.

      // if (error.code == 'wrong-password') {
      //   errorMessage = 'Either email or password entered is invalid';
      // }

      if (error.code == 'invalid-email') {
        errorMessage = 'The email entered is in invalid format.';
      }

      if (error.code == 'network-request-failed') {
        errorMessage = 'There is a problem with your internet connection.';
      }

      if (context.mounted) {
        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: ((context) {
            return AlertDialog(
              title: const Text('Sign In failed'),
              content: Text(errorMessage),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Okay'),
                ),
              ],
            );
          }),
        );
      }
      return;
    }

    // here means the TRY block was completed and no error was thrown, otherwise, return would terminate the function from there.
    // if (user != null) {
    formKey.currentState!.reset();
    SnackBar snackBar = const SnackBar(content: Text('Successfully Logged In'));

    if (context.mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return activeScreen;
      }));
    }
    // }
  }

  Widget get passwordInputWidget {
    return TextFormField(
      cursorColor: Colors.white,

      // controller: passwordC,
      validator: (value) {
        final returnValue = defaultUserInputValidator(value);
        if (returnValue == null) {
          password = value!;
          return returnValue;
        }

        return returnValue;
      },
      obscureText: passHidden,
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
          suffixIcon: IconButton(
            color: Colors.white.withOpacity(0.6),
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
              color: Colors.white,
            ),
          ),
          hintText: 'Type your password here'),
    );
  }

  @override
  void initState() {
    emailC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailC.dispose();
    super.dispose();
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
          preferredSize: Size.fromHeight(66),
          child: Center(
            heightFactor: 3,
            child: Text(
              'USER LOG IN',
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
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      boxShadow: const [
                        // shadows goes from bottom to top, center of the circle or shape to outwards
                        BoxShadow(color: Colors.white, blurRadius: 2),
                        // BoxShadow(color: Colors.red, blurRadius: 4),
                      ],
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
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 20.0),

                        // TextFormField modified widget class for user email input
                        EmailInputField(controller: emailC),
                        const SizedBox(height: 16.0),

                        // TextFormField Widget for user password input
                        passwordInputWidget,
                        const SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                  const SizedBox(height: 72),
                  TextButton(
                    onPressed: submitCredentials,
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.white12,
                        elevation: 1,
                        shadowColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        shape: const BeveledRectangleBorder()),
                    child: const Text(
                      'SIGN - IN',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.8,
                        fontWeight: FontWeight.bold,
                        wordSpacing: 4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 56),
                  const Divider(
                    color: Colors.white24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Not Registered yet? Create Account  ',
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
                              return const CreateAccountScreen();
                            }));
                          },
                          iconAlignment: IconAlignment.end,
                          style: TextButton.styleFrom(
                            alignment: Alignment.centerLeft,
                            backgroundColor: Colors.black54,
                            elevation: 1,
                            shadowColor: Colors.white30,
                            // padding: const EdgeInsets.only(left: 16),
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
            )),
      ),
    );
  }
}
