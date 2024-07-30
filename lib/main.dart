import 'package:flutter/material.dart';
import 'package:attendance_management_system_app/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDz1zvgnN39kCTbupzUvnhMDmD7Rsr3MOs",
        authDomain: "attendance-management-sy-567e7.firebaseapp.com",
        databaseURL:
            "https://attendance-management-sy-567e7-default-rtdb.asia-southeast1.firebasedatabase.app",
        projectId: "attendance-management-sy-567e7",
        storageBucket: "attendance-management-sy-567e7.appspot.com",
        messagingSenderId: "317646090008",
        appId: "1:317646090008:web:0374a6a8a691588468786d",
        measurementId: "G-M9RRNS8LL2"),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}
