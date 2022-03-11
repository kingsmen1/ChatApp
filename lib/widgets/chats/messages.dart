import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt' , descending: true)
          .snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> ChatsnapShot) {
        if (ChatsnapShot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        //final document = ChatsnapShot.data.docs;
        return ListView.builder(
            reverse: true,
            itemCount: ChatsnapShot.data.docs.length,
            itemBuilder: (ctx, i) => Text(ChatsnapShot.data.docs[i]['text']));
      },
    );
  }
}
