import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble( this._message) ;

  final _message;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(12),
          ),
          width: 140,
          padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4   , horizontal: 8),
          child: Text(_message , style: TextStyle(color:Theme.of(context).accentTextTheme.headline1.color),),
        ),
      ],
    );
  }
}
