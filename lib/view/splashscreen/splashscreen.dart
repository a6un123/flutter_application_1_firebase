import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_application_1_firebase/view/intermedeatescreen/intermedeatescreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Intermediatescreen()));
    },);
    super.initState();
  }
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("splash screen",style: TextStyle(color: Color.fromARGB(255, 91, 222, 104)),),
      ),
    );
  }
}