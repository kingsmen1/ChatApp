import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemBuilder: (ctx, i) => const Text('this works!'),
        itemCount: 10,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/1toXWvHUAnaj3V2bEOYX/messages')
              .snapshots()
              .listen((data) { 
                data.docs.forEach((document) {
                  print(document['text']);
                });
          });
        },
      ),
    );
  }
}
