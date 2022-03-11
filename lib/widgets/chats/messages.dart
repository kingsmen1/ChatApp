import 'package:chatapp/widgets/chats/message_bubble.dart';
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
        final document = ChatsnapShot.data.docs;
        //ListView.builder default takes full width
        return ListView.builder(
            reverse: true,
            itemCount: document.length,
            itemBuilder: (ctx, i) => MessageBubble(document[i]['text']));
      },
    );
  }
}
