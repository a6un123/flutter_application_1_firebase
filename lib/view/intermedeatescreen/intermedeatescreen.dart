import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1_firebase/view/Loginscreen/loginscreen.dart';
import 'package:flutter_application_1_firebase/view/homescreen/homescreen.dart';

class Intermediatescreen extends StatelessWidget {
  const Intermediatescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance
          .authStateChanges(), //stream continously fetching data
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Homescreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
