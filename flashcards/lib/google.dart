import 'package:flashcards/allset.dart';
import 'package:flashcards/main.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

late GoogleSignInAccount A;
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
    check_if_already_login();
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('loginx') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Firstpage()));
    }
     }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
          onPressed: () async {
            await sign.signIn();
            print('Successfull');
            logindata.setBool('loginx', false);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Firstpage()));
            },
          child: Text("Sign In via Google")),
    ));
  }
}
