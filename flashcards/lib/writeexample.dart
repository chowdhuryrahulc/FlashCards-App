// import 'package:firebase_database/firebase_database.dart';
// import 'package:flashcards/Database.dart';
// import 'dart:ui';

import 'package:flashcards/views/Firstpage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';

class write extends StatefulWidget {
  const write({Key? key}) : super(key: key);

  @override
  _writeState createState() => _writeState();
}

class _writeState extends State<write> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  bool HIDDEN = false;
  String? term;
  String? definition;
  String? example;
  String? url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Firstpage()));
            },
            icon: Icon(Icons.clear_sharp)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.help_outline_rounded)),
          IconButton(onPressed: () {}, icon: Icon(Icons.check_outlined))
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      term = value;
                    },
                    decoration: InputDecoration(
                        hintText: "TERM",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                  IconButton(
                      onPressed: () {
                        showBottomSheet(false);
                      },
                      icon: Icon(Icons.access_time_filled_rounded),
                      iconSize: 15),
                  TextField(
                    onChanged: (value) {
                      definition = value;
                    },
                    decoration: InputDecoration(
                        hintText: "DEFINITION",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                  IconButton(
                      onPressed: () {
                        showBottomSheet(true);
                      },
                      icon: Icon(Icons.access_time_filled_rounded),
                      iconSize: 15),
                  Text("Tag",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  ListTile(
                    title: Row(
                      children: [
                        Text("Advanced",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        Switch(
                            value: HIDDEN,
                            onChanged: (changed) {
                              setState(() {
                                HIDDEN = changed;
                              });
                            }),
                      ],
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: HIDDEN,
                child: Column(
                  children: [
                    ListTile(
                      title: TextField(
                        onChanged: (value) {
                          example = value;
                        },
                        decoration: InputDecoration(
                            hintText: "Examples",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)))),
                      ),
                    ),
                    ListTile(
                        title: TextField(
                          onChanged: (value) {
                            url = value;
                          },
                          decoration: InputDecoration(
                              hintText: "URL",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)))),
                        ),
                        trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.account_balance_rounded))),
                  ],
                ),
              ),
              FloatingActionButton.extended(
                label: Text('ADD NEXT CARD'),
                onPressed: () async {
                  await users.add({
                    'name': '$term',
                    'age': '$definition',
                    'Notes': '$example'
                  }).then((value) => print('user added'));
                },
              ),
            ],
          ),
        ),
        // HIDDEN=true? TextField();

        // FloatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  void showBottomSheet(visible) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(mainAxisSize: MainAxisSize.min, children: [
            ListTile(
                leading: Icon(Icons.share),
                title: Text('Add drawing'),
                onTap: () {}),
            ListTile(
                leading: Icon(Icons.photo),
                title: Text('Select from gallery'),
                onTap: () {}),
            ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take photo'),
                onTap: () {}),
            Visibility(
              visible: visible,
              child: ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Clear image'),
                  onTap: () {}),
            ),
          ]);
        });
  }
}
