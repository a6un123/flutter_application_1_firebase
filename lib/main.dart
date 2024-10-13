import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_firebase/controller/loginscreen_controller.dart';
import 'package:flutter_application_1_firebase/controller/regiscteration_screen_controller.dart';
import 'package:flutter_application_1_firebase/firebase_options.dart';
import 'package:flutter_application_1_firebase/view/splashscreen/splashscreen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RegiscterationScreenController(),),
        ChangeNotifierProvider(create: (context) => LoginscreenController(),)
      ],
      child: MaterialApp(
        home: Splashscreen(),
      ),
    );
  }
}