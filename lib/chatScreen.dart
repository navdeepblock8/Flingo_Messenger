import 'package:flingo/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _cloud = Firestore.instance;
FirebaseUser loggedInUser;

class chatScreen extends StatefulWidget {
  static const String id = 'chatScreen';
  @override
  _chatScreenState createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> {
  final _auth = FirebaseAuth.instance;
  final textController = TextEditingController();
  String messageText;
  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != Null) {
        loggedInUser = user;
      }
    } catch (e) {
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
        backgroundColor: Colors.purple[300],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              height: 40,
              color: Colors.purple[300],
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Theme(
                      data: ThemeData(primaryColor: Colors.purple[200],
                      primaryColorDark: Colors.purple[200]),
                      child: TextField(
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.purple[50],
                           border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(color: Colors.black)
                          )
                        ),
                        controller: textController,
                        onChanged: (value) {
                          messageText = value;
                        },
                      ),
                    ),
                  ),
                  FlatButton(
                   
                    onPressed: () {
                      if(messageText is String && messageText.toString()!=''){
                        _cloud.collection('messages').add(
                          {'text': messageText, 'username': loggedInUser.displayName, 'user':loggedInUser.email,'date': DateTime.now().toIso8601String().toString(),});
                          textController.clear();
                      }
                      else{
                        print(messageText);
                      }
                      
                    },
                    child: Text(
                      'Send',
                      style: TextStyle(
                        fontSize: 20,
                      
                        fontWeight: FontWeight.w500
                      ),
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

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _cloud.collection('messages').orderBy('date').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final messages = snapshot.data.documents.reversed;
          List<MessageBubble> DisplayMessages = [];
          for (var message in messages) {
            final messagetext = message.data['text'];
            final sender = message.data['user'];
            final username = message.data['username'];
            final currentUser = loggedInUser.email;
            final addmessage = MessageBubble(sender: username, text: messagetext,isMe:currentUser==sender);
            DisplayMessages.add(addmessage);
          }

          return Expanded(
            child: ListView(reverse: true,
              children: DisplayMessages),
          );
        });
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text,this.isMe});
  final bool isMe;
  final String text;
  final String sender;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: <Widget>[
          Material(
            borderRadius: isMe?BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0)):
                    BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0)),
            color: isMe?Colors.purpleAccent:Colors.grey,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(color: Colors.black, fontSize: 30.0),
              ),
            ),
          ),
          Text(
            sender,
            style:
                TextStyle(color: Colors.black54, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
