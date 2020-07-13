import 'package:flingo/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class chatScreen extends StatefulWidget {
  static const String id = 'chatScreen';
  @override
  _chatScreenState createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> {
  final _auth = FirebaseAuth.instance;
  final _cloud = Firestore.instance;
  FirebaseUser loggedInUser;
  String messageText;
  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }
  void getCurrentUser() async{
    try{
      final user = await _auth.currentUser();
    if(user != Null){
      loggedInUser = user;
    }
    }
    catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
               _auth.signOut();
               Navigator.pushNamed(context, homescreen.id);
              }),
        ],
        centerTitle: true,
        title: Text('Flingo Chat'),
        backgroundColor: Colors.purple,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder(
              stream:  _cloud.collection('messages').snapshots(),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator());
                }
                  final messages = snapshot.data.documents;
                  List<Text> DisplayMessages = [];
                  for(var message in messages){
                    final messagetext = message.data['text'];
                    final sender = message.data['user'];
                    final addmessage = Text('$messagetext from $sender');
                    DisplayMessages.add(addmessage);
                  }
                  
                  return Column(
                    children: DisplayMessages
                  );
                
              }
              ),
            Container(
              
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messageText = value;
                      },
                      
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      
                          _cloud.collection('messages').add({
                            'text': messageText,
                            'user': loggedInUser.email
                          });
                      
                    },
                    child: Text(
                      'Send',
                      
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}