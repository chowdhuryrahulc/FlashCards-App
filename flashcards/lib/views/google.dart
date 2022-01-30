import 'package:flashcards/database/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    TextStyle? bodtStyle1 = Theme.of(context).textTheme.bodyText1;
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Sign', style: bodtStyle1),
          Text('In', style: bodtStyle1),
          Text('with', style: bodtStyle1),
          ClipOval(
            child: InkWell(
                onTap: () async {
                  Provider.of<GoogleSignInProvider>(context, listen: false)
                      .googleLogin();
                },
                child: Container(
                  height: 250,
                  child: Image.asset(
                    'assets/google-login-icon-24.jpg',
                  ),
                )),
          ),
        ],
      ),
    ));
  }
}
