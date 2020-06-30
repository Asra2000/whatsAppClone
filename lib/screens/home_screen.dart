import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsappclone/services/appbar.dart';
import 'package:whatsappclone/services/chat_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCreate(),
      body: ListView(
        children: <Widget>[
          ChatsList(name: 'Lucy Stuart', text:'Hi there', elevation: 5.0,url: 'https://images.unsplash.com/photo-1568967729548-e3dbad3d37e0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=600&q=60',),
          ChatsList(name: 'Jenny Tailor',text:"Send me the number",  elevation: 5.0 ,url:'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=600&q=60'),
          ChatsList(name: 'James',text: 'Call back asap.', elevation: 5.0, url: 'https://images.unsplash.com/photo-1517530094915-500495b15ade?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=600&q=60'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.message),
        backgroundColor: Color(0xFF43CE7B),
      ),
    );
  }
}


