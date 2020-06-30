
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  Future<QuerySnapshot> getUsesByUserName(String username){
    return Firestore.instance.collection('users').where('name', isEqualTo: username).getDocuments();
  }
  createChatRoom(String chatRoomId, chatRoomMap){
    Firestore.instance.collection('ChatRoom').document(chatRoomId).setData(chatRoomMap).catchError((e){
      print(e.toString());
    });
  }
  void addNewUser(Map user) {
    print(user);
    Firestore.instance.collection('users').add(user).catchError((e) {
      print(e);
    });
  }

  getConversationMessages(String chatRoomId, Map messageMap){
    Firestore.instance.collection('ChatRoom').document(chatRoomId).collection('chats').add(messageMap).catchError((e){
      print(e);
    });
  }
 Future<QuerySnapshot> getMessages(String chatRoomId){
   return Firestore.instance.collection('ChatRoom').where('chatRoomId', isEqualTo: chatRoomId).getDocuments();
  }
}
