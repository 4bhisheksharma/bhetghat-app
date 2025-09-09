import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final Timestamp date;
  const MyListTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(title),
          subtitle: Text(
            subTitle,

            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          trailing: Text(
            DateFormat('yyyy-MM-dd HH:mm').format(date.toDate()),
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
        ),
      ),
    );
  }
}
