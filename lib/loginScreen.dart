import 'package:firebase_auth/firebase_auth.dart';
import 'package:flingo/chatScreen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'RoundedButtons.dart';
class loginscreen extends StatefulWidget {
  static const String id = "loginscreen";
  @override
  _loginscreenState createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  final _auth = FirebaseAuth.instance;
  bool spinner = false;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        centerTitle: true,       
        title: Text('Flingo Chat'),
        backgroundColor: Colors.purple,
      ),
        body: SafeArea(
          child: ModalProgressHUD(
            inAsyncCall: spinner,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Theme(
                    data: ThemeData(
                        primaryColor: Colors.purple,
                        primaryColorDark: Colors.purple),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Enter your Email',
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Colors.purple
                        ),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.purple, width: 5.0)),
                      ),
                      
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                  ),
                ),
                 Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Theme(
                    data: ThemeData(
                        primaryColor: Colors.purple,
                        primaryColorDark: Colors.purple),
                    child: TextField(
                      textAlign: TextAlign.center,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Enter your Password',
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: Colors.purple
                        ),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.purple, width: 5.0)),
                      ),
                      
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 50.0),
                  child: RoundButtons(label: 'LOGIN',colour: Colors.purple,onpressed: ()async{
                    setState(() {
                        spinner = true;                      
                      });
                      try{
                        final newUser = await _auth.signInWithEmailAndPassword(email: email, password: password);
                      if(newUser != Null){
                        Navigator.pushNamed(context, chatScreen.id);
                      }
                      setState(() {
                        spinner = false;
                      });
                      }
                      catch(e){
                        print(e);
                      }
                    },),
                )
              ],
            ),
          ),

        ),
    );
  }
}
