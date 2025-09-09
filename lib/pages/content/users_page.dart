import 'package:bhetghat/components/my_back_button.dart';
import 'package:bhetghat/helper/helper_funtions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, snapshot) {
          // error state
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Something went wrong",
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }

          // loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // no data
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No Users Available",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            );
          }

          // data exists
          final users = snapshot.data!.docs;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // back button
              Padding(
                padding: const EdgeInsets.only(top: 60, left: 20, bottom: 10),
                child: Row(children: const [MyBackButton()]),
              ),

              // title
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "All Users",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 10),

              // user list
              Expanded(
                child: ListView.separated(
                  itemCount: users.length,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  separatorBuilder: (context, index) => const Divider(
                    height: 1,
                    thickness: 0.3,
                    color: Colors.grey,
                  ),
                  itemBuilder: (context, index) {
                    final user = users[index];
                    final username = user['username'] ?? "Unknown";
                    final email = user['email'] ?? "No email";

                    return ListTile(
                      leading: CircleAvatar(
                        radius: 22,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.primaryContainer,
                        child: Text(
                          username.isNotEmpty ? username[0].toUpperCase() : "?",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        username,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        email,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                      onTap: () {
                        // TODO: open profile or chat
                        displayMessageToUser("Tapped on $username", context);
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
