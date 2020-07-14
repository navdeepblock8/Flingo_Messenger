import 'package:firebase_auth/firebase_auth.dart';
import 'package:flingo/appBar.dart';
import 'package:flingo/chatScreen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'RoundedButtons.dart';
import 'dart:io' show Platform;

enum authProblems { UserNotFound, PasswordNotValid, NetworkError }

class loginscreen extends StatefulWidget {
  static const String id = "loginscreen";
  @override
  _loginscreenState createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  final _auth = FirebaseAuth.instance;
  final _validemail = TextEditingController();
  final _validpassword = TextEditingController();
  bool isErrorPassword = false;
  bool isErrorEmail = false;
  bool spinner = false;
  String email;
  String password;

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
                    controller: _validemail,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Enter your Email',
                      labelText: 'Email',
                      errorText:
                          isErrorEmail ? 'This Field cannot be empty' : null,
                      labelStyle: TextStyle(color: Colors.purple),
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
                    controller: _validpassword,
                    textAlign: TextAlign.center,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Enter your Password',
                      labelText: 'Password',
                      errorText:
                          isErrorPassword ? 'This Field cannot be empty' : null,
                      labelStyle: TextStyle(color: Colors.purple),
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
                  label: 'LOGIN',
                  colour: Colors.purple,
                  onpressed: () async {
                    if (_validemail.text.isEmpty == true) {
                      setState(() {
                        isErrorEmail = true;
                        isErrorPassword = false;
                      });
                    } else if (_validpassword.text.isEmpty == true) {
                      setState(() {
                        isErrorPassword = true;
                        isErrorEmail = false;
                      });
                    } else {
                      setState(() {
                        isErrorEmail = false;
                        isErrorPassword = false;
                        spinner = true;
                      });
                      try {
                        await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        var newUser = await _auth.currentUser();
                        if (newUser != Null) {
                          print(newUser.displayName);
                          Navigator.pushNamed(context, chatScreen.id);
                        }
                        setState(() {
                          spinner = false;
                        });
                      } catch (e) {
                         setState(() {
                          spinner = false;
                        });
                        authProblems errorType;
                        if (Platform.isAndroid) {
                          switch (e.message) {
                            case 'There is no user record corresponding to this identifier. The user may have been deleted.':
                              errorType = authProblems.UserNotFound;
                              break;
                            case 'The password is invalid or the user does not have a password.':
                              errorType = authProblems.PasswordNotValid;
                              break;
                            case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
                              errorType = authProblems.NetworkError;
                              break;
                            // ...
                            default:
                              print('${e.message}');
                          }
                        } else if (Platform.isIOS) {
                          switch (e.code) {
                            case 'Error 17011':
                              errorType = authProblems.UserNotFound;
                              break;
                            case 'Error 17009':
                              errorType = authProblems.PasswordNotValid;
                              break;
                            case 'Error 17020':
                              errorType = authProblems.NetworkError;
                              break;
                            // ...
                            default:
                              print('Case ${e.message} is not yet implemented');
                          }
                        }
                        print(e.message);
                      }
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
