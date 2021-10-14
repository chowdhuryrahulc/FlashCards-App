import 'dart:async';
import 'package:flashcards/database/database_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flashcards/reviewpractice.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import '../drawer.dart';
import '../floatingdialog.dart';

bool LoggedIn = false;
GoogleSignInAccount? A;
GoogleSignIn sign = GoogleSignIn();
title? titl;

class Firstpage extends StatefulWidget {
  // static var dark;

  const Firstpage({Key? key}) : super(key: key);

  @override
  _FirstpageState createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  bool X = false;
  List<String> litems = ["1", "2", "3"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: Icon(Icons.refresh)),
          IconButton(
              onPressed: () async {
                await launch("https://www.youtube.com/");
              },
              icon: Icon(Icons.help_outline_rounded)),
          PopupMenuButton(itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(child: Text("Review Settings")),
              PopupMenuItem(
                child: CheckboxListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text("Display Archived"),
                    value: this.X,
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() => this.X = value);
                      }
                    }),
              )
            ];
          })
        ],
      ),
      drawer: drawer(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: reviewpractice(litems: litems),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("CREATE SET"),
        icon: Icon(Icons.add),
        onPressed: () {
          floatingdialog(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  @override
  void G(BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          // title: Image.network(
          //     "https://en.wikipedia.org/wiki/Flag_of_India#/media/File:Flag_of_India.svg"),

          actions: [
            Text("WELCOME"),
            Text(
                "Sign in and have your data synced across all of your devices"),
            ElevatedButton(
                onPressed: () {
                  sign.signIn().then((userdata) {
                    // setState(() {
                    LoggedIn = true;
                    A = userdata;
                    print(LoggedIn);
                    // });
                    Navigator.pop(context);
                  });
                },
                child: Text("login with Google")),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("SIGN-IN LATER"),
            ),
            Text("By using this app you agree to our TOS and Privacy Policy"),
            TextButton(
                onPressed: () {}, child: Text("Terms of use Privacy policy"))
          ],
          // text ""
        );
      },
    );
  }
}
