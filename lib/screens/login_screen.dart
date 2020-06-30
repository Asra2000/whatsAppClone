import 'package:flutter/material.dart';
import 'package:whatsappclone/services/constants.dart';
import 'package:whatsappclone/services/database.dart';
import 'package:whatsappclone/services/helperfunctions.dart';
import '../services/auth.dart';
import '../model/user.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  Auth _auth = Auth();

  String username, email, password;
  bool loader = false;
  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  getUserInfo() async{
    Constants.myName = await Helper.getUserNameSharePreference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF075D55),
        title: Text('SignIn'),
      ),
      body: !loader ? SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Color(0xFFEBE4DC),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 100.0,
                ),
                Form(
                    child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: nameController,
                      validator: (val) {
                        return (val == null)
                            ? 'This field can\'t be null'
                            : null;
                      },
                      onChanged: (String name) {
                        username = name;
                      },
                      decoration: InputDecoration(
                        hintText: 'Username',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                    ),
                    TextFormField(
                      keyboardType:TextInputType.emailAddress,
                      controller: emailController,
                      validator: (val) {
                        return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val)
                            ? null
                            : "Please Enter Correct Email";
                      },
                      onChanged: (String name) {
                        email =  name;
                      },
                      decoration: InputDecoration(
                        hintText: 'Email',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      validator: (val) {
                       return  val.length > 6 || val == null
                            ? null
                            : "Enter a password of more than 6 characters";
                      },
                      onChanged: (String name) {
                        password = name;
                      },
                      decoration: InputDecoration(
                        hintText: 'Password',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                    ),
                  ],
                )),
                SizedBox(
                  height: 30.0,
                ),
                RaisedButton(
                  onPressed: () async{
                    setState(() {
                      loader =  true;
                    });
                    User user = await _auth.signInWithEmailAndPassword(email, password);
                    if (user != null){
                      user.setName(username);
                      Constants.myName = username;
                      Helper.saveUserNameSharePreference(username);
                      Helper.saveUserLoggedInSharePreference(true);
                      Navigator.pushReplacementNamed(context, '/home');
                    }
                  },
                  child: Text('Sign In'),
                  color: Color(0xFF43CE7B),
                ),
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      loader =  true;
                    });
                  },
                  child: Text('Sign In with Google'),
                  color: Colors.white,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Don\'t have a account?',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    GestureDetector(
                        onTap: () async{
                          setState(() {
                            loader =  true;
                          });
                          User user = await _auth.signUpWithEmailAndPassword(email, password);
                          if (user!= null){
//                            user.setName(username);
                            Map<String, String> newuser = {
                              'name': user.name,
                            };
                            Constants.myName = username;
                            Helper.saveUserNameSharePreference(username);
                            Helper.saveUserLoggedInSharePreference(true);
                            Database().addNewUser(newuser);
                            Navigator.pushReplacementNamed(context, '/home');
                          }
                          else{
                            print('error while sing up');
                          }
                        },
                        child: Text(
                          'Register Now',
                          style: TextStyle(fontSize: 16.0),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ) : Container(
        child: Center(child: CircularProgressIndicator()),
      )
    );
  }
}
