import 'package:flashcards/views/allset.dart';
import 'package:flashcards/main.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

GoogleSignInAccount? A;
GoogleSignIn sign = GoogleSignIn();

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
            // print(A!.displayName ?? '');

            await sign.signIn();
            Helperfunctions.saveuserLoggedInSharedPreference(true);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Firstpage(A: A)));
          },
          child: Text("Sign In via Google")),
    ));
  }
}
