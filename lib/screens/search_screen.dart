import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatsappclone/screens/message_screen.dart';
import 'package:whatsappclone/services/database.dart';
import '../services/constants.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();
  String name;
  QuerySnapshot user;

  chatRoomCreation(String username){
//    final _auth = FirebaseAuth.instance;
//    FirebaseUser currentUser = await _auth.currentUser();
//    print(currentUser.email);
//    print(Constants.myName);
    String chatRoomId = getChatRoomId(username, Constants.myName);
//    print(chatRoomId);
    List<String> users = [username, Constants.myName];
    Map<String, dynamic> chatRoomMap = {
      "users" : users,
      "chatRoomId" : chatRoomId,
    };

   Database().createChatRoom(chatRoomId, chatRoomMap);
   print(username);
    Navigator.push(context, MaterialPageRoute(builder: (context) => MessageScreen(name: username,)));
//    Navigator.pushNamed(context, '/message', arguments: {'name': username});
  }

  String getChatRoomId(String a , String b){
    print('reached here');
    if(a.compareTo(b) > 0)
      return a+"_"+b;
    return b+"_"+a;
  }

  Widget showResult() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: user.documents.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Text(user.documents[index].data['name'], style: TextStyle(fontSize: 16.0),),
                Spacer(),
                RaisedButton(
                  onPressed: (){
                    print('here');
                  chatRoomCreation(user.documents[index].data['name']);
                  },
                  child: Text(
                    'Message',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.green,
                )
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Type here',
                      filled: true,
                      fillColor: Colors.white24,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: ()async{
                    await Database()
                        .getUsesByUserName(controller.text)
                        .then((value) {
                        setState(() {
                        user = value;
                      });
                    });
//                    controller.clear();
                  },
                  child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFFc8ffbf),
                            const Color(0xFF8ffa7d),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                      child: Icon(Icons.search)),
                ),
              ],
            ),
            user != null && user.documents.length != 0  ? showResult() : Container(),
          ],
        ),
      ),
    );
  }
}
