import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/hp/AndroidStudioProjects/whatsapp_clone/lib/screens/constants.dart';
import 'package:whatsappclone/services/appbar.dart';

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
          ChatsList(name: 'Lucy Stuart', url: 'https://images.unsplash.com/photo-1568967729548-e3dbad3d37e0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=600&q=60',),
          ChatsList(name: 'Jenny Tailor', url:'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=600&q=60'),
        ],
      ),
    );
  }
}


class ChatsList extends StatelessWidget {

  final int count = 0;
  final String url, name;
  ChatsList({this.url, this.name});
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(url),
              radius: 30.0,
            ),
            SizedBox(width: 10.0,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('$name', style: appbarText.copyWith(color: Colors.black),),
                  Text('how are u?', style: TextStyle(fontSize: 15.0, color: Colors.black38),)
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text('11:45 AM', style: TextStyle(color: Color(0xFF43CE7B), fontSize: 12.0),),
                SizedBox(height: 5.0),
                Container(
                  child: Text('$count', style: TextStyle( color: Colors.white, fontSize: 15.0),
                  textAlign: TextAlign.center,),
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF43CE7B),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
