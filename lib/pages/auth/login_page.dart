import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          //logo image
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/bhetghat-logo.png',
              height: 200,
              width: 200,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),

            //
            Text(
              'B H E T G H A T',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w200),
            ),

            // text fields for email and password
            

            // forget password

            //sign in button

            //dont have an account? sign up
          ],
        ),
      ),
    );
  }
}
