import 'package:bhetghat/components/my_button.dart';
import 'package:bhetghat/components/my_text_field.dart';
import 'package:bhetghat/helper/helper_funtions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text controller
  final TextEditingController usernamecontroller = TextEditingController();

  final TextEditingController emailcontroller = TextEditingController();

  final TextEditingController passwordcontroller = TextEditingController();

  final TextEditingController confirmpasswordcontroller =
      TextEditingController();

  //register method
  Future<void> registerUser() async {
    //show loading progress indicator
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    // to check password is matched or not
    if (passwordcontroller.text != confirmpasswordcontroller.text) {
      //pop the loading circle
      Navigator.pop(context);

      //show error message
      displayMessageToUser("Password don't match", context);
    } else {
      //try to create the user
      try {
        //creating user
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailcontroller.text,
              password: passwordcontroller.text,
            );

        //create a user doc and add to firebase db
        createUserDocument(userCredential);

        //pop the loading circle
        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        //pop the loading circle
        Navigator.pop(context);

        //show error message
        displayMessageToUser(e.message!, context);
      }
    }
  }

  //create method to collect user data into firebase
  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
            'email': userCredential.user!.email,
            'username': usernamecontroller.text,
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: SingleChildScrollView(
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
                // text fields for username, email and password
                MyTextField(
                  hintText: "Username",
                  obscureText: false,
                  controller: usernamecontroller,
                ),
                const SizedBox(height: 15),
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
                MyTextField(
                  hintText: "Confirm Password",
                  obscureText: true,
                  controller: confirmpasswordcontroller,
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
                MyButton(text: "Register", onTap: registerUser),

                SizedBox(height: 15),

                //dont have an account? sign up
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Already have an account?',

                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        ' Sign In',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
