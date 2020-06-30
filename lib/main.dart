import 'package:flutter/material.dart';
import 'package:whatsappclone/screens/home_screen.dart';
import 'package:whatsappclone/screens/login_screen.dart';
import 'package:whatsappclone/screens/search_screen.dart';
import 'package:whatsappclone/screens/status_screen.dart';
import 'package:whatsappclone/screens/call_screen.dart';
import 'screens/message_screen.dart';
import 'services/helperfunctions.dart';
void main() async{
  runApp(MyApp());
}

class MyApp extends StatefulWidget{

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn  = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    getIsLoggedIn();
  }
  void getIsLoggedIn ()  async{
    bool value = await Helper.getUserLoggedInSharePreference();
    setState((){
      isLoggedIn =  value;
    });
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      initialRoute: isLoggedIn ? '/home':'/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home' :(context) => HomeScreen(),
        '/status': (context) => StatusScreen(),
        '/calls': (context) => CallScreen(),
        '/message':(context) => MessageScreen(),
        '/search' :(context) => SearchScreen(),
      },
    );
  }
}
