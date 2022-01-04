import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/screens/home.dart';
import 'package:test_app/screens/login.dart';
import 'package:test_app/screens/signup.dart';
import 'package:test_app/screens/constant.dart';
import 'package:test_app/screens/splashScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp();
  runApp(MyApp());
  }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Login",
      routes: <String, WidgetBuilder>{
        SPLASH_SCREEN: (BuildContext context) => SplashScreen(),
        LOGIN: (BuildContext context) => Login(),
        SIGNUP: (BuildContext context) => signUp(),
        HOME: (BuildContext context) => home(),
      },
      initialRoute: SPLASH_SCREEN,
    );
  }
}
