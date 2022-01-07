import 'dart:io';

import 'package:flashcards/database/2nd_database_helper.dart';
import 'package:flashcards/views/grid_view.dart';
import 'package:flashcards/whiteBoardReview.dart';
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
                        validator: (val) =>
                            val!.isNotEmpty ? null : 'Term Should Not Be Empty',
                        controller: termController,
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
                            icon: Icon(Icons.photo_rounded),
                            color: Colors.black,
                            iconSize: 35),
                      ),
                      TextFormField(
                        validator: (val) => val!.isNotEmpty
                            ? null
                            : 'Defination Should Not Be Empty',
                        controller: definationController,
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
                            icon: Icon(Icons.photo_rounded),
                            color: Colors.black,
                            iconSize: 35),
                      ),
                      Text("Tag",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
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
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(mainAxisSize: MainAxisSize.min, children: [
            ListTile(
                leading: Icon(Icons.share),
                title: Text('Add drawing'),
                onTap: () {
                  addDrawing(context);
                }),
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

addDrawing(BuildContext context) {
  List<DrawingPoints>? points = [];
  double strokeWidth = 3.0;
  StrokeCap strokeCap = (Platform.isAndroid) ? StrokeCap.butt : StrokeCap.round;
  Color color = Colors.black;
  GlobalKey stickeyKeyX = GlobalKey();

  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            insetPadding: EdgeInsets.all(20),
            child: Scaffold(
              appBar: AppBar(
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close)),
                  actions: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.check)),
                  ]),
              body: Column(
                children: [
                  Expanded(
                      key: stickeyKeyX,
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          setState(() {
                            final keyContext = stickeyKeyX.currentContext;
                            RenderBox renderBox =
                                keyContext!.findRenderObject() as RenderBox;
                            points.add(DrawingPoints(
                                points: renderBox
                                    .globalToLocal(details.globalPosition),
                                paint: Paint()
                                  ..strokeCap = strokeCap
                                  ..isAntiAlias = true
                                  ..color = color
                                  ..strokeWidth = strokeWidth));
                          });
                        },
                        onPanStart: (details) {
                          setState(() {
                            final keyContext = stickeyKeyX.currentContext;
                            RenderBox renderBox =
                                keyContext!.findRenderObject() as RenderBox;
                            points.add(DrawingPoints(
                                points: renderBox
                                    .globalToLocal(details.globalPosition),
                                paint: Paint()
                                  ..strokeCap = strokeCap
                                  ..isAntiAlias = true
                                  ..color = Colors.black
                                  ..strokeWidth = strokeWidth));
                          });
                        },
                        onPanEnd: (details) {
                          setState(() {
                            points.add(DrawingPoints(points: null));
                          });
                        },
                        child: CustomPaint(
                          size: Size.infinite,
                          painter: DrawingPainter(
                            pointsList: points,
                          ),
                        ),
                      )),
                  Row(
                    children: [
                      Container(
                        height: 56,
                        width: (MediaQuery.of(context).size.width - 40) / 4,
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                strokeWidth = 3.0;
                              });
                            },
                            icon: Icon(Icons.brightness_1, size: 7)),
                      ),
                      Container(
                        height: 56,
                        width: (MediaQuery.of(context).size.width - 40) / 4,
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                strokeWidth = 7.0;
                              });
                            },
                            icon: Icon(Icons.brightness_1, size: 15)),
                      ),
                      Container(
                        height: 56,
                        width: (MediaQuery.of(context).size.width - 40) / 4,
                        child: IconButton(
                            onPressed: () {
                              setState(() {});
                            },
                            icon: Icon(Icons.undo)),
                      ),
                      Container(
                        height: 56,
                        width: (MediaQuery.of(context).size.width - 40) / 4,
                        child: IconButton(
                            onPressed: () {}, icon: Icon(Icons.redo)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            color = Colors.purple;
                          });
                        },
                        child: Container(
                          height: 56,
                          color: Colors.purple,
                          width: (MediaQuery.of(context).size.width - 40) / 4,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            color = Colors.green;
                          });
                        },
                        child: Container(
                          height: 56,
                          color: Colors.green,
                          width: (MediaQuery.of(context).size.width - 40) / 4,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            color = Colors.red;
                          });
                        },
                        child: Container(
                          color: Colors.red,
                          height: 56,
                          width: (MediaQuery.of(context).size.width - 40) / 4,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            color = Colors.yellow;
                          });
                        },
                        child: Container(
                          color: Colors.yellow,
                          height: 56,
                          width: (MediaQuery.of(context).size.width - 40) / 4,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            color = Colors.blue;
                          });
                        },
                        child: Container(
                          height: 56,
                          color: Colors.blue,
                          width: (MediaQuery.of(context).size.width - 40) / 4,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            color = Colors.lightGreen;
                          });
                        },
                        child: Container(
                          height: 56,
                          color: Colors.lightGreen,
                          width: (MediaQuery.of(context).size.width - 40) / 4,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            color = Colors.red;
                          });
                        },
                        child: Container(
                          color: Colors.red,
                          height: 56,
                          width: (MediaQuery.of(context).size.width - 40) / 4,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            color = Colors.black;
                          });
                        },
                        child: Container(
                          color: Colors.black,
                          height: 56,
                          width: (MediaQuery.of(context).size.width - 40) / 4,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      });
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
