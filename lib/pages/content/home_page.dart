import 'package:bhetghat/components/my_drawer.dart';
import 'package:bhetghat/components/my_list_tile.dart';
import 'package:bhetghat/components/my_post_button.dart';
import 'package:bhetghat/components/my_text_field.dart';
import 'package:bhetghat/database/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

          //posts
          StreamBuilder(
            stream: database.getPostsStream(),
            builder: (context, snapshot) {
              //show loading indicator
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              //get all posts
              final posts = snapshot.data!.docs;

              //check if data or not
              if (snapshot.data == null || posts.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Text("No Posts available, Post Something!"),
                  ),
                );
              }

              //return posts as list
              return Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    //get all ind. posts
                    final post = posts[index];

                    //get data from each post
                    String message = post['PostMessage'];
                    String userEmail = post['UserEmail'];
                    Timestamp timestamp = post['TimeStamp'];

                    //return as a tile list
                    return MyListTile(subTitle: userEmail, title: message, date: timestamp,);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
