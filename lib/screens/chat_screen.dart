import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemBuilder: (ctx, i) => const Text('this works!'),
        itemCount: 10,
      ),
    );
  }
}
