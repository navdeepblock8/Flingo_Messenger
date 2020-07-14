import 'package:flingo/appBar.dart';
import 'package:flingo/chatScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'RoundedButtons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class registerscreen extends StatefulWidget {
  static const String id = 'registerscreen';
  @override
  _registerscreenState createState() => _registerscreenState();
}

class _registerscreenState extends State<registerscreen> {
  bool spinner = false;
  String email;
  String password;
  String username;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
        body: SafeArea(
          child: ModalProgressHUD(
            inAsyncCall: spinner,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                 Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/FlingoLogo.PNG'),
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
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Enter your Full Name',
                        labelText: 'Username',
                        labelStyle: TextStyle(
                          color: Colors.purple
                        ),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.purple, width: 5.0)),
                      ),
                      
                      onChanged: (value) {
                        username = value;
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
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                  child: RoundButtons(
                    label: 'REGISTER',
                    colour: Colors.purple,
                    onpressed: () async{
                      setState(() {
                        spinner = true;                      
                      });
                      try{
                        await _auth.createUserWithEmailAndPassword(email: email, password: password);
                        var newUser = await _auth.currentUser();
                      if(newUser != Null){
                        await newUser.sendEmailVerification();
                        UserUpdateInfo info = UserUpdateInfo();
                        info.displayName = username;
                        await newUser.updateProfile(info);
                        Navigator.pushNamed(context, chatScreen.id);
                      }
                      setState(() {
                        spinner = false;
                      });
                      }
                      catch(e){
                        print(e);
                      }
                                                                  
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
