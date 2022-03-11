import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = "";
  var _controller = TextEditingController();

  void _sendMessage() {
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance
        .collection('chat')
        .add({'text': _enteredMessage, "createdAt": Timestamp.now()});
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _controller,
            decoration:
                InputDecoration(labelText: 'Please enter your Message here!'),
            onChanged: (value) {
              setState(() {
                _enteredMessage = value;
              });
            },
          )),
          IconButton(
              onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
              icon: Icon(
                Icons.send,
                //color: Theme.of(context).buttonColor,
              ))
        ],
      ),
    );
  }
}
