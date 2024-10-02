
import 'package:flutter/material.dart';
import 'package:flutter_application_1_firebase/controller/regiscteration_screen_controller.dart';
import 'package:flutter_application_1_firebase/view/Loginscreen/loginscreen.dart';
import 'package:provider/provider.dart';

class Registrationscreen extends StatelessWidget {
  const Registrationscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    TextEditingController pass1 = TextEditingController();
    TextEditingController pass2 = TextEditingController();
    TextEditingController email = TextEditingController();

     final providerobj = context.watch<RegiscterationScreenController>();
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    "Sign Up for Free",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: email,
                  validator: (value) {
                    if (value != null &&
                        value.isNotEmpty &&
                        value.contains("@")) {
                      return null;
                    } else {
                      return "invalid email";
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    hintText: "Your Eamil Address",
                    hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(0xff1a75d2),
                        )),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.red.shade400,
                        )),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: pass1,
                  validator: (value) {
                    if (value != null && value.length >= 6) {
                      return null;
                    } else {
                      return "enter password with atleast 6 charaters";
                    }
                  },
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      hintText: "Your Password",
                      hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Color(0xff1a75d2),
                          )),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.red.shade400,
                          )),
                      suffixIcon: Icon(
                        Icons.visibility_off_rounded,
                        color: Colors.grey,
                      )),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: pass2,
                  validator: (value) {
                    if (pass1.text == pass2.text) {
                      return null;
                    } else {
                      return "password doesnot match";
                    }
                  },
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      hintText: "Confirm Your Password",
                      hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Color(0xff1a75d2),
                          )),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.red.shade400,
                          )),
                      suffixIcon: Icon(
                        Icons.visibility_off_rounded,
                        color: Colors.grey,
                      )),
                ),
                SizedBox(height: 20),
                providerobj.isLoading ? CircularProgressIndicator()
                 :InkWell(
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                  providerobj.onRegister(email: email.text, pass: pass1.text, context: context);

                    }
                    
                    // Todo : write code  to navigate to login screen on successful registration
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xff1a75d2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          // Todo : write code  to navigate to Login screen
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ));
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Color(0xff1a75d2),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
 ));
}
}
