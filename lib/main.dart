import 'package:flutter/material.dart';
import 'file:///C:/Users/hp/AndroidStudioProjects/whatsapp_clone/lib/screens/home_screen.dart';
import 'file:///C:/Users/hp/AndroidStudioProjects/whatsapp_clone/lib/screens/status_screen.dart';
import 'file:///C:/Users/hp/AndroidStudioProjects/whatsapp_clone/lib/screens/call_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/' :(context) => HomeScreen(),
        '/status': (context) => StatusScreen(),
        '/calls': (context) => CallScreen(),
      },
    );
  }
}
