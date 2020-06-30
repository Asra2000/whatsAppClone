import 'package:firebase_auth/firebase_auth.dart';
import '../model/user.dart';

class Auth{
 final FirebaseAuth _auth = FirebaseAuth.instance;

 User _userFromFirebaseUser(FirebaseUser user) {
   return user != null ? User(id: user.uid) : null;
 }
//for sign in
 Future signInWithEmailAndPassword(String email, String password) async {
   try {
     AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
     FirebaseUser user = result.user;
     return _userFromFirebaseUser(user);
   }catch(e){
     print(e);
     return null;
   }
 }
// for sign up
  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
// to reset the password
  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}