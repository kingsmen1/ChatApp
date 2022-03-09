import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(stream: FirebaseFirestore.instance
            .collection('chats/1toXWvHUAnaj3V2bEOYX/messages')
            .snapshots(),
          builder: (ctx, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);
            }
            final document = streamSnapshot.data.docs;
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemBuilder: (ctx, i) => Text(document[i]['text']),
              itemCount: document.length,
            );
          },),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            FirebaseFirestore.instance.collection('chats/1toXWvHUAnaj3V2bEOYX/messages').add(
                {'text':'This message was added by Button'});
          },
        ),
      ),
    );
  }
}
