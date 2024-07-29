import 'dart:async';

import 'package:attendance_management_system_app/screens/user_panel.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return const UserPanel();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(
              size: 88,
              style: FlutterLogoStyle.stacked,
              textColor: Colors.white,
              // curve: Curves.linear,
            ),
            SizedBox(height: 48),
            LinearProgressIndicator(),
          ],
        ),
      ),
    );
  }
}