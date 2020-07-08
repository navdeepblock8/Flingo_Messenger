import 'package:flingo/chatScreen.dart';
import 'package:flutter/material.dart';
import 'InputFields.dart';
import 'RoundedButtons.dart';
class loginscreen extends StatefulWidget {
  static const String id = "loginscreen";
  @override
  _loginscreenState createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              InputFields(bordercolour: Colors.purple,hintText: 'Enter Your Email',labelText: 'Email',labelTextColor: Colors.purple,hidevalue: false,),
              InputFields(bordercolour: Colors.purple,hintText: 'Enter Your Password',labelText: 'Password',labelTextColor: Colors.purple,hidevalue: true,),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 50.0),
                child: RoundButtons(label: 'LOGIN',colour: Colors.purple,onpressed: (){Navigator.pushNamed(context, chatscreen.id);},),
              )
            ],
          ),

        ),
      ),
    );
  }
}
