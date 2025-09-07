import 'package:bhetghat/components/my_text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  //text controller
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
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

              const SizedBox(height: 25),
              // text fields for email and password
              MyTextField(
                hintText: "Email",
                obscureText: false,
                controller: emailcontroller,
              ),
              const SizedBox(height: 15),
              MyTextField(
                hintText: "Password",
                obscureText: true,
                controller: passwordcontroller,
              ),

              const SizedBox(height: 15),

              // forget password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 25),

              //sign in button

              //dont have an account? sign up
            ],
          ),
        ),
      ),
    );
  }
}
