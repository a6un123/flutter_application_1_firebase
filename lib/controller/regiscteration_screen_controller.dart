import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_firebase/view/Loginscreen/loginscreen.dart';

class RegiscterationScreenController with  ChangeNotifier {
 bool isLoading = false;
  onRegister({required String email,required String pass,required BuildContext context}) async {
    isLoading = true;
    notifyListeners();
   try {
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: pass,
  );
  if(credential.user?.uid !=null){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registerd")));
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
  }
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.blue,
      content: Text('The password provided is too weak.')));
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.blue,
      content: Text('The account already exists for that email.')));
  }
} catch (e) {
  print(e);
}
isLoading = false;
notifyListeners();
  }
  
}