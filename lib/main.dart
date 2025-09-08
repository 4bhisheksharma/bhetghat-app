import 'package:bhetghat/controller/auth.dart';
import 'package:bhetghat/controller/login_or_register.dart';
import 'package:bhetghat/firebase_options.dart';
import 'package:bhetghat/theme/dark_mode.dart';
import 'package:bhetghat/theme/light_mode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BhetGhat',
      theme: lightModeTheme,
      darkTheme: darkModeTheme,
      home: AuthPage(),
    );
  }
}
