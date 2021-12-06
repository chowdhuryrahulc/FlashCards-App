import 'package:flashcards/database/google_sign_in.dart';
import 'package:flashcards/views/Firstpage.dart';
import 'package:flashcards/main.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class google extends StatefulWidget {
  const google({Key? key}) : super(key: key);

  @override
  _googleState createState() => _googleState();
}

class _googleState extends State<google> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Sign In'),
              Text('Sign In'),
              ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(Icons.email_outlined),
                      Text('Sign in with email')
                    ],
                  )),
              ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(Icons.email_outlined),
                      Text('Sign in with email')
                    ],
                  )),
              ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(Icons.email_outlined),
                      Text('Sign in with email')
                    ],
                  )),
              ElevatedButton(
                  onPressed: () async {
                    Provider.of<GoogleSignInProvider>(context, listen: false)
                        .googleLogin();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.email_outlined),
                      Text('Sign in with Google')
                    ],
                  )),
            ],
          ),
        ));
  }
}
