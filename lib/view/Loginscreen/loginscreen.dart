
import 'package:flutter/material.dart';
import 'package:flutter_application_1_firebase/controller/loginscreen_controller.dart';
import 'package:flutter_application_1_firebase/view/registrationscreen.dart/registrationscreen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailkey = TextEditingController();
    TextEditingController passkey = TextEditingController();
    final _formkey = GlobalKey<FormState>();
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
                    "Sign in to Your Account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // email input fied
                TextFormField(
                  validator: (value) {
                    if (value != null &&
                        value.isNotEmpty &&
                        value.contains("@")) {
                      return null;
                    } else {
                      return "invalid email";
                    }
                  },
                  controller: emailkey,
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
                // password input field
                TextFormField(
                  validator: (value) {
                    if (value != null && value.length >= 6) {
                      return null;
                    } else {
                      return "enter password with atleast 6 charaters";
                    }
                  },
                  controller: passkey,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Icon(
                              Icons.check,
                              size: 10,
                            ),
                          ),
                        ),
                        Text(
                          "Remember me",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    Text(
                      "Forgot password",
                      style: TextStyle(
                        color: Color(0xff1a75d2),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      context.read<LoginscreenController>().onLogin(email: emailkey.text, pass: passkey.text, context: context);
                      
                      // if (emailkey.text == DummyDb.email1 &&
                      //     DummyDb.passwo == passkey.text) {
                      //   Navigator.pushAndRemoveUntil(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => HomeScreen(),
                      //     ),
                      //     (route) => false,
                      //   );
                      // } else {
                      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //       backgroundColor: Colors.red,
                      //       content: Text("Invalid credentials")));
                      // }
                    }
                    // Todo : write code  to navigate to home screen on successful Login with registered credentials
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xff1a75d2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Sign in",
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
                      "Don't have an account?",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          // Todo : write code  to navigate to registration screen
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Registrationscreen(),
                              ));
                        },
                        child: Text(
                          "Sign Up",
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
