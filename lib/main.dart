import 'package:flingo/chatScreen.dart';
import 'package:flingo/homeScreen.dart';
import 'package:flingo/loginScreen.dart';
import 'package:flingo/registerScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(messenger());
}
class messenger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: homescreen.id,
      routes: {
        homescreen.id:(context) => homescreen(),
        loginscreen.id:(context)=>loginscreen(),
        registerscreen.id:(context)=>registerscreen(),
        chatscreen.id:(context)=>chatscreen()
      },
    );
  }
}
