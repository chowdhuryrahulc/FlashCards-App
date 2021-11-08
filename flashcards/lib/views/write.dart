import 'package:flashcards/database/2nd_database_helper.dart';
import 'package:flashcards/views/Firstpage.dart';
import 'package:flashcards/views/grid_view.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';

class write extends StatefulWidget {
  bool? editxyz;
  String? termxyz;
  String? definationxyz;
  nd_title? ttl;

  write({
    this.editxyz,
    this.termxyz,
    this.definationxyz,
    this.ttl,
    Key? key,
  }) : super(key: key);

  @override
  _writeState createState() => _writeState();
}

// String? editxyz = editxyz;

class _writeState extends State<write> {
  void initState() {
    // termxy = widget.termxyz;
    if (widget.termxyz != null) {
      termController.text = widget.termxyz!;
      definationController.text = widget.definationxyz!;
    }
    // print(widget.editxyz);
    super.initState();
  }

  // CollectionReference users = FirebaseFirestore.instance.collection('users');
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
    return WillPopScope(
      onWillPop: () {
        return Navigator.push(
                context, MaterialPageRoute(builder: (context) => gridView()))
            .then((value) {
          return true;
        });
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => gridView()));
              },
              icon: Icon(Icons.clear_sharp)),
          actions: [
            IconButton(
                onPressed: () {}, icon: Icon(Icons.help_outline_rounded)),
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
                          validator: (val) => val!.isNotEmpty
                              ? null
                              : 'Term Should Not Be Empty',
                          controller: termController,
                          // onChanged: (value) {
                          // term = value;
                          // },
                          decoration: InputDecoration(
                              hintText: "TERM",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)))),
                        ),
                        ListTile(
                          leading: IconButton(
                              onPressed: () {
                                showBottomSheet(false);
                              },
                              icon: Icon(Icons.access_time_filled_rounded),
                              iconSize: 15),
                        ),
                        TextFormField(
                          validator: (val) => val!.isNotEmpty
                              ? null
                              : 'Defination Should Not Be Empty',
                          controller: definationController,
                          // onChanged: (value) {
                          // definition = value;
                          // },
                          decoration: InputDecoration(
                              hintText: "DEFINITION",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)))),
                        ),
                        ListTile(
                          leading: IconButton(
                              onPressed: () {
                                showBottomSheet(true);
                              },
                              icon: Icon(Icons.access_time_filled_rounded),
                              iconSize: 15),
                        ),
                        Text("Tag",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        ListTile(
                          title: Row(
                            children: [
                              Text("Advanced",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
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
                              controller: exampleController,
                              onChanged: (value) {
                                // example = value;
                              },
                              decoration: InputDecoration(
                                  hintText: "Examples",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)))),
                            ),
                          ),
                          ListTile(
                              title: TextField(
                                // onChanged: (value) {
                                //   url = value;
                                // },
                                decoration: InputDecoration(
                                    hintText: "URL",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)))),
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
                        if (_formKey.currentState!.validate()) {
                          _submitTitle(context, termController.text,
                              definationController.text,
                              exampleControl: exampleController.text,
                              editxy: widget.editxyz,
                              ttl: widget.ttl);
                          setState(() {
                            termController.text = '';
                            definationController.text = '';
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
          // HIDDEN=true? TextField();

          // FloatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        ),
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

_submitTitle(BuildContext context, termControl, definationControl,
    {exampleControl, bool? editxy, nd_title? ttl}) {
  final DBManager2 dbManager2 = DBManager2();
  // title? TTitle;
  // print(ttl!.nd_id);
  if (editxy == null) {
    nd_title ttl = nd_title(
        term: termControl,
        defination: definationControl,
        example: exampleControl);
    dbManager2.insertTitle(ttl).then((value) => null);
  } else {
    // print('FloaTing EditOr ${ttl!.nd_id}');
    ttl!.term = termControl;
    ttl.defination = definationControl;
    // title ttl = title(name: ttleControl, description: descripControl);
    dbManager2.updateTitle(ttl).then((value) => null);
  }
}
