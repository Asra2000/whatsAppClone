import 'package:flutter/material.dart';
import 'package:whatsappclone/services/constants.dart';
import '../screens/message_screen.dart';
import '../services/database.dart';

class ChatsList extends StatelessWidget {
  final double elevation;
  final int count = 1;
  final String url, name;
  bool iscall;
  bool isStatus;
  final String text;
  ChatsList({this.url, this.name, this.text , this.elevation, this.iscall=false, this.isStatus=false});

  String getChatRoomId(String a , String b){
    print('reached here');
    if(a.compareTo(b) > 0)
      return a+"_"+b;
    return b+"_"+a;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(!iscall && !isStatus) {
          String chatRoomId = getChatRoomId(name, Constants.myName);
          //    print(chatRoomId);
          List<String> users = [name, Constants.myName];
          Map<String, dynamic> chatRoomMap = {
            "users" : users,
            "chatRoomId" : chatRoomId,
          };

          Database().createChatRoom(chatRoomId, chatRoomMap);
          Navigator.push(context, MaterialPageRoute(builder: (context) => MessageScreen(name: name,)));
        }
        },
      child: Material(
        elevation: elevation,
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
                    if (text!=null)
                    Text(text, style: TextStyle(fontSize: 15.0, color: Colors.black38),)
                  ],
                ),
              ),
              !iscall ?
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
              ) : (!isStatus)?
              Column(
                children: <Widget>[
                  Icon(Icons.videocam, size: 40.0,),
                ],
              ) : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
