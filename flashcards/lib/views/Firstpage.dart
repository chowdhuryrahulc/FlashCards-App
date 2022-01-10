// ignore_for_file: must_be_immutable

import 'package:flashcards/database/2nd_database_helper.dart';
import 'package:flashcards/database/database_helper.dart';
import 'package:flashcards/modals/Practice.dart';
import 'package:flashcards/modals/createSet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flashcards/views/list_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import '../BasicReview.dart';
import '../drawer.dart';

GoogleSignIn sign = GoogleSignIn();
title? titl;

class Firstpage extends StatefulWidget {
  GoogleSignInAccount? googleAccount;
  Firstpage({this.googleAccount, Key? key}) : super(key: key);

  @override
  _FirstpageState createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  bool X = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(180),
        child: Column(
          children: [
            AppBar(
              elevation: 0,
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
                          activeColor: Colors.blueGrey,
                          checkColor: Colors.amber,
                          contentPadding: EdgeInsets.all(0),
                          title: Text(
                            "Display Archived",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          value: X,
                          onChanged: (bool? value) {
                            if (value != null) {
                              setState(() {
                                X = value;
                                Navigator.pop(context);
                              });
                            }
                          }),
                    )
                  ];
                })
              ],
            ),
            Expanded(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    color: Theme.of(context).colorScheme.secondary,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.grey),
                          ),
                          child: ListTile(
                            leading: Text(
                              'All Sets',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            trailing: Icon(Icons.arrow_drop_down),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: 130,
                                height: 35,
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BasicReview()));
                                  },
                                  child: Text("REVIEW ALL",
                                      style: TextStyle(color: Colors.blue)),
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      40.0)))),
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              width: 130,
                              height: 35,
                              child: OutlinedButton(
                                onPressed: () {
                                  Practice(context);
                                },
                                child: Text("PRACTICE ALL",
                                    style: TextStyle(color: Colors.blue)),
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40.0)))),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )))
          ],
        ),
      ),
      drawer: drawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: list_view(X: X),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("CREATE SET"),
        icon: Icon(Icons.add),
        backgroundColor: Colors.blue,
        onPressed: () {
          createSet(context).then((val) {
            setState(() {});
          });
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
                    // LoggedIn = true;
                    // A = userdata;
                    // print(LoggedIn);
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
