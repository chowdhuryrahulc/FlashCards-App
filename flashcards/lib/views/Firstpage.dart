// ignore_for_file: must_be_immutable

import 'dart:async';
import 'package:flashcards/database/database_helper.dart';
import 'package:flashcards/views/google.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flashcards/list_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import '../drawer.dart';

bool LoggedIn = false;
GoogleSignIn sign = GoogleSignIn();
title? titl;

class Firstpage extends StatefulWidget {
  GoogleSignInAccount? googleAccount;
  Firstpage({this.googleAccount, Key? key}) : super(key: key);

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
      drawer: drawer(context, widget.googleAccount),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: reviewpractice(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("CREATE SET"),
        icon: Icon(Icons.add),
        onPressed: () {
          floatingdialog(context).then((val) {
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
                    LoggedIn = true;
                    // A = userdata;
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

@override
floatingdialog(BuildContext context,
    {String? title, String? description, bool? edit, title? ttl}) {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  if (title != null) {
    titleController.text = title;
    // descriptionController.text= description;
  }

  final _formKey = GlobalKey<FormState>();

  String? Z;
  String? M;

  const Y = <String>[
    'English',
    'Arabic',
    'Bangla',
    'Bosnian',
    'Catalan',
    'Czech'
  ];
  final List<DropdownMenuItem<String>> J = Y
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Form(
            key: _formKey,
            child: Dialog(
                insetPadding: EdgeInsets.all(20),
                //?title,content
                // contentPadding: EdgeInsets.all(10),
                child: Scaffold(
                    appBar: AppBar(
                      elevation: 0.0,
                      leading: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close)),
                      actions: [
                        IconButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _submitTitle(context, titleController.text,
                                    descriptionController.text,
                                    editx: edit, ttl: ttl);
                                setState(() {
                                  Navigator.pop(context);
                                });
                              }
                            },
                            icon: Icon(Icons.check))
                      ],
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (val) => val!.isNotEmpty
                                  ? null
                                  : 'Name Should Not Be Empty',
                              controller: titleController,
                              decoration: InputDecoration(
                                  labelText: "Name",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)))),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextField(
                              controller: descriptionController,
                              decoration: InputDecoration(
                                  labelText: "Description-optional",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text("Category"),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.access_alarm),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Term language",
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                DropdownButton<String>(
                                  //!drop down
                                  value: Z,
                                  hint: Text('English'),
                                  onChanged: (String? N) {
                                    if (N != null) {
                                      Z = N;
                                    }
                                  },
                                  items: J,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text("Definition language"),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                DropdownButton<String>(
                                  value: M,
                                  hint: Text('English'),
                                  onChanged: (String? N1) {
                                    if (N1 != null) {
                                      M = N1;
                                    }
                                  },
                                  items: J,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                  "In case of missing languages, or if audio does not work you need to install the language."),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text("INSTALL LANGUAGES")),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width / 2) + 10,
                              child: FloatingActionButton.extended(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _submitTitle(
                                          context,
                                          titleController.text,
                                          descriptionController.text,
                                          editx: edit,
                                          ttl: ttl);
                                      setState(() {
                                        Navigator.pop(context);
                                      });
                                    }
                                  },
                                  label: Text("ADD CARDS")),
                            ),
                          ],
                        ),
                      ),
                    ))),
          );
        });
      });
}

_submitTitle(BuildContext context, ttleControl, descripControl,
    {bool? editx, title? ttl}) {
  final DBManager dbManager = DBManager();
  // title? TTitle;

  if (editx == null) {
    title ttl = title(name: ttleControl, description: descripControl);
    dbManager.insertTitle(ttl).then((value) => null);
  } else {
    print('FloaTing EditOr ${ttleControl}');
    ttl!.name = ttleControl;
    ttl.description = descripControl;
    // title ttl = title(name: ttleControl, description: descripControl);
    dbManager.updateTitle(ttl).then((value) => null);
  }
}
