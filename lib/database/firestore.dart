/*

this database stores posts, that user have posted in the Bhetghat app
It is stored in a collection called "Posts" in Firebase

where each of the post contains:
  a message
  email of user
  timestamp


*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase {
  User? user = FirebaseAuth.instance.currentUser;

  //get collection of posts from firebase db
  final CollectionReference posts = FirebaseFirestore.instance.collection(
    "Posts",
  );

  //post a message
  Future<void> addPost(String message) {
    return posts.add({
      "UserEmail": user!.email,
      'PostMessage': message,
      "TimeStamp": Timestamp.now(),
    });
  }

  //read posts from database
  Stream<QuerySnapshot> getPostsStream() {
    final postStream = FirebaseFirestore.instance
        .collection('Posts')
        .orderBy('TimeStamp', descending: true)
        .snapshots();

    return postStream;
  }
}
