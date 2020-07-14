import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'RoundedButtons.dart';
import 'registerScreen.dart';
import 'loginScreen.dart';
import 'appBar.dart';

class homescreen extends StatefulWidget {
  static const String id = 'homescreen';
  @override
  _homescreenState createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> with SingleTickerProviderStateMixin{
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: Duration(seconds: 1),vsync: this);
    animation = ColorTween(begin: Colors.purple[500],end: Colors.white).animate(controller);
    controller.forward();
    controller.addListener(() {
      setState((){});
    });
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: animation.value,
        appBar: buildAppBar(),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        child: Image(
                          image: AssetImage('images/FlingoLogo.PNG'),
                          height: 80.0,
                          width: 80.0,
                        )
                        ),
                  ),
                      Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  child: TypewriterAnimatedTextKit(text: [
                    'FLINGO....',
                  ], textStyle: mainPagelogo)),
                ],
              ),
              
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                child: RoundButtons(
                    label: 'LOGIN',
                    colour: Colors.purple,
                    onpressed: () {
                      Navigator.pushNamed(context, loginscreen.id);
                    }),
              ),
              Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                  child: RoundButtons(
                    label: 'REGISTER',
                    colour: Colors.purple,
                    onpressed: () {
                      Navigator.pushNamed(context, registerscreen.id);
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
