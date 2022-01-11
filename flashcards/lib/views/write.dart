import 'dart:io';

import 'package:flashcards/database/2nd_database_helper.dart';
import 'package:flashcards/modals/addDrawing.dart';
import 'package:flashcards/views/grid_view.dart';
import 'package:flashcards/views/whiteBoardReview.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';

class write extends StatefulWidget {
  bool? editxyz;
  String? termxyz;
  String? definationxyz;
  nd_title? ttl;
  String? currentSet; //TODO PROBABLY REQUIRED

  write({
    this.editxyz,
    this.termxyz,
    this.definationxyz,
    this.ttl,
    this.currentSet,
    Key? key,
  }) : super(key: key);

  @override
  _writeState createState() => _writeState();
}

class _writeState extends State<write> {
  void initState() {
    // termxy = widget.termxyz;
    if (widget.termxyz != null) {
      termController.text = widget.termxyz!;
      definationController.text = widget.definationxyz!;
    }
    // currentSet = widget.currentSet;
    super.initState();
  }

  // CollectionReference users = FirebaseFirestore.instance.collection('users');
  // String? currentSet;
  bool HIDDEN = false;
  String? term;
  String? definition;
  String? example;
  String? url;
  TextEditingController termController = TextEditingController();
  TextEditingController definationController = TextEditingController();
  TextEditingController exampleController = TextEditingController();
  // String? termxy;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).colorScheme.primary;
    Color iconColor = Theme.of(context).iconTheme.color!;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.clear_sharp)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.help_outline_rounded)),
          IconButton(onPressed: () {}, icon: Icon(Icons.check_outlined))
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Column(
                    children: [
                      TextFormField(
                        style: TextStyle(color: textColor),
                        validator: (val) =>
                            val!.isNotEmpty ? null : 'Term Should Not Be Empty',
                        controller: termController,
                        decoration: InputDecoration(
                            hintText: "TERM",
                            hintStyle: TextStyle(color: textColor),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)))),
                      ),
                      ListTile(
                        leading: IconButton(
                            onPressed: () {
                              showBottomSheet(false);
                            },
                            icon: Icon(Icons.photo_rounded),
                            color: iconColor,
                            iconSize: 35),
                      ),
                      TextFormField(
                        style: TextStyle(color: textColor),
                        validator: (val) => val!.isNotEmpty
                            ? null
                            : 'Defination Should Not Be Empty',
                        controller: definationController,
                        decoration: InputDecoration(
                            hintText: "DEFINITION",
                            hintStyle: TextStyle(color: textColor),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)))),
                      ),
                      ListTile(
                        leading: IconButton(
                            onPressed: () {
                              showBottomSheet(true);
                            },
                            icon: Icon(Icons.photo_rounded, color: iconColor),
                            iconSize: 35),
                      ),
                      Text("Tag",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          )),
                      ListTile(
                        title: Row(
                          children: [
                            Text("Advanced",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: textColor)),
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
                          title: TextFormField(
                            style: TextStyle(color: textColor),
                            controller: exampleController,
                            onChanged: (value) {
                              // example = value;
                            },
                            decoration: InputDecoration(
                                hintText: "Examples",
                                hintStyle: TextStyle(color: textColor),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0)))),
                          ),
                        ),
                        ListTile(
                            title: TextField(
                              style: TextStyle(color: textColor),
                              decoration: InputDecoration(
                                  hintText: "URL",
                                  hintStyle: TextStyle(color: textColor),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)))),
                            ),
                            trailing: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.account_balance_rounded,
                                    color: iconColor))),
                      ],
                    ),
                  ),
                  FloatingActionButton.extended(
                    label: Text('ADD NEXT CARD'),
                    onPressed: () async {
                      // print(currentSet);
                      if (_formKey.currentState!.validate()) {
                        _submitTitle(
                          context,
                          termController.text,
                          definationController.text,
                          widget.currentSet,
                          exampleControl: exampleController.text,
                          editxy: widget.editxyz,
                          ttl: widget.ttl,
                        );
                        setState(() {
                          definationController.text = '';
                          termController.text = '';
                        });
                      }

                      // await users.add({
                      //   'name': '$term',
                      //   'age': '$definition',
                      //   'Notes': '$example'
                      // }).then((value) => print('user added'));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showBottomSheet(visible) {
    Color textColor = Theme.of(context).colorScheme.primary;
    Color iconColor = Theme.of(context).iconTheme.color!;

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(mainAxisSize: MainAxisSize.min, children: [
            ListTile(
                leading: Icon(Icons.share, color: iconColor),
                title: Text(
                  'Add drawing',
                  style: TextStyle(color: textColor),
                ),
                onTap: () {
                  addDrawing(context);
                }),
            ListTile(
                leading: Icon(
                  Icons.photo,
                  color: iconColor,
                ),
                title: Text(
                  'Select from gallery',
                  style: TextStyle(color: textColor),
                ),
                onTap: () {}),
            ListTile(
                leading: Icon(
                  Icons.camera_alt,
                  color: iconColor,
                ),
                title: Text(
                  'Take photo',
                  style: TextStyle(color: textColor),
                ),
                onTap: () {}),
            Visibility(
              visible: visible,
              child: ListTile(
                  leading: Icon(Icons.delete, color: iconColor),
                  title: Text(
                    'Clear image',
                    style: TextStyle(color: textColor),
                  ),
                  onTap: () {}),
            ),
          ]);
        });
  }
}

_submitTitle(
    BuildContext context, termControl, definationControl, currentSetControl,
    {exampleControl, bool? editxy, nd_title? ttl}) {
  final DBManager2 dbManager2 = DBManager2();
  // title? TTitle;
  // print(ttl!.nd_id);
  if (editxy == null) {
    nd_title ttl = nd_title(
      term: termControl,
      defination: definationControl,
      example: exampleControl,
      current_set: currentSetControl,
    ); //TODO enter to db
    dbManager2.insertTitle(ttl).then((value) => null);
  } else {
    // print('FloaTing EditOr ${ttl!.nd_id}');
    ttl!.term = termControl;
    ttl.defination = definationControl;
    // title ttl = title(name: ttleControl, description: descripControl);
    dbManager2.updateTitle(ttl).then((value) => null);
  }
}
