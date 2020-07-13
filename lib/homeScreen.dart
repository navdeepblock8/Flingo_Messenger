import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'RoundedButtons.dart';
import 'registerScreen.dart';
import 'loginScreen.dart';
class homescreen extends StatefulWidget {
  static const String id = 'homescreen';
  @override
  _homescreenState createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
        leading: null,
        centerTitle: true,
        title: Text('Flingo Chat'),
        backgroundColor: Colors.purple,
      ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 50.0),
                child:TypewriterAnimatedTextKit(
                  text: [
                    'FLINGO.....',
                  ],
                    textStyle: mainPagelogo
                )
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 50.0),
                child: RoundButtons(label: 'LOGIN',colour: Colors.purple,onpressed:(){ Navigator.pushNamed(context,loginscreen.id);}),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 50.0),
                child: RoundButtons(label: 'REGISTER',colour: Colors.purple,onpressed:(){ Navigator.pushNamed(context,registerscreen.id);},)
              )
            ],
          ),
        ),
      ),
    );
  }
}

