import 'package:flingo/chatScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'RoundedButtons.dart';
import 'InputFields.dart';
class registerscreen extends StatefulWidget {
  static const String id = 'registerscreen';
  @override
  _registerscreenState createState() => _registerscreenState();
}

class _registerscreenState extends State<registerscreen> {
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
                child: RoundButtons(label: 'REGISTER',colour: Colors.purple,onpressed: (){Navigator.pushNamed(context, chatscreen.id);},),
              )
            ],
          ),

        ),
      ),
    );
  }
}

