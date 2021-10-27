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
        body: Center(
      child: ElevatedButton(
          onPressed: () async {
            Provider.of<GoogleSignInProvider>(context, listen: false)
                .googleLogin();
          },
          child: Text("Sign In via Google")),
    ));
  }
}
