import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../services/database.dart';
import '../services/constants.dart';

class MessageScreen extends StatefulWidget {
  final String name;
  MessageScreen({this.name});
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  String messageText;
  TextEditingController controller;
  String chatRoomId;
  Map<String , String> messageMap;
  QuerySnapshot messages;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatRoomId  = getChatRoomId(widget.name, Constants.myName);
    getTexts();
  }
  String getChatRoomId(String a , String b){
    if(a.compareTo(b) > 0)
      return a+"_"+b;
    return b+"_"+a;
  }

  void getTexts()async{
    messages = await Database().getMessages(chatRoomId);
    print(messages);
  }
  void sendMessage(){
    messageMap = {
      'message': messageText,
      'sender' : Constants.myName
    };
    Database().getConversationMessages(chatRoomId, messageMap);
  }
  void messageStream() async {
    messages = await Database().getMessages(chatRoomId);
      for (var message in messages.documents) {
        print(message.data);
      }
  }

  @override
  Widget build(BuildContext context) {
//    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF075D55),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.lightBlueAccent,
                  radius: 20.0,
                ),
                SizedBox(
                  width: 12.0,
                ),
                Text(
                  widget.name,
//                    arguments['name']
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.add_call,
                  size: 30.0,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Icon(
                  Icons.videocam,
                  size: 30.0,
                )
              ],
            ),
          ],
        ),
      ),
      body: Container(
        color: Color(0xFFEBE4DC),
        child: Column(
          children: <Widget>[
            MessagesStream(chatRoomId: chatRoomId,),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey[100], width: 2.0),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: controller,
                        onChanged: (value) {
                          //Do something with the user input.
                          messageText = value;
                        },
                        decoration: InputDecoration(
                          filled:true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.insert_emoticon),
                          hintText: 'Enter a value',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey[300], width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey[300], width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: (){},
                              child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey,
                          )),
                          suffix: GestureDetector(
                            onTap: (){},
                              child: Icon(
                            Icons.attach_file,
                            color: Colors.grey,
                          )),
                        ),
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    backgroundColor: Color(0xFF43CE7B),
                    onPressed: () {
                        sendMessage();
                        controller.clear();
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MessagesStream extends StatelessWidget {
  final String chatRoomId;
  MessagesStream({this.chatRoomId});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('ChatRoom').document(chatRoomId).collection('chats').snapshots(),
        builder: (context, snapshot) {
          List<MessageBubble> messageBubbles = [];
          if (snapshot.hasData == false) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.pink,
              ),
            );
          }
          final messages = snapshot.data.documents.reversed;
          for (var message in messages) {
            final messageText = message.data['message'];
            final sender = message.data['sender'];

            final messageBubble = MessageBubble(
              text: messageText,
              sender: sender,
              isMe: Constants.myName == sender,
            );
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              children: messageBubbles,
            ),
          );
        });
  }
}

class MessageBubble extends StatelessWidget {
  final String text, sender;
  final bool isMe;

  MessageBubble({this.text, this.sender, this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$sender',
            style: TextStyle(color: Colors.black54, fontSize: 12.0),
          ),
          Material(
            elevation: 5.0,
            borderRadius: BorderRadius.only(
                topLeft: isMe ? Radius.circular(30.0) : Radius.circular(0.0),
                topRight: !isMe ? Radius.circular(30.0): Radius.circular(0.0),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0)),
            color: isMe ? Colors.green : Colors.white,
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                '$text',
                style: TextStyle(
                    fontSize: 15.0,
                    color: isMe ? Colors.white : Colors.black54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
