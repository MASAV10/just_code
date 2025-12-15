import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_code/sign_up_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignUpScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/goku.jpg', width: 150, height: 150),
            SizedBox(height: 10),
            CircularProgressIndicator(
              color: Colors.white12,
              semanticsLabel: 'Please wait when we setup the app',
            ),
          ],
        ),
      ),
    );
  }
}
