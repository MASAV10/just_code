import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:just_code/home_screen.dart';
import 'package:just_code/sign_up_screen.dart';

class SplashServices {
  void isUserLoggedIn(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignUpScreen()),
      );
    }
  }
}
