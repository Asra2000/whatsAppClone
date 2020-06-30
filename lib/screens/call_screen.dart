import 'package:flutter/material.dart';
import '../services/appbar.dart';
import '../services/chat_list.dart';

class CallScreen extends StatefulWidget {
  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCreate(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ChatsList(
            name: 'Lily Stuart',
            elevation: 0.0,
            iscall : true,
            url:
            'https://images.unsplash.com/photo-1568967729548-e3dbad3d37e0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=600&q=60'
          ),
          SizedBox(height: 10.0,),
        ],
      ),
    );
  }
}
