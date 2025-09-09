import 'package:bhetghat/components/my_drawer.dart';
import 'package:bhetghat/components/my_post_button.dart';
import 'package:bhetghat/components/my_text_field.dart';
import 'package:bhetghat/database/firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  //firestore access
  final FirestoreDatabase database = FirestoreDatabase();

  //text controller
  final TextEditingController newPostController = TextEditingController();

  //method to post message
  void postMessage() {
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }

    //clear the text controller
    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BhetGhat - Feed"),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),

      drawer: MyDrawer(),
      body: Column(
        children: [
          //text field for user to type something...
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                //text field
                Expanded(
                  child: MyTextField(
                    hintText: "Say Something...",
                    obscureText: false,
                    controller: newPostController,
                  ),
                ),
                //post button
                MyPostButton(onTap: postMessage),
              ],
            ),
          ),

          //
        ],
      ),
    );
  }
}
