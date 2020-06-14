import 'package:flutter/material.dart';
import 'file:///C:/Users/hp/AndroidStudioProjects/whatsapp_clone/lib/screens/constants.dart';

class AppIcons extends StatelessWidget {
  final Icon icon;
  final Function onpress;
  AppIcons({@required this.icon, this.onpress});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      onPressed: onpress,
    );
  }
}

class AppbarCreate extends StatelessWidget implements PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('WhatsApp', style: TextStyle(color: Colors.white, fontSize: 30.0)),
      backgroundColor: Color(0xFF075D55),
      actions: <Widget>[
        AppIcons(icon: Icon(Icons.search, color: Colors.white,), onpress: (){},),
        AppIcons(icon: Icon(Icons.message, color: Colors.white,), onpress: (){},),
        AppIcons(icon: Icon(Icons.settings, color: Colors.white,), onpress: (){},),
      ],
      bottom: PreferredSize(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(child: Text('CHATS', style: appbarText,), onTap: (){
                Navigator.pushNamed(context, '/');
              },),
              GestureDetector(child: Text('STATUS', style: appbarText,), onTap: (){
                Navigator.pushNamed(context, '/status');
              },),
              GestureDetector(child: Text('CALLS', style: appbarText,), onTap: (){
                Navigator.pushNamed(context, '/calls');
              },)
            ],
          ),
        ),
        preferredSize: Size.fromHeight(50.0),
      ),
    );
  }

  @override
  Size get preferredSize {
    return new Size.fromHeight(100.0);
  }
}
