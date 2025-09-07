import 'package:bhetghat/pages/auth/login_page.dart';
import 'package:bhetghat/theme/dark_mode.dart';
import 'package:bhetghat/theme/light_mode.dart';
import 'package:flutter/material.dart';

void main() {
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
      home: LoginPage(),
    );
  }
}
