import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1_firebase/view/homescreen/homescreen.dart';

class LoginscreenController with ChangeNotifier {
  bool isLoading = false;
  onLogin(
      {required String email,
      required String pass,
      required BuildContext context}) async {
    isLoading = true;
    notifyListeners();
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      if (credential.user?.uid != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "User LoggedIn successfully",
              style: TextStyle(color: Colors.black),
            )));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Homescreen(),
            ));
      }
    } on FirebaseAuthException catch (e) {
      log(e.code.toString());
      if (e.code == 'invalid-credential') {
        print('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "No user found for that email.",
              style: TextStyle(color: Colors.white),
            )));
      }
      // else if (e.code == 'wrong-password') {
      //   print('Wrong password provided for that user.');
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //       backgroundColor: Colors.red,
      //       content: Text(
      //         "Wrong password provided for that user.",
      //         style: TextStyle(color: Colors.white),
      //       )));
      // }
    }
    isLoading = false;
    notifyListeners();
}
}
