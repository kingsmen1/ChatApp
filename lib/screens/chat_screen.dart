import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/chats/messages.dart';
import '../widgets/chats/new_message.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

/*void initState() {
  super.initState();
  final fbm = FirebaseMessaging.instance;
  fbm.requestPermission();
  FirebaseMessaging.onMessage.listen((message) {
    print(message);
    return;
  });
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    print(message);
    return;
  });
  fbm.subscribeToTopic('chat');
}*/

class _ChatScreenState extends State<ChatScreen> {

  @override
  void initState() {
    super.initState();
    final fbm = FirebaseMessaging.instance;
    fbm.requestPermission();
    FirebaseMessaging.onMessage.listen((message) {
      print('onMessage  ${message}');
      return;
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message);
      return;
    });
    fbm.subscribeToTopic('chat');
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('ChatApp'),
          actions: [
            DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Logout')
                      ],
                    ),
                  ),
                  value: 'logout',
                ),
              ],
              onChanged: (ItemIdentifier) {
                if (ItemIdentifier == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
            ),
          ],
        ),
        body: Container(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Expanded(child: Messages()), NewMessage()],
          ),
        ),
      ),
    );
  }
}
