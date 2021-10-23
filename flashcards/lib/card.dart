import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_tts/flutter_tts.dart';

class Insidepage extends StatefulWidget {
  const Insidepage({Key? key}) : super(key: key);

  @override
  _InsidepageState createState() => _InsidepageState();
}

class _InsidepageState extends State<Insidepage> {
  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection("users").snapshots();
  // final TTS = FlutterTts();

  // Future S(X) async {
  //   await TTS.speak(X);
  // }

  int N = 0;
  // var X;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.flip_to_front)),
      ]),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: users,
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot,
                      ) {
                        if (snapshot.hasError) {
                          return Text("Something went wrong");
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("Loading");
                        }
                        final data = snapshot.requireData;
                        {
                          return FlipCard(
                            front: GestureDetector(
                              onHorizontalDragStart:
                                  (DragStartDetails dragStartDetails) {
                                setState(() {
                                  N = N - 1;
                                });
                              },
                              child: Card(
                                color: Colors.blue,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned(
                                        top: 0,
                                        left: 0,
                                        child: IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.favorite))),
                                    Text(
                                      "${data.docs[N]['name']}",
                                      textAlign: TextAlign.center,
                                      // style: TextStyle(color: Colors.amber),
                                    ), //!FFUUUUUCCCCCCCKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
                                    Positioned(
                                        bottom: 0,
                                        left: 0,
                                        child: IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.edit))),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: IconButton(
                                        onPressed: () {
                                          // S("${data.docs[N]['name']}");
                                        },
                                        icon: Icon(Icons.play_circle_outline),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 8,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        // right: MediaQuery.of(context).size.width * 0.5,
                                        // bottom: 8,
                                        child: FloatingActionButton(
                                          backgroundColor: Colors.red,
                                          child: Icon(Icons.rotate_right),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            back: GestureDetector(
                              onHorizontalDragStart:
                                  (DragStartDetails dragStartDetails) {
                                setState(() {
                                  N = N - 1;
                                });
                              },
                              child: Card(
                                color: Colors.green,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Text(
                                      "${data.docs[N]['Notes']}",
                                      textAlign: TextAlign.center,
                                    ),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: IconButton(
                                        onPressed: () {
                                          // S("${data.docs[N]['Notes']}");
                                        },
                                        icon: Icon(Icons.play_circle_outline),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 8,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        // right: MediaQuery.of(context).size.width * 0.5,
                                        // bottom: 8,
                                        child: FloatingActionButton(
                                          backgroundColor: Colors.red,
                                          child: Icon(Icons.rotate_right),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      }),
                ),
              ),
              InkWell(
                child: Container(
                  height: 56,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //problem:- cant streach button to specified size
                      Container(
                        height: 56,
                        width: MediaQuery.of(context).size.width / 3,
                        child: MaterialButton(
                          onPressed: () {
                            setState(() {
                              N = N + 1;
                            });
                          },
                          child: Text("Hard"),
                          color: Colors.red,
                        ),
                      ),
                      Container(
                        height: 56,
                        width: MediaQuery.of(context).size.width / 3,
                        child: MaterialButton(
                          onPressed: () {
                            setState(() {
                              N = N + 1;
                            });
                          },
                          child: Text("Normal"),
                          color: Colors.blue,
                        ),
                      ),
                      Container(
                        height: 56,
                        width: MediaQuery.of(context).size.width / 3,
                        child: MaterialButton(
                          onPressed: () {
                            setState(() {
                              N = N + 1;
                            });
                          },
                          child: Text("Easy"),
                          color: Colors.green,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ]),
      )),
    );
  }
}
