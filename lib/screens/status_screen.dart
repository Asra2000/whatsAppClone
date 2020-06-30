import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsappclone/services/appbar.dart';
import 'package:whatsappclone/services/chat_list.dart';

class StatusScreen extends StatefulWidget {
  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCreate(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ChatsList(
            name: 'My Status',
            text: 'Tap to add your status',
            isStatus: true,
            iscall: true,
            elevation: 0.0,
            url:
                'https://images.unsplash.com/photo-1549913772-820279f909b7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=600&q=60',
          ),
          SizedBox(height: 10.0,),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text('View Recent', style: TextStyle(fontSize: 18.0,), textAlign: TextAlign.left),
          ),
        ],
      ),
    );
  }
}
